*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Sign in
    Open Web Application
    Maximize Browser Window
    Sign In    test@example.com    password123
    Wait Until Element Is Visible    xpath=//button[.//span[text()='testuser']]    15s

Create activity
    Create empty augmented activity   activité numéro 1

Synchronize activity
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'activity-card__action-button activity-card__action-button--sync')]    15s
    Click Element    xpath=//button[contains(@class, 'activity-card__action-button activity-card__action-button--sync')]
    Sleep    5s
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'activity-card__action-button activity-card__action-button--sync uploaded')]    15s
    Close Browser
