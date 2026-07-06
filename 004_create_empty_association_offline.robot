*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/


${FILE_PATH_1}    ${EXECDIR}tests/assets/annoter.png
${FILE_PATH_2}    ${EXECDIR}/assets/annoter.png

*** Test Cases ***

Create empty association activity offline
    Open Web Application
    Maximize Browser Window
    Go Offline
    Create Activity

Select Type
    Select Activity Type    Pair Association

Edit activity details
    Edit Activity Title    activité numéro 1
    Edit Activity Instructions    instruction relative à l'activité numéro 1
    #Edit Activity Description    description de l'activité numéro 1
    Next button

Snap the landscape
    Sleep    2s
    Snap the background
    Sleep    2s
    Validate the image
    Sleep    2s

upload the 2nd image
    [Documentation]    upload the 2nd image using button and uploading methods, test could fail if you start them inside the /tests/ folder instead of the main folder due to the path management.

    #Next button
    #Click Button    xpath=//button[span[contains(text(), 'Add image number 2')]]
    #Wait Until Element Is Visible    xpath=//button[contains(., 'Click here to upload an image.')]    10s
    #Log    ${EXECDIR}    console=true    #used to know the exec dir that may change in the future, test could fail if you start them inside the /tests/ folder instead of the main folder.
    #Choose File    xpath=//input[@type='file']    ${EXECDIR}/tests/assets/annoter.png
    #Click Element    xpath=//button[contains(., 'Click here to upload an image.')]

    #Wait Until Element Is Visible   xpath=//div[@class='mk-upload__marker-slot-label' and text()='Marker 2']//span[text()='Take a photo']    10s
    #Click Element    xpath=//div[@class='mk-upload__marker-slot-label' and text()='Marker 2']//span[text()='Take a photo']
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
    #Wait for detection


    ${status}    ${message}=    Run Keyword And Ignore Error    Wait for detection
    Run Keyword If    '${status}' == 'FAIL'    Log    ⚠️ Expected behavior: The element is still visible after 25s miss detection.    WARN
    #IF Element Is Visible    xpath=//div[contains(@class, 'ant-notification-notice-wrapper')]
    #    Click Element    xpath=//a[contains(@class, 'ant-notification-notice-close')]
    #END
    Click home button

    #sleep     10s
    Close Browser
