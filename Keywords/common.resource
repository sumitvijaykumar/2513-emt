*** Settings ***
Library  SeleniumLibrary
Resource    ../Variables/config.resource

*** Keywords ***

Open Application
    [Documentation]   Description of my keyword.
    ...    THis keyword navigates to the home page.
    ...    It can be used in test setup
    Open Browser        url=${url}    browser=chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //span[@data-cy="closeModal"] 
    Click Element    //span[@data-cy="closeModal"]
    
    # wait until logo is visible

Go to Home Page
    Go To    ${url}
    Wait Until Element Is Visible    //a[@data-cy="mmtLogo"]    timeout=20s