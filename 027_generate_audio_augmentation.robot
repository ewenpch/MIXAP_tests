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
    Sleep    5s
    Next button
    Sleep    5s
    Validation button

Add audio to the augmentation
    Add AI Generated Audio To Augmentation

display augmentation
    Sleep    2s
    Wait For Detection Or Log Miss
    Click home button
    Close Browser
