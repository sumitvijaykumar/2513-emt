*** Settings ***
Resource      ../../Keywords/common.resource
Resource    ../../Keywords/bus.resource
Suite Setup    Open Application
Test Setup    Go to Home Page
Test Teardown    Capture Page Screenshot
Suite Teardown    Close All Browsers

*** Test Cases ***    

Verify Search Buses
    [Tags]    bus    search
    search buses    from=Mumbai    to=Delhi    date=Sun Dec 01 2024