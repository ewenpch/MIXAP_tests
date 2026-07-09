*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/




*** Test Cases ***

### Create blank layers activities, both online and offline.
Create activity
    Open Web Application
    Create basic layers activity    layers activity    layers activity instructions

Create offline activity
    Open Web Application
    Go Offline
    Create basic layers activity    layers activity    layers activity instructions