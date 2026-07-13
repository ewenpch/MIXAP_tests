*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Sign in
    Open Web Application
    Maximize Browser Window
    Sign In    test@example.com    password123
    Wait Until Element Is Visible    xpath=//button[.//span[text()='testuser']]    15s
    Close Browser
