*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Create activity with tag
    Open Web Application
    Create empty augmented activity    activité numéro 1
    Add Tag to Activity    tag numéro 1

Delete tag from activity
    Delete Tag from Activity    tag numéro 1
    Close Browser

Create activity with tag - Slow 3G
    Open Web Application
    Set Network Speed
    Create empty augmented activity    activité numéro 1 Slow3G
    Add Tag to Activity    tag numéro 1

Delete tag from activity - Slow 3G
    Delete Tag from Activity    tag numéro 1
    Close Browser
