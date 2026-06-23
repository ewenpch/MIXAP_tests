*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/
${PATH_TITLE}    parcours numéro 1


*** Test Cases ***
Create empty path
    Open Web Application
    Maximize Browser Window
    Go Offline
    Create Path

Select Type
    Select Path Type    Guided Path

Edit path details
    Edit Path Title    ${PATH_TITLE}
    Edit Path Instructions    instruction relative au parcours numéro 1
    #Edit Path Description    description du parcours numéro 1

Save the path
    Next button
    Sleep    2s
    Wait Until Element Is Visible    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='${PATH_TITLE}']]    15s

    Close Browser
