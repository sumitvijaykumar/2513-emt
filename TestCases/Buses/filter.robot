*** Settings ***
Resource    ./../../Keywords/common.resource
Resource    ./../../Variables/config.resource
Library    ./../../Libraries/time_1.py

Resource   ./../../Keywords/bus.resource
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
    
  