*** Settings ***
Resource    ./../../Keywords/common.resource
Resource    ./../../Variables/config.resource
Library    ./../../Libraries/time_1.py
Resource   ./../../Keywords/bus.resource
Suite Setup    Open Application
Test Setup    Go to Home Page    
Suite Teardown    Exit browser

*** Variables ***

#${url}    https://www.makemytrip.com/bus/search/Mumbai/Kolhapur/02-12-2024?from_code=MMTCC1599&to_code=MMTCC43090
${url}   https://www.makemytrip.com/bus-tickets/
${browser}    Chrome
${xpath}    //div[@class="makeFlex spaceBetween"]//span[2]


*** Test Cases ***
verify the filter for pick up time
   [Documentation]  Checking the functionality of the pick up time 
     #STEPS
     #1.OPEN APPLICATION 
     #2.SEARCH  BUSES
     #3.CHECK FOR THE FILTER FUNCTIONALITY 
     #4.VERIFICATION 

  search buses   from= Thiruvananthapuram    to= Bangalore  date=Sun Dec 01 2024
  #APPLYING FILTER
  Select Filter   heading=Pick up time - Thiruvananthapuram  filterValue=11 AM to 6 PM 
  #verification
  verify filter for pick up time    starttime=11:00 AM  endtime=6:00 PM

  # [Teardown]   Capture Page Screenshot  EMBED



verify Filter-Single seat
    #Open Application
    #Go to Home Page
    search buses    from=mumbai    to=kolhapur    date=Sun Dec 01 2024
    ${count1}    get count of window seat filter
    select filter    Single Seater    Single
    ${count2}    Get count of the number of results
    Should Be Equal    ${count1}    ${count2}
    verification for the window seat-filter
 
    
Verify the pickup point filter  
    [Template]    Verify the pickup point    
    [Documentation]    Checking the functionality of the Pick up point filter, Verifying that the selected pickup point is present in all the bus containers 
    ...    Steps
    ...    1. Open the browser
    ...    2. Go to the URL : "https://www.makemytrip.com/bus-tickets/"
    ...    3. Maximize the browser 
    ...    4. Entering the From location , To location and Date of travel and perform search
    ...    5. Wait until the bus containers appear
    ...    6. Go to the side navbar and click the location you want to filter from the  Pick up point filter menu
    ...    7. Wait for the updated result to appear and perform filtering functionality
    ...    8. Go through all the bus containers and search that the selected pick up location is present in all those containers
    ...    Verification
    ...    9. Verify that pick up location is present in all the containers and END the loop 
    Bang    Hydera    HSR    Pick up point - Bang   



Fetch Top Rated Buses
    #search the buses from mumbai to kolhapur
    #Get all the ratings before clicking top rated
    #Calculate the expected top rating(4.9).Store in the variable expected result
    #Click on top rated icon
    #Get the rating text of the 1st row bus.Store in variable actual result
    #Verification
    #actual result and expecetd result should be same

    
    Open Browser    ${URL}    ${browser}
    Maximize Browser Window
    ${elements}=    Get WebElements    ${XPATH}
    @{ratings}    Create List
    FOR    ${element}    IN    @{elements}
        ${rating}=    Get Text    ${element}
        Append To List    ${ratings}    ${rating}             
    END
    Sort List    list_=${ratings}
    ${expected_rating}    Set Variable    ${ratings}[-1]
    Click Element    //h2[contains(text(),"Top Rated")]/ancestor::div[@class="filter-slider-item false"]


    ${actual_result}    Get Text    ${xpath}
    Log To Console    ${actual_result}  
    [Teardown]     Capture Page Screenshot    EMBED    
    #Verification 
    Should Be Equal    ${actual_result}    second=${expected_rating}  

                           
    Close All Browsers

Verify functionality of Primo bus filter
    [Documentation]    steps 
    ...    Open the browser and click on url to open makeMyTrip website 
    ...    Input two cities and select travel date
    ...    click on search button
    ...    Click on Primo buses filter option 
    ...    Take the count of buses in result after applying filter
    ...    Take number of logos present in result
    ...    Verification - verify that the number of buses with filter is equal to the number of primo icons in the results 
    # Steps
    search buses    Mumbai    Delhi    Sun Dec 01 2024
    Apply Primo bus filter
    ${ExpectedPrimoCount}    Get Number Of Search Results
    ${ActualPrimoCount}    Take Primo logo count in result
    # Verification
    Should Be Equal As Integers    ${ExpectedPrimoCount}    ${ActualPrimoCount}



verify the drop point filter
    [Documentation]   checking the functionality of filter
    ...    maximize the  window 
    ...    wait for the total buses without filtering
    ...    goto leftside navbar and select the location from drop point filter
    ...    wait for the updated result
    ...    for verify- go through all the buscard tab and click on pickups and drops then check for that city in drop points
    ...    verify the city contain in that field
    
    #step 
    Select Filter    
    ...    Drop point            
    ...    Nerul
    
    #verification
    Verify Selected Drop Point Present In Each Bus    
    ...    Nerul
    




verify the drop point filter
    [Documentation]   checking the functionality of filter
    ...    maximize the  window 
    ...    wait for the total buses without filtering
    ...    goto leftside navbar and select the location from drop point filter
    ...    wait for the updated result
    ...    for verify- go through all the buscard tab and click on pickups and drops then check for that city in drop points
    ...    verify the city contain in that field
    
    #step 
    Select Filter    
    ...    Drop point            
    ...    Nerul
    
    #verification
    Verify Selected Drop Point Present In Each Bus    
    ...    Nerul
    





Sort By Arrival
 #sorting bus on the basis of arrival time
 #search bus from mumbai to pune
 #Calculate the arrival time before
 #click arrival button
 #get arrival time after
 #vaerification

  Open Application
  Go to Home Page
  search buses    Mumbai       Pune     Sun Dec 01 2024
   #arrival times before
    ${buslist_before}    SeleniumLibrary.Get WebElements    locator=//span[contains(@class,"font18 blackText")]
   @{arrivalTimes_before}    BuiltIn.Create List
   FOR    ${time}    IN    @{buslist_before}
    ${arrivaltime}    SeleniumLibrary.Get Element Attribute    ${time}    textContent
    Collections.Append To List    ${arrivalTimes_before}    ${arrivaltime}
  END
   Collections.Sort List    list_=${arrivalTimes_before}
   ${minimum_before}    BuiltIn.Set Variable    ${arrivalTimes_before}[0]
   ${maximum_before}    BuiltIn.Set Variable    ${arrivalTimes_before}[-1]

  # Click arrival button
     SeleniumLibrary.Click Element    locator=//li[contains(text(),"Arrival")]   

 #arrival times after
     ${buslist_after}    SeleniumLibrary.Get WebElements    locator=//span[contains(@class,"font18 blackText")]
    @{arrivaltimes_after}    BuiltIn.Create List
    FOR    ${time}    IN    @{buslist_after}
    ${arrivaltime}    SeleniumLibrary.Get Element Attribute    ${time}    textContent
    Append To List    ${arrivaltimes_after}    ${arrivaltime}
    END
     Collections.Sort List    list_=${arrivaltimes_after}
     ${minimum_after}    BuiltIn.Set Variable    ${arrivaltimes_after}[0]
     ${maximum_after}    BuiltIn.Set Variable    ${arrivaltimes_after}[-1]

# Verify arrival times
      BuiltIn.Should Be Equal    ${arrivalTimes_before}    ${arrivaltimes_after}
      Close All Browsers
      


Verify Mydeals in buses
    [Tags]    Bus    Search   
    verify MyDeals    