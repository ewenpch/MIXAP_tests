*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/


*** Test Cases ***
Create activity
    Open Web Application
    Create basic search and find activity    search and find activity    search and find activity instructions

Check for success message
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'validation-pill')]    15s
    ${message}=    Get Text    xpath=//div[contains(@class, 'validation-pill')]
    Should Be Equal As Strings    ${message}    Well done!