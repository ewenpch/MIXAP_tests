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

Create activity
    Create empty augmented activity   activité numéro 1

Synchronize activity
    Synchronize Activity
    Close Browser
