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
    Open Web Application with alias    compte1
    ${username1}=    Generate Random String    10    [LETTERS][NUMBERS]
    Sign Up    test_${username1}    test_${username1}@example.com    password123
    Sleep    15s
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__new-activity-btn')]    15s
    ${run_suffix}=    Generate Random String    8    [LETTERS][NUMBERS]
    Set Suite Variable    ${run_suffix}
    Create empty augmented activity    template activity ${run_suffix}
    Wait For Activity    activity_title=template activity ${run_suffix}
    ${sharecode}=    Generate Template Share Code    activity_title=template activity ${run_suffix}
    Set Suite Variable    ${sharecode}
    Sleep    5s

Import activity as second account
    [Documentation]    Account 2 imports the activity shared by account 1 using the template share code. Uses a second freshly signed-up, randomly-generated account instead of one of the shared test accounts, so this run doesn't add to their ever-growing history.
    Open Web Application with alias    compte2
    ${username2}=    Generate Random String    10    [LETTERS][NUMBERS]
    Sign Up    test_${username2}    test_${username2}@example.com    password123
    Import Activity    ${sharecode}
    Sleep    6s

Add text to the activity as first account and resynchronize
    [Documentation]    Back on account 1: reopen the original activity, add a text overlay to it, close the editor and push the update to the cloud.
    Switch Browser    compte1
    Reopen Activity Editor    template activity ${run_suffix}
    Add Text To Augmentation    sample text    click_next=${False}
    Click home button
    Resync Activity
    Sleep    5s
    Close Browser

Verify the text update did NOT propagate to the template copy
    [Documentation]    Back on account 2: a template import is an independent copy, not linked to the original. It should NOT show an "updated recently" badge after account 1's resync, unlike a read-only import (see 043_update_propagation_on_import.robot).
    Switch Browser    compte2
    Sleep    5s
    Page Should Not Contain Element    xpath=//div[contains(@class, 'activity-card__status-badge activity-card__status-badge--updated-recent')]
    Close Browser

Create activity and share as first account - Slow 3G
    [Documentation]    Account 1 creates an activity and generates a template share code for it, under throttled network conditions. Uses a freshly signed-up, randomly-generated account instead of one of the shared test accounts, so this run doesn't add to their ever-growing history.
    Open Web Application with alias    compte1
    Set Network Speed
    ${username1}=    Generate Random String    10    [LETTERS][NUMBERS]
    Sign Up    test_${username1}    test_${username1}@example.com    password123
    Sleep    15s
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__new-activity-btn')]    15s
    ${run_suffix}=    Generate Random String    8    [LETTERS][NUMBERS]
    Set Suite Variable    ${run_suffix}
    Create empty augmented activity    template activity ${run_suffix}
    Wait For Activity    activity_title=template activity ${run_suffix}
    ${sharecode}=    Generate Template Share Code    activity_title=template activity ${run_suffix}
    Set Suite Variable    ${sharecode}
    Sleep    5s

Import activity as second account - Slow 3G
    [Documentation]    Account 2 imports the activity shared by account 1 using the template share code, under throttled network conditions. Uses a second freshly signed-up, randomly-generated account instead of one of the shared test accounts, so this run doesn't add to their ever-growing history.
    Open Web Application with alias    compte2
    Set Network Speed
    ${username2}=    Generate Random String    10    [LETTERS][NUMBERS]
    Sign Up    test_${username2}    test_${username2}@example.com    password123
    Import Activity    ${sharecode}
    Sleep    6s

Add text to the activity as first account and resynchronize - Slow 3G
    [Documentation]    Back on account 1: reopen the original activity, add a text overlay to it, close the editor and push the update to the cloud.
    Switch Browser    compte1
    Reopen Activity Editor    template activity ${run_suffix}
    Add Text To Augmentation    sample text    click_next=${False}
    Click home button
    Resync Activity
    Sleep    5s
    Close Browser

Verify the text update did NOT propagate to the template copy - Slow 3G
    [Documentation]    Back on account 2: a template import is an independent copy, not linked to the original. It should NOT show an "updated recently" badge after account 1's resync, unlike a read-only import (see 043_update_propagation_on_import.robot).
    Switch Browser    compte2
    Sleep    5s
    Page Should Not Contain Element    xpath=//div[contains(@class, 'activity-card__status-badge activity-card__status-badge--updated-recent')]
    Close Browser
