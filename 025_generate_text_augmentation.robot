*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/


*** Test Cases ***
Create empty augementation
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

Add text to the augmentation
    Wait Until Element Is Visible    xpath=//button[@title='AI']    15s
    Click Element    xpath=//button[@title='AI']

    Wait Until Element Is Visible    xpath=//button[@aria-label='Text']    15s
    Execute JavaScript    document.querySelector("button.ant-btn-icon-only[aria-label='Text']").click();
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'ant-input css-j9bb5n ant-input-outlined ds-modal__input') and @placeholder='Ask or describe what to generate…']    5s
    Input Text    xpath=//input[contains(@class, 'ant-input css-j9bb5n ant-input-outlined ds-modal__input') and @placeholder='Ask or describe what to generate…']    Generate a little poem about a cat and a dog playing together in the park.
    Wait Until Element Is Visible    xpath=//button[@aria-label='Generate preview']    15s
    Click Element    xpath=//button[@aria-label='Generate preview']
    Wait Until Element Is Visible    xpath=//button[.//span[@aria-label='plus']]    15s
    Click Element    xpath=//button[.//span[@aria-label='plus']]
    Next button

    Sleep    2s

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
