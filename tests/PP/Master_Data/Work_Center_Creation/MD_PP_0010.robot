*** Settings ***
Documentation   Create workcenter in SAP GUI.
Resource    ../resources/keywords/login.robot
Library  RoboSAPiens
Library  SeleniumLibrary
Library  BuiltIn

*** Variables ***
${username}                 BENZARTIA
${password}                 Coficab#2020
${client}                   111
${language}                 EN

*** Test Cases ***
Create Workcenter
    Login to SAP
    Execute Transaction    cr01
    Fill Text Field        Plant    TN30
    Fill Text Field        Work Center              ess10
    Fill Text Field        Work Center Category             0001
    Push Button            Next screen
    Sleep           3s








