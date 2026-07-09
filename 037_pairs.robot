*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/


*** Test Cases ***

### No success message is expected for this test case, as the activity is not completed. The test case is only to check that the activity can be created and that it can be created offline.
Create activity
    Open Web Application
    Create basic pairs activity    pairs activity    pairs activity instructions

Create offline activity
    Open Web Application
    Go Offline
    Create basic pairs activity    pairs activity    pairs activity instructions