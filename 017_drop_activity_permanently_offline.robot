*** Settings ***
Library    SeleniumLibrary
Resource       ./ressources.robot

*** Variables ***
${card_id}    value

*** Test Cases ***
create an activity
    Open Web Application without closing
    Maximize Browser Window
    Go Offline
    Create empty augmented activity    activité numéro 1

drop activity
    ${card_id}=    Delete Activity Or Path    activité numéro 1
    Set Suite Variable    ${card_id}
    Sleep    2s

delete activity permanently
    Delete Activity Or Path Permanently    ${card_id}
    Sleep    2s
    Close Browser
