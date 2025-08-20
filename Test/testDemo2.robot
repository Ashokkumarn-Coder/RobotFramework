*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    Dialogs
Test Setup        Open The Browser With The Mortgage Payment Url
#Test Teardown        Close browsr session   #this will executive at the last
Resource        resource.robot

*** Variables ***
${Error_Message_Login}    css:.alert-danger  #create varibales
${Shop_page_load}        css:.nav-link

*** Test Cases ***
#Validate UnSuccessful Login
   # Open The Browser With The Mortgage Payment Url
    #Sleep    10s    # Wait 10 seconds to observe
   #  Fill the login form        ${user_name}     ${password_name}
   #  wait until Element is located in page        ${Error_Message_Login}
    # Sleep    10s    
   #  Verify error message is correct
Validate Cards display in the Shopping Page
    Fill the login form    ${user_name}     ${valid_password}
    wait until Element is located in page        ${Shop_page_load}
    Verify Card titles in the Shop page
    Select the card         iphone X

Select the form and navigate to Child window
    Fill the login details and select the User option


*** Keywords ***
Fill the login form
    [Arguments]      ${user_name}    ${password}
    Input Text       id:username   ${user_name}
    Input Password   id:password   ${password}
    Click Button     signInBtn

wait until Element is located in page
        [arguments]    ${element}
         Wait Until Element Is Visible    ${element}    10s
Verify error message is correct
    ${result}=    Get Text     ${Error_Message_Login}
    Should Be Equal As Strings    ${result}  Incorrect username/password.

Verify Card titles in the Shop page
    @{expectedlist} =    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${elements} =    Get Webelements    css:.card-title
    @{actualList}=     Create List
    FOR    ${element}  IN  @{elements}
        Log    ${element.text}
        Append To List    ${actualList}   ${element.text}
    END
    Lists Should Be Equal    ${expectedlist}       ${actualList}
    
Select the card
    [arguments]        ${cardname}
    ${elements} =    Get Webelements    css:.card-title
    ${index}    Set Variable    1
    FOR    ${element}  IN  @{elements}
        Exit For Loop If   '${cardname}'== '${element.text}'
        ${index}    Evaluate    ${index} + 1
    END
    Click Button      xpath:(//*[@class='card h-100'])[${index}]//button
  #  Pause Execution   Browser open for inspection

Fill the login details and select the User option
    Input Text       id:username   rahulshettyacademy
    Input Password   id:password   learning
    Click Element    css:input[value='user']
    Wait Until Element Is Visible    css:.modal-body  #handling alerts and checkbox
    Click Element    okayBtn
    Click Element    okayBtn
    Wait Until Element Is Not Visible    css:.modal-body
    Select From List By Value    css:select.form-control        teach
    Select Checkbox    terms  # id can be used directly
    Checkbox Should Be Selected    terms
    Pause Execution   Browser open for inspection