*** Settings ***
Documentation   Create Production Order and save the numbers in a list.
Resource        ../resources/keywords/login.robot
Library         RoboSAPiens
Library         SeleniumLibrary
Library         BuiltIn
Library         Collections
Library         OperatingSystem

*** Variables ***
${PLANT}                TN30
${MATERIALS}            D07X02490CU
${Qtt}                  500000
${Scrap}                12000
${Start Date}           13.01.2025
${END Date}             31.01.2025
@{ORDER_NUMBERS}        # List to store extracted order numbers

*** Keywords ***
Extract Order Number
    [Arguments]    ${statusbar}
    ${pattern}=    Set Variable    Order number (\d+) saved
    ${match}=      Evaluate    re.search(r"${pattern}", """${statusbar}""").group(1) if re.search(r"${pattern}", """${statusbar}""") else None    modules=re
    Run Keyword If    ${match}    Append To List    ${ORDER_NUMBERS}    ${match}

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
    Sleep                       2s
    Push Button                 Back

*** Test Cases ***
Create Production Orders Repeatedly
    ConnectToRunningSAP
    FOR    ${repeat}    IN RANGE    500
            Create PO          ${MATERIALS}   ${PLANT}    ${Qtt}     ${Scrap}    ${Start Date}       ${END Date}
            ${statusbar}=    Read Statusbar
            Extract Order Number    ${statusbar}
    END
    Log    All Production Orders: @{ORDER_NUMBERS}
    Sleep                       10s
    Push Button    Back
