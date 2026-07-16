*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
### Create blank layers activities, both online and offline.
Create activity
    Open Web Application
    Create basic layers activity    layers activity    layers activity instructions

Create offline activity
    Open Web Application
    Go Offline
    Create basic layers activity    layers activity    layers activity instructions

Create activity - Slow 3G
    Open Web Application
    Set Network Speed
    Create basic layers activity    layers activity Slow3G    layers activity instructions

Create offline activity - Slow 3G
    Open Web Application
    Set Network Speed
    Go Offline
    Create basic layers activity    layers activity Slow3G    layers activity instructions
