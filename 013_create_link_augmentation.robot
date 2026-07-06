*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/


*** Test Cases ***
Create empty augmented activity
    Open Web Application
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
Add link to the augmentation
    Wait Until Element Is Visible    xpath=//button[@title='Link']    15s
    Click Element    xpath=//button[@title='Link']
    Sleep    2

    Wait Until Element Is Visible    xpath=//h5[contains(text(), 'Click to edit...')]    15s
    Click Element    xpath=//h5[contains(text(), 'Click to edit...')]

    Wait Until Element Is Visible    xpath=//form[@id='basic']//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-text ant-btn-lg ant-btn-icon-only')]    15s
    Click Element    xpath=//form[@id='basic']//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-text ant-btn-lg ant-btn-icon-only')]
    Wait Until Element Is Visible    //input[@placeholder='Enter URL']    15s
    Input Text    //input[@placeholder='Enter URL']    google.com/

    Wait Until Element Is Visible    xpath=//button[.//span[@role='img' and @aria-label='check']]    15s
    Click Element    xpath=//button[.//span[@role='img' and @aria-label='check']]

    Sleep    1s
    Next button

display augmented activity
    Sleep    2s
    ${status}    ${message}=    Run Keyword And Ignore Error    Wait for detection
    Run Keyword If    '${status}' == 'FAIL'    Log    ⚠️ Expected behavior: The element is still visible after 25s miss detection.    WARN
    #IF Element Is Visible    xpath=//div[contains(@class, 'ant-notification-notice-wrapper')]
    #    Click Element    xpath=//a[contains(@class, 'ant-notification-notice-close')]
    #END
    Click home button
    #sleep     20s     #used to watch the result can be commentend if necessary

    Close Browser
