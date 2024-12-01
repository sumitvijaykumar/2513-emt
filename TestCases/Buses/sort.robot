*** Settings ***
Resource    ./../../Keywords/common.resource
Resource    ./../../Variables/config.resource
Resource    ../../Keywords/bus.resource
Suite Setup    Open Application
Test Setup    Go to Home Page    
Suite Teardown    Exit browser






*** Test Cases ***
Verify if rating filter works 
    [Documentation]  
    # ...  steps  
    # ...    1. Open the browser
    # ...    2. Go to the Make My Trip home page 
    # ...    3. Search Bus from Mumbai to Delhi on Sun Dec 01 2024
    # ...    4. Sort the results by Rating
    # ...    5. Store the top rating value in a variable
    # ...    Verification
    # ...     check if the 1st result has the highest rating
    
    search buses    Mumbai    Delhi    Sun Dec 01 2024
    ${expected_TopRatedBus}    Sort Bus Rating    
    #Step 1: sort by rating
    Sort Search Result with    Rating 
    ${actual_TopRatedBus}    Get First Bus Rating       

    #Verification
    Should Be Equal As Strings    first=${expected_TopRatedBus}    second=${actual_TopRatedBus}
    
    




    
