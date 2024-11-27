*** Settings ***
Library  SeleniumLibrary
Resource    ../Variables/config.resource
Library    Collections
*** Keywords ***

Open Application
    [Documentation]   Description of my keyword.
    ...    THis keyword navigates to the home page.
    ...    It can be used in test setup
    Open Browser     url=${url}    browser=${browser}
    Maximize Browser Window
    Wait Until Element Is Visible    locator=//span[@class="commonModal__close"]    timeout=10s
    Click Element    locator=//span[@class="commonModal__close"]
    
    # wait until logo is visible

Go to Home Page
    Go To    ${url}
    Wait Until Element Is Visible    //img[@alt="Make My Trip"]    timeout=10s

Exit browser
    Capture Page Screenshot  EMBED
    Close All Browsers