*** Settings ***
Resource    common.resource
Resource       ../Variables/config.resource
Resource       ../Variables/language/${language}.resource


*** Keywords ***

search buses
    [Arguments]    ${from}    ${to}    
    Click Element    locator=//span[@data-cy="fromCity"]
    Wait Until Element Is Visible    locator=//input[@placeholder="From"] 
    Input Text    locator=//input[@placeholder="From"]    text=${from}
    Wait Until Element Is Visible    locator=(//ul[contains(@class,"autosuggest")]//span[contains(text(),"${from}")])[1]
    Click Element    locator=(//ul[contains(@class,"autosuggest")]//span[contains(text(),"${from}")])[1]

    #Click Element    locator=//span[@data-cy="toCity"]
    #Wait Until Element Is Visible    locator=//input[@placeholder="To"] 
    Input Text    locator=//input[@placeholder="To"]    text=${to}
    Wait Until Element Is Visible    locator=(//ul[contains(@class,"autosuggest")]//span[contains(text(),"${to}")])[1]
    Click Element    locator=(//ul[contains(@class,"autosuggest")]//span[contains(text(),"${to}")])[1]
    Wait Until Element Is Visible    locator=//div[@aria-selected="true"]    timeout=5s
    Click Element    locator=//div[@aria-selected="true"]
    Click Button    locator=search_button




