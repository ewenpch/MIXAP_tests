*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/


*** Test Cases ***
Create empty augementation
    Open Web Application
    Maximize Browser Window
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

Add sticker to the augmentation
    Wait Until Element Is Visible    xpath=//button[@title='Stickers']    15s
    Click Element    xpath=//button[@title='Stickers']

    Wait Until Element Is Visible    xpath=//img[contains(@src, 'image/arrow.png') and contains(@alt, 'Image 0')]    15s
    Click Element    xpath=//img[contains(@src, 'image/arrow.png') and contains(@alt, 'Image 0')]

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
