*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/

*** Test Cases ***
Create activity and share
    Open Web Application
    Sign In    test@example.com   password123
    Create empty augmented activity    activité numéro 1
    
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'activity-card__action-button activity-card__action-button--sync uploaded')]    15s
    Click Element    xpath=//input[contains(@class, 'activity-card__action-button activity-card__action-button--sync uploaded')]

    Wait Until Element Is Visible    xpath=//button[contains(@class, 'cloud-sync-status-modal__sharing-generate-button')]    15s
    Click Element    xpath=//button[contains(@class, 'cloud-sync-status-modal__sharing-generate-button')]

    Wait Until Element Is Visible    xpath=//input[contains(@class, 'ant-btn css-j9bb5n ant-btn-primary ant-btn-dangerous')]    15s
    Click Element    xpath=//input[contains(@class, 'ant-btn css-j9bb5n ant-btn-primary ant-btn-dangerous')]
    Close Browser