*** Settings ***
Documentation   Create Production Order.
Resource    ../resources/keywords/login.robot
Library  RoboSAPiens
Library  SeleniumLibrary
Library  BuiltIn
Library  Collections


*** Variables ***
${PLANT}                TN30
@{MATERIALS}            YA00501565  YA00355055  YA00350530  YA0050254050  D08X01950CU   D07X01790CU YB00501025  YB00501080  YA02006035  YB0050800025
${Qtt}                  1000000
${Scrap}                24000
${Start Date}           13.01.2025
${END Date}             31.01.2025
@{ORDER_NUMBERS}        # List to store extracted order numbers

*** Keywords ***
Extract Order Number
    [Arguments]    ${statusbar}
    ${pattern}=    Set Variable    Order number (\d+) saved
    ${match}=      Run Keyword If    '${statusbar}' != ''    Evaluate    re.search(r"${pattern}", "${statusbar}").group(1)    modules=re
    Run Keyword If    '${match}' != ''    Append To List    ${ORDER_NUMBERS}    ${match}

Create PO
    [Arguments]        ${Material}    ${Plant}    ${total qtt}   ${scrap qtt}   ${Date of start}   ${Date of end}
    Execute Transaction         CO01
    Fill Text Field             Material            ${Material}
    Fill Text Field             Production Plant    ${Plant}
    Fill Text Field             Planning Plant      ${Plant}
    Push Button                 Continue
    Fill Text Field             Total Order Quantity          ${total qtt}
    Fill Text Field             Total Scrap Quantity in the Order       ${scrap qtt}
    Fill Text Field             End                 ${Date of end}
    Fill Text Field             Start               ${Date of start}
    Push Button                 Release Order
    Push Button                 Choose
    Push Button                 Continue
    Press Key Combination       F5
    Push Button                 Save
    Push Button                 Yes
    Sleep                       2s
    Push Button                 Back


*** Test Cases ***
Create Production Orders
    ConnectToRunningSAP
    ${count}=    Evaluate    len(${MATERIALS})
    FOR    ${index}    IN RANGE    ${count}
        Create PO          ${MATERIALS}[${index}]    ${PLANT}    ${Qtt}     ${Scrap}    ${Start Date}       ${END Date}
        ${statusbar}=    Read Statusbar
        Extract Order Number    ${statusbar}

    END
    Sleep                       10s
    Push Button    Back