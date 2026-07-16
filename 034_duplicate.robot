*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Create empty augmented activity online
    Open Web Application
    Create empty augmented activity    activité numéro 1

Duplicate activity
    Duplicate Activity    activité numéro 1
    Sleep    2s

Check duplicated activity
    ${rows}=    Get WebElements    xpath=//div[contains(@class, 'activity-card__title')]
    ${count}=   Get Length         ${rows}
    Should Be True    ${count} == 2
    Log    Nombre d'activités: ${count} (devrait être 2)
    Close Browser

Create empty augmented activity online - Slow 3G
    Open Web Application
    Set Network Speed
    Create empty augmented activity    activité numéro 1 Slow3G

Duplicate activity - Slow 3G
    Duplicate Activity    activité numéro 1 Slow3G
    Sleep    2s

Check duplicated activity - Slow 3G
    ${rows}=    Get WebElements    xpath=//div[contains(@class, 'activity-card__title')]
    ${count}=   Get Length         ${rows}
    Should Be True    ${count} == 2
    Log    Nombre d'activités: ${count} (devrait être 2)
    Close Browser
