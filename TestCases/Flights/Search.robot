
*** Settings ***
Resource      ../../Keywords/common.resource
Resource      ../../Keywords/flight.resource
Suite Setup    Open Application
Test Setup    Go to Home Page
Test Teardown    Capture Page Screenshot
Suite Teardown    Close All Browsers
Test Template    Verify Stops between cities

*** Test Cases ***
Verify Nonstop Flight Count
    # verify nonstop count
    # go to homepage
    # search flight
    # get the count
    [Tags]    Flight    Nonstop
    Mumba    Thiruva    Nonstop   1
    Chennai    Hyderabad    Nonstop    1
    Delhi    Singapore    Nonstop    3
 
Verify 1-Stop Flight Count
    # verify 1-stop countrobot
    [Tags]    Flight    1-stop
    Coch    Delhi    1-stop    56
 
Verify 2Stop Flight Count    #serially,   parallalyy
    # verify 2+-stop count
    [Tags]    Flight    2stop
    Coch    Thiruva    2+-stop    1