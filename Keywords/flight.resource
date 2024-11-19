*** Variables ***
${browser}    chrome     #firefox
 #en
*** Settings ***
Library        SeleniumLibrary
Resource       ../Variables/config.resource
Resource       ../Variables/language/${language}.resource
Resource    common.resource

*** Keywords ***
Search Flight
    [Arguments]    ${fromCity}    ${toCity}    ${dd}=
    Click Element    FromSector_show
    
    Input Text    a_FromSector_show    ${fromCity}
    Wait Until Element Is Enabled    //div[@id="fromautoFill"]
    Sleep   0.5s
    Click Element    //div[@id="fromautoFill"]/ul/li[1]
 
    Wait Until Page Contains Element    toautoFill_in    timeout=10s
    Sleep   0.2s
    Input Text    a_Editbox13_show    ${toCity}
    Wait Until Element Is Enabled    //div[@id="toautoFill"]    timeout=10s
    Sleep   0.5s
    Click Element    //div[@id="toautoFill"]/ul/li[1]
 
    Wait Until Element Is Visible    dvcalendar    timeout=10s
    ${datexpath}    Set Variable If    "${dd}"==""    
    ...    //li[@class="active-date"]
    ...    //li[@onclick="SelectDate(this.id)" and contains(text(),'${dd}')]
    Wait Until Element Is Visible    ${datexpath}
    Click Element    ${datexpath}
 
    #click on SEarch
    Click Button    //button[@class="srchBtnSe"]

Verify Stops between cities
    [Arguments]    ${fromcity}    ${tocity}    ${stop}    ${expectedResult}
    Search Flight    fromCity=${fromcity}    toCity=${tocity}
    ${stopCount}    Get Flight Count    ${stop}
    Should Be Equal As Integers    ${stopCount}    ${expectedResult}
    [Setup]    Go to Home Page
Get Flight Count
    [Arguments]    ${Stops}
    Wait Until Element Is Not Visible    //div[@class="paperplane"]    timeout=10s
    Wait Until Element Is Visible    //div[@id="ResultDiv"]    timeout=10s
    ${resultXpath}    Set Variable    //div[@id="ResultDiv"]//span[contains(text(),'${Stops}')]
    ${count}    Get Element Count    ${resultXpath}
    RETURN    ${count}