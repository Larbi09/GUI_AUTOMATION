*** Settings ***
Documentation   Updates the material description for a given material and plant in SAP GUI.
Library  RoboSAPiens
Library  SeleniumLibrary
Library  BuiltIn

*** Variables ***
${PLANT}                 TN30
@{MATERIALS}            YB0075056525  YB00755040  YB00755055  D07X01790CU  YB00754500
@{DESCRIPTIONS}         FLRY-B 0.75 WH/BU//GY.  FLRY-B 0.75 RD/GN.  FLRY-B 0.75 RD/BN.  MDW 7x0.179 Copper.  FLRY-B 0.75 OG.
@{ACTUAL_DESCRIPTIONS}  FLRY-B 0.75 WH/BU//GY  FLRY-B 0.75 RD/GN  FLRY-B 0.75 RD/BN  MDW 7x0.179 Copper  FLRY-B 0.75 OG

*** Keywords ***
Update Material Description
    [Arguments]        ${Material}    ${Plant}    ${Description}
    Execute Transaction         MM02
    Fill Text Field             Material   ${Material}
    Push Button                 Continue
    Push Button                 Select All
    Push Button                 Continue
    Fill Text Field             Plant   ${Plant}
    Push Button                 Continue
    Fill Text Field             Material Description      ${Description}
    Push Button                 Save
    Sleep                       5s

*** Test Cases ***
Update Materials Description
    ConnectToRunningSAP
    ${count}=    Evaluate    len(${MATERIALS})
    FOR    ${index}    IN RANGE    ${count}
        Update Material Description    ${MATERIALS}[${index}]    ${PLANT}    ${DESCRIPTIONS}[${index}]
        Update Material Description    ${MATERIALS}[${index}]    ${PLANT}    ${ACTUAL_DESCRIPTIONS}[${index}]
        ${statusbar}=    Read Statusbar
        Log    Status Bar: ${statusbar['message']}
        Should Contain    ${statusbar['message']}    Material ${MATERIALS}[${index}] changed
    END
    Sleep                       10s
    Push Button    Back
