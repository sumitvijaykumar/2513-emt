*** Settings ***
Library  SeleniumLibrary
Resource    ../Variables/config.resource

*** Keywords ***

Open Application
    [Documentation]   Description of my keyword.
    ...    THis keyword navigates to the home page.
    ...    It can be used in test setup
    Open Browser    browser=${browser}
    Maximize Browser Window
    
    # wait until logo is visible

Go to Home Page
    Go To    ${url}
    Wait Until Element Is Visible    //a[@class="emt_logo"]    timeout=20s