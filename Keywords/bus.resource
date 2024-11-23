*** Settings ***
Library        SeleniumLibrary
Resource       ../Variables/config.resource
Resource    common.resource





*** Keywords ***
Search bus
    [Arguments]    ${fromCity}    ${toCity}   

    Click Element    locator=//span[@data-cy="fromCity"]
    Wait Until Element Is Visible    //input[@placeholder="From"]
    Input Text    //input[@placeholder="From"]    ${fromCity}
    Wait Until Element Is Visible    locator=//ul[@class="react-autosuggest__suggestions-list"]//span[contains(text(),'${fromCity}')]
    Click Element    locator=//ul[@class="react-autosuggest__suggestions-list"]//span[contains(text(),'${fromCity}')]


    Wait Until Element Is Visible    locator=//input[@placeholder="To"]
    Input Text    //input[@placeholder="To"]    ${toCity}   
    Wait Until Element Is Visible    //ul[@class="react-autosuggest__suggestions-list"]//span[contains(text(),'${toCity}')]
    Click Element    //ul[@class="react-autosuggest__suggestions-list"]//span[contains(text(),'${toCity}')]
    Wait Until Element Is Visible    //div[@aria-selected="true"]
    Click Element    //div[@aria-selected="true"]
    Click Button    //button[@data-cy="submit"]
    Wait Until Element Is Visible    //p[contains(text(),'found')]




Pickup point 
    [Arguments]    ${pickupPoint}    ${filterName}
    Wait Until Element Is Visible    //div[contains(text(),'${filterName}')]/../..//*[contains(text(),'${pickupPoint}')]
    Click Element    //div[contains(text(),'${filterName}')]/../..//*[contains(text(),'${pickupPoint}')] 
    Sleep    2s
    Wait Until Element Is Visible    //div[@class="busListingContainer"]/following-sibling::*[1]  
    Run Keyword And Ignore Error    Wait Until Element Is Visible    //div[@id='toggle_buses']
     Run Keyword And Ignore Error    Click Element    //div[@id='toggle_buses']
    ${bus_count_element}=  Get Text  //p[contains(text(),'found')]
    ${bus_count}=  Evaluate  '${bus_count_element}'.split(' ')[0]
    Log  Bus Count: ${bus_count}
    Wait Until Element Is Visible    //div[@class="busCardContainer "]//span[text()="Pickups & Drops"]
    FOR    ${index}    IN RANGE    ${bus_count}
        Log    Iteration: ${index}
        Wait Until Element Is Visible    //div[@class="busCardContainer "]//span[text()="Pickups & Drops"]    timeout=10s
        Click Element    //div[@class="busCardContainer "]//span[text()="Pickups & Drops"]    
        Wait Until Element Is Visible    //p[contains(text(),'Pick')]/../ul/li//span[contains(text(),'${pickupPoint}')]    timeout=10s
    END




Verify all the functionalities
    [Arguments]     ${fromCity}    ${toCity}    ${pickupPoint}    ${filterName}    
     Search bus    fromCity=${fromCity}    toCity=${toCity}
    Pickup point    pickupPoint=${pickupPoint}    filterName=${filterName}


