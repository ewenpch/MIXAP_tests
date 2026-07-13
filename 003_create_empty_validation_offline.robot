*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Create empty Search and Find activity offline
    Open Web Application
    Maximize Browser Window
    Go Offline
    Create Activity

Select Type
    Select Activity Type    Search and Find

Edit activity details
    Edit Activity Title    activité numéro 1
    Edit Activity Instructions    instruction relative à l'activité numéro 1

Snap the landscape
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
    Next button
    Sleep    5s
    Wait For Detection Or Log Miss
    Click home button
    Close Browser
