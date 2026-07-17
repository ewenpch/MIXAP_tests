*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Resource       ./ressources.robot

*** Test Cases ***
Sign in
    [Documentation]    Signs up a freshly-generated random account, signs out, then signs back in with those same credentials to exercise the sign-in flow without relying on one of the shared test accounts.
    Open Web Application
    Maximize Browser Window
    ${username}=    Generate Random String    10    [LETTERS][NUMBERS]
    Sign Up    ${username}    ${username}@example.com    password123
    Wait Until Element Is Visible    xpath=//button[.//span[text()='${username}']]    15s
    Sign Out
    Sign In    ${username}@example.com    password123
    Wait Until Element Is Visible    xpath=//button[.//span[text()='${username}']]    15s
    Close Browser

Sign in - Slow 3G
    [Documentation]    Same as above, under throttled network conditions.
    Open Web Application
    Set Network Speed
    Maximize Browser Window
    ${username}=    Generate Random String    10    [LETTERS][NUMBERS]
    Sign Up    ${username}    ${username}@example.com    password123
    Wait Until Element Is Visible    xpath=//button[.//span[text()='${username}']]    15s
    Sign Out
    Sign In    ${username}@example.com    password123
    Wait Until Element Is Visible    xpath=//button[.//span[text()='${username}']]    15s
    Close Browser
