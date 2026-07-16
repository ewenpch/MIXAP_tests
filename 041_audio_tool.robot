*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Keywords ***
Create Empty Augmented Activity For Audio Test
    [Documentation]    Create and snap the background of the "Audio Tool Test" activity, stopping right after validation so the audio tool can be exercised without navigating away.
    Open Web Application
    Create Activity
    Select Activity Type    Augmented activity
    Next button
    Sleep    2s
    Edit Activity Title    Audio Tool Test
    Next button
    Sleep    2s
    Snap the background
    Sleep    5s
    Validate the image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button
    Sleep    2s

Create Empty Augmented Activity For Audio Test - Slow 3G
    [Documentation]    Create and snap the background of the "Audio Tool Test Slow3G" activity under throttled network conditions, stopping right after validation so the audio tool can be exercised without navigating away.
    Open Web Application
    Set Network Speed
    Create Activity
    Select Activity Type    Augmented activity
    Next button
    Sleep    2s
    Edit Activity Title    Audio Tool Test Slow3G
    Next button
    Sleep    2s
    Snap the background
    Sleep    5s
    Validate the image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button
    Sleep    2s

*** Test Cases ***
Open application and create an empty activity - for microphone test
    Create Empty Augmented Activity For Audio Test

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
    Play Audio And Verify Playback
    Close Browser

Open application and create an empty activity - for upload test
    Create Empty Augmented Activity For Audio Test

Select the audio tool and upload a file
    Click Element    xpath=//button[contains(@title, 'Audio')]
    Sleep    2s
    Click Element    xpath=//div[contains(@class, 'auras__popbar')]
    Choose File    id=basic_file    ${EXECDIR}/assets/moo1.wav
    Sleep    2s
    Click Element    xpath=//div[contains(@class, 'auras__popbar')]
    Sleep    5s
    Close Browser

Open application and create an empty activity - for microphone test - Slow 3G
    Create Empty Augmented Activity For Audio Test - Slow 3G

Select the audio tool and use Microphone - Slow 3G
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
    Play Audio And Verify Playback
    Close Browser

Open application and create an empty activity - for upload test - Slow 3G
    Create Empty Augmented Activity For Audio Test - Slow 3G

Select the audio tool and upload a file - Slow 3G
    Click Element    xpath=//button[contains(@title, 'Audio')]
    Sleep    2s
    Click Element    xpath=//div[contains(@class, 'auras__popbar')]
    Choose File    id=basic_file    ${EXECDIR}/assets/moo1.wav
    Sleep    2s
    Click Element    xpath=//div[contains(@class, 'auras__popbar')]
    Sleep    5s
    Close Browser
