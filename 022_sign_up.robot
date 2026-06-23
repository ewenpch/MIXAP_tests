*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/
${PATH_TITLE}    parcours numéro 1


*** Test Cases ***
Sign up
    Open Web Application
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//button[.//span[contains(@class, 'anticon anticon-user')]]    15s
    Click Element    xpath=//button[.//span[contains(@class, 'anticon anticon-user')]]
    Wait Until Element Is Visible    xpath=//button[text()='Sign up']    15s
    Click Element    xpath=//button[text()='Sign up']
    Wait Until Element Is Visible    xpath=//input[@placeholder='your_username']    15s
    Input Text    xpath=//input[@placeholder='your_username']    testuser3
    Input Text    xpath=//input[@placeholder='you@company.com']    test3@example.com
    Input Text    xpath=//input[@placeholder='••••••••']    password123
    Click Element    xpath=//button[text()='Create account']
    Sleep    5s
    Wait Until Element Is Visible    xpath=//button[.//span[text()='testuser3']]    15s

    Close Browser
