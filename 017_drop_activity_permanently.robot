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
    Sleep    2s

delete activity permanently
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'ds-header__download-button') and @title='Trash']    15s
    Click Element    xpath=//button[contains(@class, 'ds-header__download-button') and @title='Trash']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'activity-card__action-button activity-card__action-button--delete activity-card__action-button--danger') and @title='Delete permanently']    15s
    Click Element    xpath=//button[contains(@class, 'activity-card__action-button activity-card__action-button--delete activity-card__action-button--danger') and @title='Delete permanently']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'confirmation-dialog__footer')]//button[text()='Delete']    15s
    Click Element    xpath=//div[contains(@class, 'confirmation-dialog__footer')]//button[text()='Delete']
    Sleep    2s

    Close Browser
