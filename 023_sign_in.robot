*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/
${PATH_TITLE}    parcours numéro 1


*** Test Cases ***
Sign in
    Open Web Application
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//button[.//span[contains(@class, 'anticon anticon-user')]]    15s
    Click Element    xpath=//button[.//span[contains(@class, 'anticon anticon-user')]]
    Wait Until Element Is Visible    xpath=//button[text()='Login']    15s
    Click Element    xpath=//button[text()='Login']
    Input Text    xpath=//input[@placeholder='you@company.com']    test@example.com
    Input Text    xpath=//input[@placeholder='••••••••']    password123
    Click Element    xpath=//button[text()='Continue']
    Sleep    5s
    Wait Until Element Is Visible    xpath=//button[.//span[text()='testuser']]    15s

    Close Browser
