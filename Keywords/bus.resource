*** Settings ***
Resource    common.resource
Resource       ../Variables/config.resource
Resource       ../Variables/language/${language}.resource


*** Keywords ***

search buses
    [Arguments]    ${from}    ${to}    ${date}
    Click Element    locator=//span[@data-cy="fromCity"]
    Wait Until Element Is Visible    locator=//input[@placeholder="From"] 
    Input Text    locator=//input[@placeholder="From"]    text=${from}
    Wait Until Element Is Visible    locator=(//ul[contains(@class,"autosuggest")]//span[contains(text(),"${from}")])[1]
    Click Element    locator=(//ul[contains(@class,"autosuggest")]//span[contains(text(),"${from}")])[1]

    #Click Element    locator=//span[@data-cy="toCity"]
    #Wait Until Element Is Visible    locator=//input[@placeholder="To"] 
    Input Text    locator=//input[@placeholder="To"]    text=${to}
    Wait Until Element Is Visible    locator=(//ul[contains(@class,"autosuggest")]//span[contains(text(),"${to}")])[1]
    Click Element    locator=(//ul[contains(@class,"autosuggest")]//span[contains(text(),"${to}")])[1]
    #Wait Until Element Is Visible    locator=//div[@aria-selected="true"]    timeout=5s
    Wait Until Element Is Visible    locator=//div[@class="DayPicker-Day" and @aria-label="${date}"]
    Click Element    locator=//div[@class="DayPicker-Day" and @aria-label="${date}"]

    #Click Element    locator=//div[@aria-selected="true"]
    Click Button    locator=search_button

    ###verification
    ${result}    Get Text    locator=//p[@class="latoBold secondaryTxt font14"]
    Log To Console    message=${result}
      Wait Until Element Is Visible    //p[contains(text(),'found')]


filter for pick up time
  [Arguments]  ${filtertype}   ${timeofpickup}  ${starttime}   ${endtime}
    ${noofbusfound}=   Get Text  //p[contains(text(),'found')]
  Wait Until Element Is Visible  //li[@class="containerHorizontal"]//div[contains(text(),'${filtertype}')]
  Click Element  //div[contains(text(),'${filtertype}')]/ancestor::li[@class="containerHorizontal"]//div[@class="time-filter-option "]/span[contains(text(),'${timeofpickup}')]
  Wait Until Element Is Visible  //div[@class="time-filter-option selected"]
  Sleep  5s
  ${elements} =  Get WebElements   //span[@class="font18 latoBlack blackText appendRight4"]
  @{SORTEDTIME}    Create List 

  FOR  ${element}  IN  @{elements}
   ${time}=  Get Text  ${element}
   
   #${Ntime}=  Convert Time  time=${time} 
  Append To List  ${SORTEDTIME}  ${time} 
  Log To Console  ${time}
  
  END
  Sort List   ${SORTEDTIME}
  Log To Console  ${SORTEDTIME}

  ${starttime_24}    convert_to_24_hour     ${starttime}   
  ${nstarttime_24}=    Replace String    ${starttime_24}    :     ${EMPTY}
  
  ${endtime_24}      convert_to_24_hour    ${endtime}  
    ${nendtime_24}=    Replace String    ${endtime_24}    :     ${EMPTY}


  ${firsttime}  Get From List  list_=${SORTEDTIME}  index=0
  #${timefirst}=  time2.convertstringtotime  ${firsttime}
  ${ntimefirst}=    Replace String    ${firsttime}    :     ${EMPTY}

  #${timefirst}=  Convert To Integer  item=${firsttime}
  ${lasttime}   Get From List   list_=${SORTEDTIME}  index=-1
 # ${Nlasttime}=  time2.Convertstringtotime   ${lasttime}
   ${nlasttime}=    Replace String    ${lasttime}    :     ${EMPTY}
  Should Be True  ${ntimefirst} >= ${nstarttime_24}
    Should Be True  ${nlasttime} <= ${nendtime_24}


#filter-window seat
    [Documentation]      Test case  
    ...    1,open the  browser
    ...    2,enter the link ;  https://www.makemytrip.com/bus/search/Mumbai/Kolhapur/23-11-2024?from_code=MMTCC1599&to_code=MMTCC43090
    ...    3,click on the Single seat filter option
    ...    4,verification 1-verify that the number of buses with filter is equal to the number of buses in the results 
    ...    5,verification 2-verify that all the result have the window/single seat
Get count of window seat filter
      
    ${count1with()}    Get Text     //div[contains(text(),'Single')]/ancestor::li[@class='containerHorizontal']//div[@class="pushRight sc-cHGsZl eGWbUe"]
    ${countwithout(}    Replace String    ${count1with()}    replace_with=${EMPTY}    search_for=(
    ${count1}    Replace String    ${countwithout(}    replace_with=${EMPTY}    search_for=)
    RETURN    ${count1}    

Get count of the number of results
     
    ${count2withstring}    Get Text    //p[@class='latoBold secondaryTxt font14']
    ${count2}    Replace String    string=${count2withstring}    replace_with=${EMPTY}    search_for= buses found
    RETURN    ${count2}

verification for the window seat-filter 
    ${elem}    Get WebElements    //ul[contains(@class, "sc-fjdhpX fXgCif") and contains(string(.), "Window Seats")]   
    ${list}    Create List
    FOR    ${el}     IN     @{elem}
        ${text}    Get Text    ${el}  
        Should Contain    ${text}    item=Window Seats 
        Append To List    ${list}    ${text}
    END   
    # Click Element    //div[contains(text(),'${filter}')]/ancestor::li[@class='containerHorizontal']//span[contains(text(),'${filteroption}')]
    # Wait Until Element Is Visible    //div[contains(@class,"selected ")]
    # Wait Until Element Is Visible    busList


Pickup point 
    [Arguments]    ${filterValue}    

    Wait Until Element Is Visible    //div[@class="busListingContainer"]/following-sibling::*[1]  
    Run Keyword And Ignore Error    Wait Until Element Is Visible    //div[@id='toggle_buses']
    Run Keyword And Ignore Error    Click Element    //div[@id='toggle_buses']
    ${bus_count_element}=  Get Text  //p[contains(text(),'found')]
    ${bus_count}=  Evaluate  '${bus_count_element}'.split(' ')[0]
    Log  Bus Count: ${bus_count}
    Wait Until Element Is Visible    //div[@class="busCardContainer "]//span[text()="Pickups & Drops"]
    FOR    ${index}    IN RANGE    1    ${bus_count}+1
        Log    Iteration: ${index}
        Wait Until Element Is Visible    //div[@class="busCardContainer "]//span[text()="Pickups & Drops"]    timeout=10s
        Click Element    //div[@class="busCardContainer "]//span[text()="Pickups & Drops"]    
        Wait Until Element Is Visible    (//p[contains(text(),'Pick')]/../ul/li//span[contains(text(),'${filterValue}')])[${index}]   timeout=10s
    END




Verify the pickup point 
    [Arguments]     ${fromCity}    ${toCity}    ${heading}    ${filterValue}  

    search buses    fromCity=${fromCity}    toCity=${toCity}    Mon Dec 02 2024
    Select Filter    heading= ${heading}    filterValue=${filterValue}
    Pickup point    filterValue=${filterValue}

Verify Selected Drop Point Present In Each Bus
    [Arguments]    ${dropPointName}    
    ${totalResult}        Get Number Of Search Results
    # ${total}    Evaluate    ${total}+1
    Scroll Element Into View    //div//p[@class="latoBold secondaryTxt font14"]
    Run Keyword And Ignore Error    Click Element    rtc_group_2768197

    Sleep    3s
    FOR    ${index}    IN RANGE    1       ${totalResult}+1
        # Scroll Element Into View     //div[@class="busCardContainer "][${index}]//li/span[@class="appendRight5"][contains(text(),'Pickups')]
        Wait Until Element Is Visible    //div[@class="busCardContainer "]//span[text()='Pickups & Drops']
        Click Element      //div[@class="busCardContainer "]//span[text()='Pickups & Drops']    
        Wait Until Element Is Visible    (//p[contains(text(),'Drop')]/../ul/li//span[contains(text(),'${dropPointName}')])[${index}]      timeout=10s
        # Log    ${index}
    END
    # Log To Console    ${index}



verify MyDeals
    Click Element    //div[@class="filter-slider-item false"]//div[@class="filter-item-dtl"]//h2[contains(text(),'MyDeals')]
    ${totalbuses}    Get Element Count    //div[@class="busListingContainer"]//div[@class="busCardContainer "]    
    Log    ${totalbuses}

#verify this contains something with "Save" 

    FOR    ${index}    IN RANGE    1    ${totalbuses}+1
        
        Wait Until Element Is Visible    //div[@class="filter-slider-item selectedCard"]
        
        Wait Until Page Contains Element    //div[@class="busListingContainer"]//div[@class="busCardContainer "]

        ${Save}    Get Text    //div[@class="busListingContainer"]//div[@class="busCardContainer "][${index}]//span[contains(text(),'Save')]        
    
        Should Contain    ${Save}    Save
        
        Log    ${index}

    END

    Log To Console    ${index}

Verify Selected Drop Point Present In Each Bus
    [Arguments]    ${dropPointName}    
    ${totalResult}        Get Number Of Search Results
    # ${total}    Evaluate    ${total}+1
    Scroll Element Into View    //div//p[@class="latoBold secondaryTxt font14"]
    Run Keyword And Ignore Error    Click Element    rtc_group_2768197

    Sleep    3s
    FOR    ${index}    IN RANGE    1       ${totalResult}+1
        # Scroll Element Into View     //div[@class="busCardContainer "][${index}]//li/span[@class="appendRight5"][contains(text(),'Pickups')]
        Wait Until Element Is Visible    //div[@class="busCardContainer "]//span[text()='Pickups & Drops']
        Click Element      //div[@class="busCardContainer "]//span[text()='Pickups & Drops']    
        Wait Until Element Is Visible    (//p[contains(text(),'Drop')]/../ul/li//span[contains(text(),'${dropPointName}')])[${index}]      timeout=10s
        # Log    ${index}
    END

Verify Selected Drop Point Present In Each Bus
    [Arguments]    ${dropPointName}    
    ${totalResult}        Get Number Of Search Results
    # ${total}    Evaluate    ${total}+1
    Scroll Element Into View    //div//p[@class="latoBold secondaryTxt font14"]
    Run Keyword And Ignore Error    Click Element    rtc_group_2768197

    Sleep    3s
    FOR    ${index}    IN RANGE    1       ${totalResult}+1
        # Scroll Element Into View     //div[@class="busCardContainer "][${index}]//li/span[@class="appendRight5"][contains(text(),'Pickups')]
        Wait Until Element Is Visible    //div[@class="busCardContainer "]//span[text()='Pickups & Drops']
        Click Element      //div[@class="busCardContainer "]//span[text()='Pickups & Drops']    
        Wait Until Element Is Visible    (//p[contains(text(),'Drop')]/../ul/li//span[contains(text(),'${dropPointName}')])[${index}]      timeout=10s
        # Log    ${index}
        END
Sort Bus Rating
    [Arguments]    ${allBusRatings}
    Wait Until Element Is Visible    locator=//p[@class="latoBold secondaryTxt font14"]
    @{ratings}    Create List
    ${elements}=    Get WebElements    ${allBusRatings}
    FOR    ${element}    IN    @{elements}
        ${rating}=    Get Text    ${element}    
        Log To Console    ${rating}
        Append To List    ${ratings}    ${rating}

    END
    Sort List    list_=${ratings}
    ${length}    Get Length    item=${ratings}
    ${top_rating}    Set Variable    ${ratings}[${length-1}]    
    RETURN    ${top_rating}

Sort Search Result with
    [Arguments]    ${sorting_parameter}
    Wait Until Element Is Visible    locator=//li[contains(text(),"${sorting_parameter}")]    timeout=5s
    Click Element    locator=//li[contains(text(),"${sorting_parameter}")]

Get First Bus Rating
    [Arguments]    ${allBusRatings}
    Wait Until Element Is Visible    locator=(${allBusRatings})[1]    timeout=5s
    ${top}    Get Text    locator=(${allBusRatings})[1] 
    RETURN    ${top}

verify MyDeals
    Click Element    //div[@class="filter-slider-item false"]//div[@class="filter-item-dtl"]//h2[contains(text(),'MyDeals')]
    ${totalbuses}    Get Element Count    //div[@class="busListingContainer"]//div[@class="busCardContainer "]    
    Log    ${totalbuses}

#verify this contains something with "Save" 

    FOR    ${index}    IN RANGE    1    ${totalbuses}+1
        
        Wait Until Element Is Visible    //div[@class="filter-slider-item selectedCard"]
        
        Wait Until Page Contains Element    //div[@class="busListingContainer"]//div[@class="busCardContainer "]

        ${Save}    Get Text    //div[@class="busListingContainer"]//div[@class="busCardContainer "][${index}]//span[contains(text(),'Save')]        
    
        Should Contain    ${Save}    Save
        
        Log    ${index}

    END

    Log To Console    ${index}