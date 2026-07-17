*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Resource       ./ressources.robot

*** Variables ***
${sharecode}    None
${run_suffix}    value

*** Test Cases ***
Create activity and share as first account
    [Documentation]    Account 1 creates an activity and generates a template share code for it. Uses a freshly signed-up, randomly-generated account instead of one of the shared test accounts, so this run doesn't add to their ever-growing history.
    Open Web Application
    ${username1}=    Generate Random String    10    [LETTERS][NUMBERS]
    Set Suite Variable    ${username1}
    Sign Up    test_${username1}    test_${username1}@example.com    password123
    Sleep    15s
    Go Offline
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__new-activity-btn')]    15s
    ${run_suffix}=    Generate Random String    8    [LETTERS][NUMBERS]
    Set Suite Variable    ${run_suffix}
    Create empty augmented activity    empty activity ${run_suffix}
    Go Online
    Sleep    2s
    Sign Out
    Close Browser

Open Account back to see if activity is there
    [Documentation]    Account 2 imports the activity shared by account 1 using the template share code. Uses a second freshly signed-up, randomly-generated account instead of one of the shared test accounts, so this run doesn't add to their ever-growing history.
    Open Web Application
    Sign In    test_${username1}@example.com    password123
    Wait For Activity    empty activity ${run_suffix}    10s
    Close Browser
