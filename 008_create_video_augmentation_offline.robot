*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Create empty augmented activity offline
    Open Web Application
    Go Offline
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

Add video to the augmentation
    Add Video To Augmentation

display augmentation
    Sleep    2s
    Wait For Detection Or Log Miss
    Click home button
    Close Browser
