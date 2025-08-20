*** Settings ***
Documentation    To Validate the login form
Library    SeleniumLibrary
#need install sepearate plugins for load thro csv file that is - datadriver
Library    DataDriver        file=resource/data.csv    encoding=utf_8    dialect=unix
Test Teardown    Close Browser   #this will executive at the last
Test Template    Validate UnSuccessful Login

# To know how to parametrize the data - learning
# testcases will change to keywords since it will confuse
*** Variables ***
${Error_Messsage_Login}    css:.alert-danger  #create varibales

*** Test Cases ***
Login with user ${username} and password ${password}        xyc        123456

*** Keywords ***

Validate UnSuccessful Login
    [Arguments]    ${username}    ${password}
    Open The Browser With The Mortgage Payment Url
    #Sleep    10s    # Wait 10 seconds to observe
     Fill the login form      ${username}    ${password}
    # Sleep    10s
     Wait Until it checks and display error messages
     Verify error message is correct

# *** Keywords *** this is removed while parametrising it 
Open The Browser With The Mortgage Payment Url
    Open Browser    https://rahulshettyacademy.com/loginpagePractise/    chrome
    Maximize Browser Window
Fill the login form
    [Arguments]      ${user_name}    ${password}
    Input Text       id:username   ${user_name}
    Input Password   id:password   ${password}
    Click Button     signInBtn
Wait Until it checks and display error messages
    Wait Until Element Is Visible    ${Error_Messsage_Login}
Verify error message is correct
    ${result}=    Get Text     css:.alert-danger
    Should Be Equal As Strings    ${result}  Incorrect username/password.



#for report no need of separate plugins we can use report.html inuilt taking absolute path and see all logs
