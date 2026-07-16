*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***
${sharecode}    None

*** Test Cases ***
Create activity and share
    Open Web Application
    Sign In    test@example.com   password123
    Sleep    15s
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__new-activity-btn')]    15s
    Create empty augmented activity    activité numéro 1
    ${sharecode}=    Generate Share Code
    Set Suite Variable    ${sharecode}
    Close Browser

Import activity with share code
    Open Web Application
    Sign In    test3@example.com   password123
    Import Activity    ${sharecode}
    Sleep    2s

# No "Close Browser" between this test case and the previous one: read-only imported
# activities are tied to the browser session/machine, not the signed-in account (confirmed
# app behavior). Closing the browser here would delete the imported activity before it can
# be launched below.
Launch imported activity
    Click Element    xpath=//button[contains(@class, 'activity-card__title-arrow-button')]
    Sleep    2s
    Wait For Detection Or Log Miss
    Close Browser

Create activity and share - Slow 3G
    Open Web Application
    Set Network Speed
    Sign In    test@example.com   password123
    Sleep    15s
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__new-activity-btn')]    15s
    Create empty augmented activity    activité numéro 1 Slow3G
    ${sharecode}=    Generate Share Code
    Set Suite Variable    ${sharecode}
    Close Browser

Import activity with share code - Slow 3G
    Open Web Application
    Set Network Speed
    Sign In    test3@example.com   password123
    Import Activity    ${sharecode}
    Sleep    2s

# No "Close Browser" between this test case and the previous one: read-only imported
# activities are tied to the browser session/machine, not the signed-in account (confirmed
# app behavior). Closing the browser here would delete the imported activity before it can
# be launched below.
Launch imported activity - Slow 3G
    Click Element    xpath=//button[contains(@class, 'activity-card__title-arrow-button')]
    Sleep    2s
    Wait For Detection Or Log Miss
    Close Browser
