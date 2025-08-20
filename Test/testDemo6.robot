*** Settings ***
Documentation   To validate the Login form
Library     SeleniumLibrary
Library     Collections
Library     ../customLibraries/Shop.py
Test Setup      Open The Browser With The Mortgage Payment Url1
Suite Setup
#suite setup will run first before anything
Suite Teardown
##suite setup will run last  before anything
Test Teardown   Close Browser session
Resource        ../PageObject/Generic.robot
Resource        ../PageObject/LandingPage.robot
Resource        ../PageObject/ShopPage.robot
Resource        ../PageObject/CheckoutPage.robot
Resource        ../PageObject/ConfirmationPage.robot


*** Variables ***
@{listofProducts}           Blackberry      Nokia Edge
${country_name}             India


*** Test Cases ***
#Validate UnSuccesful Login
   #  [Tags]      SMOKE      REGRESSION
   #  LandingPage.Fill the login Form     ${user_name}    ${invalid_password}
  #   LandingPage.wait until Element is located in the page
  #   LandingPage.verify error message is correct



End to end ecommerce Product validation
    [Tags]      REGRESSION
    LandingPage.Fill the login Form     ${user_name}    ${valid_password}
    ShopPage.wait until Element is located in the page
    ShopPage.Verify Card titles in the Shop page
    add items to cart and checkout      ${listofProducts}
    CheckoutPage.Verify items in the Checkout Page and proceed
    ConfirmationPage.Enter the Country and select the terms      ${country_name}
    ConfirmationPage.Purchase the Product and Confirm the Purchase



#Select the Form and navigate to Child window
   # LandingPage.Fill the Login Details and Login Form










































