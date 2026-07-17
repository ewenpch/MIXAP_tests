*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Resource       ./ressources.robot

*** Test Cases ***
Sign in
    [Documentation]    Uses a freshly signed-up, randomly-generated account instead of one of the shared test accounts, so this run doesn't add to their ever-growing history.
    Open Web Application
    Maximize Browser Window
    ${username}=    Generate Random String    10    [LETTERS][NUMBERS]
    Sign Up    ${username}    ${username}@example.com    password123
    Wait Until Element Is Visible    xpath=//button[.//span[text()='${username}']]    15s

Create activity
    Create empty augmented activity   activité numéro 1

Synchronize activity
    Synchronize Activity
    Close Browser

Sign in - Slow 3G
    [Documentation]    Uses a freshly signed-up, randomly-generated account instead of one of the shared test accounts, so this run doesn't add to their ever-growing history.
    Open Web Application
    Set Network Speed
    Maximize Browser Window
    ${username}=    Generate Random String    10    [LETTERS][NUMBERS]
    Sign Up    ${username}    ${username}@example.com    password123
    Wait Until Element Is Visible    xpath=//button[.//span[text()='${username}']]    15s

Create activity - Slow 3G
    Create empty augmented activity   activité numéro 1 Slow3G

Synchronize activity - Slow 3G
    Synchronize Activity
    Close Browser
