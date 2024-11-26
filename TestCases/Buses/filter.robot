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



  