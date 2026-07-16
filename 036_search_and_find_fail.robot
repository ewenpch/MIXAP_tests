*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Create activity
    Open Web Application
    Create failed search and find activity    search and find activity    search and find activity instructions

Check for fail message
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'validation-pill')]    15s
    ${message}=    Get Text    xpath=//div[contains(@class, 'validation-pill')]
    Should Be Equal As Strings    ${message}    Too bad!
    Close Browser

Create offline activity
    Open Web Application
    Go Offline
    Create failed search and find activity    search and find activity    search and find activity instructions

Check for fail message offline
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'validation-pill')]    15s
    ${message}=    Get Text    xpath=//div[contains(@class, 'validation-pill')]
    Should Be Equal As Strings    ${message}    Too bad!
    Close Browser

Create activity - Slow 3G
    Open Web Application
    Set Network Speed
    Create failed search and find activity    search and find activity Slow3G    search and find activity instructions

Check for fail message - Slow 3G
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'validation-pill')]    15s
    ${message}=    Get Text    xpath=//div[contains(@class, 'validation-pill')]
    Should Be Equal As Strings    ${message}    Too bad!
    Close Browser

Create offline activity - Slow 3G
    Open Web Application
    Set Network Speed
    Go Offline
    Create failed search and find activity    search and find activity Slow3G    search and find activity instructions

Check for fail message offline - Slow 3G
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'validation-pill')]    15s
    ${message}=    Get Text    xpath=//div[contains(@class, 'validation-pill')]
    Should Be Equal As Strings    ${message}    Too bad!
    Close Browser
