*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Create empty association activity
    Open Web Application
    Maximize Browser Window
    Create Activity

Select Type
    Select Activity Type    Pair Association

Edit activity details
    Edit Activity Title    activité numéro 1
    Edit Activity Instructions    instruction relative à l'activité numéro 1
    Next button

Snap the landscape
    Sleep    2s
    Snap the background
    Sleep    2s
    Validate the image
    Sleep    2s

upload the 2nd image
    [Documentation]    upload the 2nd image using button and uploading methods, test could fail if you start them inside the /tests/ folder instead of the main folder due to the path management.
    Wait Until Element Is Visible   xpath=//*[@id="three-canvas"]/div[2]/div/div/div/div[2]/div[2]/div[2]/span/span[1]    15s
    Click Element    xpath=//*[@id="three-canvas"]/div[2]/div/div/div/div[2]/div[2]/div[2]/span/span[1]
    Sleep    5s
    Wait Until Element Is Visible    xpath=//button[.//span[text()='Snap']]    20s
    Click Element    xpath=//button[.//span[text()='Snap']]
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[.//span[text()='Save']]     10s
    Click Element    xpath=//button[.//span[text()='Save']]
    Sleep    2s

validate the media
    Next button
    Sleep    2s
    Validation button     #⚠️sometimes infinite loading may occures without explaination and it may requires to restart the tests
    Sleep    2s
    Next button

display activity
    Sleep    5s
    Wait For Detection Or Log Miss
    Click home button
    Close Browser

Create empty association activity - Slow 3G
    Open Web Application
    Maximize Browser Window
    Set Network Speed
    Create Activity

Select Type - Slow 3G
    Select Activity Type    Pair Association

Edit activity details - Slow 3G
    Edit Activity Title    activité numéro 1 Slow3G
    Edit Activity Instructions    instruction relative à l'activité numéro 1
    Next button

Snap the landscape - Slow 3G
    Sleep    2s
    Snap the background
    Sleep    2s
    Validate the image
    Sleep    2s

upload the 2nd image - Slow 3G
    [Documentation]    upload the 2nd image using button and uploading methods, test could fail if you start them inside the /tests/ folder instead of the main folder due to the path management.
    Wait Until Element Is Visible   xpath=//*[@id="three-canvas"]/div[2]/div/div/div/div[2]/div[2]/div[2]/span/span[1]    15s
    Click Element    xpath=//*[@id="three-canvas"]/div[2]/div/div/div/div[2]/div[2]/div[2]/span/span[1]
    Sleep    5s
    Wait Until Element Is Visible    xpath=//button[.//span[text()='Snap']]    20s
    Click Element    xpath=//button[.//span[text()='Snap']]
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[.//span[text()='Save']]     10s
    Click Element    xpath=//button[.//span[text()='Save']]
    Sleep    2s

validate the media - Slow 3G
    Next button
    Sleep    2s
    Validation button     #⚠️sometimes infinite loading may occures without explaination and it may requires to restart the tests
    Sleep    2s
    Next button

display activity - Slow 3G
    Sleep    5s
    Wait For Detection Or Log Miss
    Click home button
    Close Browser
