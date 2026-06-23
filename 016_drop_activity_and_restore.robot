*** Settings ***
Library    SeleniumLibrary
Resource       ./ressources.robot

*** Variables ***
${URL}    https://mixap-lium-preprod.univ-lemans.fr/

*** Test Cases ***
create an activity
    Open Web Application without closing
    Create empty augementation    activité numéro 1

drop activity
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'activity-card__menu-button')]    15s
    Click Element    xpath=//button[contains(@class, 'activity-card__menu-button')]
    Wait Until Element Is Visible    xpath=//span[contains(@class, 'ant-dropdown-menu-title-content') and text()='Delete']    15s
    Click Element    xpath=//span[contains(@class, 'ant-dropdown-menu-title-content') and text()='Delete']
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'confirmation-dialog__footer')]//button[text()='Delete']    15s
    Click Element    xpath=//div[contains(@class, 'confirmation-dialog__footer')]//button[text()='Delete']
    Sleep    5s

restore activity
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'ds-header__download-button') and @title='Trash']    15s
    Click Element    xpath=//button[contains(@class, 'ds-header__download-button') and @title='Trash']
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'activity-card__action-button activity-card__action-button--restore') and @title='Restore']    15s
    Click Element    xpath=//button[contains(@class, 'activity-card__action-button activity-card__action-button--restore') and @title='Restore']
    Sleep    5s

    Close Browser
