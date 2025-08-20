*** Settings ***
Documentation    To Validate the login form
Library    SeleniumLibrary
Library    Collections
Library    String
Test Setup    Open The Browser With The Mortgage Payment Url
Test Teardown    Close Browser   #this will executive at the last
Resource       resource.robot


*** Variables ***
${Error_Messsage_Login}    css:.alert-danger  #create varibales

*** Test Cases ***
Validate Child Window Functionality
    Select the link of child window
    Verify the user is Switched to child window
    Grab the Email id the Child window
    Switch to Parent Window and enter the Email

*** Keywords ***
Select the link of child window
    Click Element    css:.blinkingText
    Sleep            5
Verify the user is Switched to child window
    Switch Window    NEW
    Element Text Should Be    css:h1    DOCUMENTS REQUEST    #automatically screenshot is taken in robot framework
Grab the Email id the Child window
    ${text}    Get Text    css:.red
    @{words}    Split String    ${text}
    #first time use '@' and second time use ${}
    ${text_split}    Get From List    ${words}    4
    Log   ${text_split}
    @{words_2}    Split String    ${text_split}
    ${email}    Get From List    ${words_2}    0
    Set Global Variable    ${email}
Switch to Parent Window and enter the Email
    Switch Window    MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Input Text       id:username   ${email}