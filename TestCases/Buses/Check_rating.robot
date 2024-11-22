*** Settings ***
Library    SeleniumLibrary
Library    Collections


*** Variables ***
${XPATH}=    //span[@class="sc-kGXeez bfoMHl"]
${rating}
*** Test Cases ***
Verify if rating filter works 
    [Documentation]  
    ...  steps  
    ...    1. Open the browser
    ...    2. Go to the URL:"https://www.makemytrip.com/bus/search/Mumbai/Delhi/01-12-2024?from_code=MMTCC1599&to_code=MMTCC1199"
    ...    3. Maximize the browser
    ...    4. collect the rating values and sort it
    ...    5. Apply the ratings filter
    ...    6. Store the top rating value in a variable
    ...    Verification
    ...     check if the 1st result has the highest rating
    
    Open Browser    url=https://www.makemytrip.com/bus/search/Mumbai/Delhi/01-12-2024?from_code=MMTCC1599&to_code=MMTCC1199    browser=Chrome
    Maximize Browser Window
    Wait Until Element Is Visible    locator=//p[@class="latoBold secondaryTxt font14"]
    @{ratings}    Create List
    ${elements}=    Get WebElements    ${XPATH}
    FOR    ${element}    IN    @{elements}
        ${rating}=    Get Text    ${element}    
        Log To Console    ${rating}
        Append To List    ${ratings}    ${rating}

    END
    Sort List    list_=${ratings}
    ${length}    Get Length    item=${ratings}
    ${top_rating}    Set Variable    ${ratings}[${length-1}]    
    Log To Console    message=${top_rating}

    Wait Until Element Is Visible    locator=//li[contains(text(),"Rating")]    timeout=5s
    Click Element    locator=//li[contains(text(),"Rating")]
    ${top}    Get Text    locator=(//span[@class="sc-kgoBCf cmFFkp"])[1]
    Should Be Equal As Strings    first=${top_rating}    second=${top}

