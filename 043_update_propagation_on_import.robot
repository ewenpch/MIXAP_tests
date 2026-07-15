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
    [Documentation]    Account 1 creates an activity and generates a share code for it.
    Open Web Application with alias    compte1
    Sign In    testaccount2@mail.com    password123
    Sleep    15s
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__new-activity-btn')]    15s
    ${run_suffix}=    Generate Random String    8    [LETTERS][NUMBERS]
    Set Suite Variable    ${run_suffix}
    Create empty augmented activity    updated activity ${run_suffix}
    Wait For Activity    activity_title=updated activity ${run_suffix}
    ${sharecode}=    Generate Share Code    activity_title=updated activity ${run_suffix}
    Set Suite Variable    ${sharecode}
    Sleep    5s

Import activity as second account
    [Documentation]    Account 2 imports the activity shared by account 1 using the share code.
    Open Web Application with alias    compte2
    Sign In    test3@example.com    password123
    Import Activity    ${sharecode}
    Sleep    6s

Add text to the activity as first account and resynchronize
    [Documentation]    Back on account 1: reopen the original activity, add a text overlay to it, close the editor and push the update to the cloud.
    Switch Browser    compte1
    Reopen Activity Editor    updated activity ${run_suffix}
    Add Text To Augmentation    sample text    click_next=${False}
    Click home button
    Synchronize Activity
    Sleep    5s
    Close Browser

Verify the text update propagated to the imported copy
    [Documentation]    Back on account 2: reopen the imported copy and check that the text added by account 1 after the import is now present.
    Switch Browser    compte2
    Play Activity    updated activity ${run_suffix}
    Wait Until Element Is Visible    xpath=//textarea[@placeholder='Edit your text...']    15s
    ${text}=    Get Value    xpath=//textarea[@placeholder='Edit your text...']
    Should Be Equal As Strings    ${text}    sample text
