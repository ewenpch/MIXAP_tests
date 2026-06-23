*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/
${PATH_TITLE}    parcours numéro 1


*** Test Cases ***
Create 2 activities
    Open Web Application
    Create empty augementation    activité numéro 1
    Create empty augementation    activité numéro 2

Create path
    Create empty path

Add activities to path
    #drag and drop the first activity
    Drag And Drop    xpath=//div[h3[contains(@class, 'activity-card__title ') and text()='activité numéro 1']]    xpath=//div[h3[contains(@class, 'activity-card__title ') and text()='parcours numéro 1']]
    Sleep    2s
    #drag and drop the second activity
    Drag And Drop    xpath=//div[h3[contains(@class, 'activity-card__title ') and text()='activité numéro 2']]    xpath=//div[h3[contains(@class, 'activity-card__title ') and text()='parcours numéro 1']]
    Sleep    2s

    Close Browser
