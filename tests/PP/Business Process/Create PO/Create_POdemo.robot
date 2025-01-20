*** Settings ***
Documentation   Create Production Order.
Resource    ../resources/keywords/login.robot
Library  RoboSAPiens
Library  SeleniumLibrary
Library  BuiltIn

*** Variables ***
${PLANT}                TN30
@{MATERIALS}            YA00501565  YA00355055  YA00350530  YA0050254050  D08X01950CU   D07X01790CU YB00501025  YB00501080  YA02006035  YB0050800025
${Qtt}                  1000000
${Scrap}                24000
${Start Date}           13.01.2025
${END Date}             31.01.2025

*** Test Cases ***
create po
    ConnectToRunningSAP
    Execute Transaction         CO01
    Fill Text Field             Material            YA00755500
    Fill Text Field             Production Plant    TN30
    Fill Text Field             Planning Plant      TN30
    Push Button                 Continue
    Fill Text Field             Total Order Quantity          1000
    Fill Text Field             Total Scrap Quantity in the Order       24
    Fill Text Field             End                 10.01.2025
    Fill Text Field             Start               10.01.2025
    Push Button                 Release Order
    Push Button                 Choose
    Push Button                 Continue
    Press Key Combination       F5
    Push Button                 Save
    Push Button                 Yes
    Sleep                       5s


