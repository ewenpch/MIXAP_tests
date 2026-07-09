*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/


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