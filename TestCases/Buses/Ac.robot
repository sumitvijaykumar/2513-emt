*** Settings ***
Resource      ../../Keywords/common.resource
Resource      ../../Keywords/flight.resource
Resource      ../../Keywords/bus.resource


Suite Setup    Open Application
Test Setup    Go to Home Page
Test Teardown    Capture Page Screenshot
Suite Teardown    Close All Browsers

*** Test Cases ***

search buses and apply AC filtertype

  search buses   from=Mumbai  to=Kolhapur  date=Sun Dec 01 2024
  Select Filtertypes   filtertype=AC   expectedResult=21