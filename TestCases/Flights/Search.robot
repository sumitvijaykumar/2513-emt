
*** Settings ***
Resource      ../../Keywords/common.resource
Resource      ../../Keywords/bus.resource
Suite Setup    Open Application
# Test Setup    Go to Home Page
Test Teardown    Capture Page Screenshot
Suite Teardown    Close All Browsers

*** Test Cases ***

 

Verify Bus count 
...  [Tags]   bus search
    search buses     from=Mumbai    to=Kolhap    date=Mon Dec 02 2024
    ${expectedBusCount}   Get expected sleeper count  
    Select Filter    Seat type     Sleeper
    ${actualBusCount}    Get Number Of Search Results
    Should Be Equal As Integers     ${expectedBusCount}    ${actualBusCount}
