*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/


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
