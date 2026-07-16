*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
### No success message is expected for this test case, as it is a threejs canvas. The test case is only to check that the activity can be created and that it can be created offline.
Create activity
    Open Web Application
    Create basic pairs activity    pairs activity    pairs activity instructions

Create offline activity
    Open Web Application
    Go Offline
    Create basic pairs activity    pairs activity    pairs activity instructions

Create activity - Slow 3G
    Open Web Application
    Set Network Speed
    Create basic pairs activity    pairs activity Slow3G    pairs activity instructions

Create offline activity - Slow 3G
    Open Web Application
    Set Network Speed
    Go Offline
    Create basic pairs activity    pairs activity Slow3G    pairs activity instructions
