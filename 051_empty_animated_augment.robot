*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Create empty augmented activity
    Open Web Application
    Create Activity

Select Type
    Select Activity Type    Augmented activity

Edit activity details
    Edit Activity Title    activité numéro 1
    Edit Activity Instructions    instruction relative à l'activité numéro 1

Use animated image
    Next button
    Sleep    2s
    Use template image
    Sleep    2s

display activity
    Next button
    Sleep    2s
    Validation button
    Sleep    2s
    Next button
    Sleep    2s
    Wait For Detection Or Log Miss
    Click home button
    Close Browser

Create empty augmented activity - Slow 3G
    Open Web Application
    Set Network Speed
    Create Activity

Select Type - Slow 3G
    Select Activity Type    Augmented activity

Edit activity details - Slow 3G
    Edit Activity Title    activité numéro 1 Slow3G
    Edit Activity Instructions    instruction relative à l'activité numéro 1

Use animated image - Slow 3G
    Next button
    Sleep    2s
    Use template image
    Sleep    2s

display activity - Slow 3G
    Next button
    Sleep    2s
    Validation button
    Sleep    2s
    Next button
    Sleep    2s
    Wait For Detection Or Log Miss
    Click home button
    Close Browser