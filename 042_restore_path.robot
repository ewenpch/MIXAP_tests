*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***
${path_id}    value

*** Test Cases ***
Create path
    Open Web Application without closing
    Maximize Browser Window
    Create empty path    title=path activity    instructions=path activity instructions

Drop path
    ${path_id}=    Delete Activity Or Path    path activity
    Set Suite Variable    ${path_id}
    Sleep    5s

Restore path
    Restore Activity Or Path    ${path_id}
    Sleep    5s
    Close Browser

Create path - Slow 3G
    Open Web Application without closing
    Set Network Speed
    Maximize Browser Window
    Create empty path    title=path activity Slow3G    instructions=path activity instructions

Drop path - Slow 3G
    ${path_id}=    Delete Activity Or Path    path activity Slow3G
    Set Suite Variable    ${path_id}
    Sleep    5s

Restore path - Slow 3G
    Restore Activity Or Path    ${path_id}
    Sleep    5s
    Close Browser
