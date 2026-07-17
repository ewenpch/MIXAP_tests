*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Create activity with tag
    Open Web Application
    Go Offline
    Create Activity
    Select Activity Type    activity_type=Augmented activity
    Add Tag to Activity    tag numéro 1

Edit activity details
    Edit Activity Title    activité numéro 1
    Edit Activity Instructions    instruction relative à l'activité numéro 1

Snap the background
    Next button
    Sleep    2s
    Snap the background
    Sleep    2s
    Validate the image

display activity
    Next button
    Sleep    2s
    Validation button
    Sleep    2s
    Next button
    Sleep    2s
    Wait For Detection Or Log Miss
    Click home button

Create empty activity and filter
    Create empty augmented activity    activité numéro 2
    ${activity_number}=    Get Activity Number
    Should Be Equal As Numbers    ${2}    ${activity_number}
    Filter by tag    tag numéro 1
    ${activity_number}=    Get Activity Number
    Should Be Equal As Numbers    ${1}    ${activity_number}
    Close Browser