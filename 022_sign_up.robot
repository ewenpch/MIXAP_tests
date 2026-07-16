*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Sign up
    Open Web Application
    Maximize Browser Window
    Sign Up    testuser3    test3@example.com    password123
    Wait Until Element Is Visible    xpath=//button[.//span[text()='testuser3']]    15s
    Close Browser

Sign up - Slow 3G
    Open Web Application
    Set Network Speed
    Maximize Browser Window
    Sign Up    testuser3    test3@example.com    password123
    Wait Until Element Is Visible    xpath=//button[.//span[text()='testuser3']]    15s
    Close Browser
