
*** Settings ***
Library    SeleniumLibrary
Resource   ../../Keywords/bus.resource
Test Setup    Go to Home Page  
Test Teardown    Close All Browsers
Suite Setup    Open Application   
Test Template    Verify all the functionalities


*** Test Cases ***

Verify the filter functionalities
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
    Bangalore    Mumbai    Majestic    Pick up point - Bang    
    
  
    

    


    