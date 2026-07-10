*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/


*** Test Cases ***
Open application and create an empty activity - for microphone test
    Open Web Application
    Create Activity
    Select Activity Type    Augmented activity
    Next button
    Sleep    2s
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'activity-view__input--title')]    5s
    Input Text    xpath=//input[contains(@class, 'activity-view__input--title')]    Audio Tool Test
    Click Element    xpath=//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-primary editor__nav-button editor__nav-button--primary')]
    Sleep    2s
    Snap the background
    Sleep    5s
    Validate the image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button
    Sleep    2s

Select the audio tool and use Microphone
    Click Element    xpath=//button[contains(@title, 'Audio')]
    Sleep    2s
    Click Element    xpath=//div[contains(@class, 'auras__popbar')]
    Wait Until Element Is Visible    xpath=(//form[@id='basic']//button[contains(@class,'ant-btn-icon-only')])[2]
    Click Element    xpath=(//form[@id='basic']//button[contains(@class,'ant-btn-icon-only')])[2]
    Wait Until Element Is Visible    xpath=//button[.//*[@data-testid='CircleIcon']]    5s
    Click Element    xpath=//button[.//*[@data-testid='CircleIcon']]
    Sleep    5s
    Click Element    xpath=//button[.//*[@data-testid='PauseIcon']]
    Click Element    xpath=//button[.//*[@data-testid='CheckIcon']]
    Sleep    2s
    Click Element    xpath=//button[.//*[@data-testid='PlayArrowIcon']]
    Sleep    5s
    Close Browser

Open application and create an empty activity - for upload test
    Open Web Application
    Create Activity
    Select Activity Type    Augmented activity
    Next button
    Sleep    2s
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'activity-view__input--title')]    5s
    Input Text    xpath=//input[contains(@class, 'activity-view__input--title')]    Audio Tool Test
    Click Element    xpath=//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-primary editor__nav-button editor__nav-button--primary')]
    Sleep    2s
    Snap the background
    Sleep    5s
    Validate the image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button
    Sleep    2s

Select the audio tool and upload a file
    Click Element    xpath=//button[contains(@title, 'Audio')]
    Sleep    2s
    Click Element    xpath=//div[contains(@class, 'auras__popbar')]
    Choose File    id=basic_file    ${EXECDIR}/assets/moo1.wav
    Sleep    2s
    Click Element    xpath=//div[contains(@class, 'auras__popbar')]
    Sleep    5s
    Close Browser