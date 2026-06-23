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
Add sheet to the augmentation
    Wait Until Element Is Visible    xpath=//button[@title='Note']    15s
    Click Element    xpath=//button[@title='Note']
    Sleep    2
    Next button

#TODO edit the sheet, unclickable, try with ids but unable to find which part of the code enhance its behavior
# Log Mouse Coordinates Every Second
#     Log    Starting to log mouse coordinates...
#     Execute JavaScript    document.onmousemove = function(event) { window.mouseX = event.pageX; window.mouseY = event.pageY; };

#     FOR    ${i}    IN RANGE    25    # This will log for 5 seconds. Adjust the range as needed
#     ${mouseX}    Execute JavaScript    return window.innerWidth;
#     ${mouseY}    Execute JavaScript    return window.innerHeight;
#        Log    Mouse Coordinates: X=${mouseX} Y=${mouseY}
#        Sleep    1  # Wait for 1 second
#     END
# temp
#     ${width}    Execute JavaScript    return window.innerWidth;
#     ${height}    Execute JavaScript    return window.innerHeight;
#     ${center_x}    Evaluate    round(${width} / 2)
#     ${center_y}    Evaluate    round(${height} / 2) +50
#     Log    ${center_y}
#     Log    y
#     Log    ${center_x}
#     Log    x
#     #Click Element At Coordinates    xpath=//body     ${center_y}     ${center_x}
#     Sleep    15s

display augementation
    Sleep    2s
    ${status}    ${message}=    Run Keyword And Ignore Error    Wait for detection
    Run Keyword If    '${status}' == 'FAIL'    Log    ⚠️ Expected behavior: The element is still visible after 25s miss detection.    WARN
    #IF Element Is Visible    xpath=//div[contains(@class, 'ant-notification-notice-wrapper')]
    #    Click Element    xpath=//a[contains(@class, 'ant-notification-notice-close')]
    #END
    Click home button
##    sleep     20s     #used to watch the result can be commentend if necessary

    Close Browser
