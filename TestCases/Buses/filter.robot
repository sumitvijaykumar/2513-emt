*** Settings ***
Resource    ./../../Keywords/common.resource
Resource    ./../../Variables/config.resource
Library    ./../../Libraries/time_1.py

Resource   ./../../Keywords/bus.resource

*** Variables ***

${url}    https://www.makemytrip.com/bus/search/Mumbai/Kolhapur/02-12-2024?from_code=MMTCC1599&to_code=MMTCC43090
${browser}    Chrome
${xpath}    //div[@class="makeFlex spaceBetween"]//span[2]


*** Test Cases ***
verify the filter for pick up time 
  filter for pick up time  filtertype=Pick up time - Thiruvananthapuram  timeofpickup=11 AM to 6 PM  starttime=11:00 AM  endtime=6:00 PM
Filter verification
    filter-window seat    filter=Single Seater    filteroption=Single
    
Verify the filter functionalities
    [Template]    Verify all the functionalities   
    [Documentation]    Checking the functionality of the Pick up point filter
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
    ...    Verification - verify that the number of buses with filter is equal to the number of primo icons in the results 

    
    Open Browser    url=https://www.makemytrip.com/bus/search/Mumbai/Delhi/01-12-2024?from_code=MMTCC1599&to_code=MMTCC1199    browser=Chrome
    Maximize Browser Window
    # Clicking Primo buses filter
    Click Element    //div[@class="filter-item-dtl"]/h2[contains(text(),"Primo")]
    Wait Until Element Is Enabled    locator=//img[@class="sc-jAaTju hyUDU"]

    # Getting number of buses after applying filter
    ${textVar}    Get Text    //p[contains(text(),"buses found")]
    ${resultBusCount}    Set Variable    ${textVar.replace(' buses found','')}
    Log To Console    ${textVar}
    # Getting primo logo count in result tab
    ${logoCount}    Get Element Count    //div[@class="busListingContainer"]//span[@class="listingSprite newPrimoIcon appendRight24"]
   
    # verification
    Should Be Equal As Integers    ${logoCount}    ${resultBusCount}
    [Teardown]    Capture Page Screenshot    EMBED


verify the drop point filter
    [Documentation]   checking the functionality of filter
    ...    maximize the  window 
    ...    wait for the total buses without filtering
    ...    goto leftside navbar and select the location from drop point filter
    ...    wait for the updated result
    ...    for verify- go through all the buscard tab and click on pickups and drops then check for that city in drop points
    ...    verify the city contain in that field
    # Open Browser    https://www.makemytrip.com/bus/search/Coimbatore/Thiruvananthapuram/24-11-2024?from_code=MMTCC1184&to_code=MMTCC48867
    # ...    browser=chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //div//p[@class="latoBold secondaryTxt font14"]
    Apply drop point filter     filterheading=Drop point    filtervalue=Nerul
