*** Settings ***
Documentation   Create Material Master Record- Basic Data of Type "Finished Good" - In Corporate Plant.
Library  RoboSAPiens
Library  SeleniumLibrary
Library  BuiltIn

*** Variables ***
${PLANT}                TN10

*** Keywords ***

*** Test Cases ***
Create Material
    ConnectToRunningSAP
    Execute Transaction         MM01
    Fill Text Field             Material     2X11Y236NIAGA
    Fill Text Field             Material     2X11Y236NIAGA
