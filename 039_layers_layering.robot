*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/




*** Test Cases ***

### Create blank layers activities, and add multiple layers, both online and offline.
Create activity
    Open Web Application
    Maximize Browser Window
    Create basic layers activity without validation    layers activity    layers activity instructions
    Add multiple layers
    Furnish layers with content
    Check that all layers are present and contain the expected content

Create offline activity
    Open Web Application
    Go Offline
    Create basic layers activity without validation    layers activity    layers activity instructions
    Add multiple layers
    Furnish layers with content
    Check that all layers are present and contain the expected content