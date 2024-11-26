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






Pickup point 
    [Arguments]    ${pickupPoint}    ${filterName}
    Wait Until Element Is Visible    //div[contains(text(),'${filterName}')]/../..//*[contains(text(),'${pickupPoint}')]
    Click Element    //div[contains(text(),'${filterName}')]/../..//*[contains(text(),'${pickupPoint}')] 
    Sleep    2s
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
        Wait Until Element Is Visible    (//p[contains(text(),'Pick')]/../ul/li//span[contains(text(),'${pickupPoint}')])[${index}]   timeout=10s
    END




Verify all the functionalities
    [Arguments]     ${fromCity}    ${toCity}    ${pickupPoint}    ${filterName}        
     search buses    fromCity=${fromCity}    toCity=${toCity}    Mon Dec 02 2024
    Pickup point    pickupPoint=${pickupPoint}    filterName=${filterName}


