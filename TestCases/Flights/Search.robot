
*** Settings ***
Resource      ../../Keywords/common.resource
Resource      ../../Keywords/flight.resource
Resource    ../../Keywords/bus.resource
Suite Setup    Open Application
# Test Setup    Go to Home Page
Test Teardown    Capture Page Screenshot
Suite Teardown    Close All Browsers
# Test Template    Verify Stops between cities

*** Test Cases ***
# Verify Nonstop Flight Count
#     # verify nonstop count
#     # go to homepage
#     # search flight
#     # get the count
#     [Tags]    Flight    Nonstop
#     Mumba    Thiruva    Nonstop   1
    
 
# Verify 1-Stop Flight Count
#     # verify 1-stop countrobot
#     [Tags]    Flight    1-stop
#     Coch    Delhi    1-stop    54
#      Mumba    Coch    1-stop    32
#     Kolka    Chenn    1-stop    58
    
 
# Verify 2Stop Flight Count    #serially,   parallalyy
#     # verify 2+-stop count
#     [Tags]    Flight    2stop
#     Coch    Thiruva    2+-stop    1

Verify for buses
    [Tags]    bus    search
    search buses    from=Delhi    to=Mumbai

    
    