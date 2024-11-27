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
    
Select Filter
    [Arguments]   ${heading}    ${filterValue}
    Wait Until Element Is Visible    //div//p[@class="latoBold secondaryTxt font14"]
    ${SearchResultBefore}    Get Text    //div//p[@class="latoBold secondaryTxt font14"]
    ${xpath}    Set Variable    //div[contains(text(),'${heading}')]/ancestor::li[@class="containerHorizontal"]//span[contains(text(),'${filterValue}')]
    Wait Until Element Is Visible    ${xpath}
    Click Element    locator=${xpath}
    Run Keyword And Ignore Error  Wait Until Element Is Not Visible   //div//p[contains(text(),'${SearchResultBefore}')]  timeout=2s 
    #TODO: Verifcation  to be done here.

Get Number Of Search Results
    ${string}    Get Text    //div//p[@class="latoBold secondaryTxt font14"]
    ${total}    Evaluate    "${string}".split(" ")[0]
    Log To Console    ${total}
    [Return]  ${total}
    
Exit browser
    Capture Page Screenshot  EMBED
    Close All Browsers