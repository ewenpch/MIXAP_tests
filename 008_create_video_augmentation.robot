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

Snap the background
    Next button
    Snap the background
    Sleep    2s
    Validate the image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button

Add video to the activity
    Add Video To Augmentation

display activity
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

Snap the background - Slow 3G
    Next button
    Snap the background
    Sleep    2s
    Validate the image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button

Add video to the activity - Slow 3G
    Add Video To Augmentation

display activity - Slow 3G
    Sleep    2s
    Wait For Detection Or Log Miss
    Click home button
    Close Browser
