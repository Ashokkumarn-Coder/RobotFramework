*** Settings ***
Documentation    A resources file with reusable keywords and variables
...             
...              The system specific keywords created here form our own
...              domain specific language.they utilize keywords provided
...              by the imported selenium library
Library          SeleniumLibrary
Library          OperatingSystem

*** Variables ***
${user_name}        rahulshettyacademy
${password_name}    123456789
${valid_password}   learning
${url}              https://rahulshettyacademy.com/loginpagePractise
*** Keywords ***
Open The Browser With The Mortgage Payment Url
    Open Browser    ${url}   chrome
    Maximize Browser Window
Close browsr session
    Close Browser