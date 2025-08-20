*** Settings ***
Library    ../customLibraries/sendmail.py

Suite Teardown    Send Robot Report

*** Variables ***
${SENDER}      akn.ashu96@gmail.com
${PASSWORD}
${RECEIVER}    akn.ashu96@gmail.com
${REPORT_DIR}  ${CURDIR}
*** Test Cases ***
Dummy Test
    Log    Running test suite...


*** Keywords ***
Send Robot Report
    ${files}=    Get Latest Reports    ${REPORT_DIR}
    Send Email Report    ${SENDER}    ${PASSWORD}    ${RECEIVER}    "Automation Report"    "Please find attached execution reports."    ${files}
