*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/

*** Test Cases ***
create 8 activities and 1 path
    Open Web Application without closing
    Quickcreate empty augmented activity   activité numéro 1
    Quickcreate empty augmented activity  activité numéro 2
    Quickcreate empty augmented activity   activité numéro 3
    Quickcreate empty augmented activity   activité numéro 4
    Quickcreate empty augmented activity   activité numéro 5
    Quickcreate empty augmented activity  activité numéro 6
    Quickcreate empty augmented activity   activité numéro 7
    Quickcreate empty augmented activity   activité numéro 8
    Create empty path

select every activity
    Wait Until Element Is Visible    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 1']]    15s
    Click Element    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 1']]
    Wait Until Element Is Visible    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 2']]    15s
    Click Element    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 2']]
    Wait Until Element Is Visible    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 3']]    15s
    Click Element    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 3']]
    Wait Until Element Is Visible    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 4']]    15s
    Click Element    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 4']]
    Wait Until Element Is Visible    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 5']]    15s
    Click Element    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 5']]
    Wait Until Element Is Visible    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 6']]    15s
    Click Element    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 6']]
    Wait Until Element Is Visible    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 7']]    15s
    Click Element    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 7']]
    Wait Until Element Is Visible    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 8']]    15s
    Click Element    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='activité numéro 8']]