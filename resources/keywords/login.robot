*** Settings ***
Library  RoboSAPiens
Library  SeleniumLibrary
Library  BuiltIn

*** Variables ***
${username}                 BENZARTIA
${password}                 Coficab#2020
${client}                   111
${language}                 EN


*** Keywords ***
Login To SAP Logon
    Open SAP        C:\\Program Files (x86)\\SAP\\FrontEnd\\SAPgui\\saplogon.exe
    Sleep           5s
    Connect to Server    QA system
    Sleep           2s
    Fill Text Field    RSYST-MANDT        ${client}
    Fill Text Field    RSYST-BNAME        ${username}
    Fill Text Field    RSYST-BCODE        ${password}
    Fill Text Field    RSYST-LANGU        ${language}
    Press Key Combination    Enter
    Sleep           5s

