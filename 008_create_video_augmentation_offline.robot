*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/


*** Test Cases ***
Create empty augementation
    Open Web Application
    Go Offline
    Create Activity

Select Type
    Select Activity Type    Augmented activity

Edit activity details
    Edit Activity Title    activité numéro 1
    #Edit Activity Instructions    instruction relative à l'activité numéro 1
    #Edit Activity Description    description de l'activité numéro 1

Snap the background
    Next button
    Snap the background
    Sleep    2s
    Validate the image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button
    #Next button

Add video to the augmentation
    Wait Until Element Is Visible    xpath=//button[@title='Video']    15s
    Click Element    xpath=//button[@title='Video']

    Wait Until Element Is Visible    xpath=//div[contains(@class, 'ant-typography') and contains(., 'Click to edit...')]    15s
    Click Element    xpath=//div[contains(@class, 'ant-typography') and contains(., 'Click to edit...')]

    Choose File    xpath=//input[@type='file']    ${EXECDIR}/assets/pexels.mp4

    Next button

display augementation
    Sleep    2s
    ${status}    ${message}=    Run Keyword And Ignore Error    Wait for detection
    Run Keyword If    '${status}' == 'FAIL'    Log    ⚠️ Expected behavior: The element is still visible after 25s miss detection.    WARN
    #IF Element Is Visible    xpath=//div[contains(@class, 'ant-notification-notice-wrapper')]
    #    Click Element    xpath=//a[contains(@class, 'ant-notification-notice-close')]
    #END
    Click home button
#    sleep     20s     #used to watch the result can be commentend if necessary

    Close Browser
