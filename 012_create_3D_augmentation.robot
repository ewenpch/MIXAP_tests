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
    Sleep    5s
    Validate the image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button

Add 3d object to the augmentation
    Add 3D Object To Augmentation    ${EXECDIR}/assets/Tree.fbx

display augmented activity
    Sleep    2s
    Wait For Detection Or Log Miss
    Click home button
    Close Browser
