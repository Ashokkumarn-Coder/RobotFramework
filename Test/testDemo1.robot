*** Settings ***
Library    SeleniumLibrary
Test Teardown    Close Browser   #this will executive at the last


*** Variables ***
${Error_Messsage_Login}    css:.alert-danger  #create varibales

*** Test Cases ***
Validate UnSuccessful Login
    Open The Browser With The Mortgage Payment Url
    #Sleep    10s    # Wait 10 seconds to observe
     Fill the login form
    # Sleep    10s
     Wait Until it checks and display error messages
     Verify error message is correct

*** Keywords ***
Open The Browser With The Mortgage Payment Url
    Open Browser    https://rahulshettyacademy.com/loginpagePractise/    chrome
    Maximize Browser Window
Fill the login form
    Input Text       id:username   rahulshettyacademy
    Input Password   id:password   123456789
    Click Button     signInBtn
Wait Until it checks and display error messages
    Wait Until Element Is Visible    ${Error_Messsage_Login}
Verify error message is correct
    ${result}=    Get Text     css:.alert-danger
    Should Be Equal As Strings    ${result}  Incorrect username/password.
    