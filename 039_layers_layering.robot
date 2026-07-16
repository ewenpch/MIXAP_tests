*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

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

Create activity - Slow 3G
    Open Web Application
    Set Network Speed
    Maximize Browser Window
    Create basic layers activity without validation    layers activity Slow3G    layers activity instructions
    Add multiple layers
    Furnish layers with content
    Check that all layers are present and contain the expected content

Create offline activity - Slow 3G
    Open Web Application
    Set Network Speed
    Go Offline
    Create basic layers activity without validation    layers activity Slow3G    layers activity instructions
    Add multiple layers
    Furnish layers with content
    Check that all layers are present and contain the expected content
