*** Settings ***
Library    SeleniumLibrary
Resource       ./ressources.robot

Suite Teardown    Run Keyword And Ignore Error    Close All Browsers

*** Test Cases ***
create an activity
    Open Web Application without closing
    Maximize Browser Window
    Go Offline
    Create empty augmented activity    activité numéro 1

drop activity
    Delete Activity Or Path    activité numéro 1
    Sleep    5s
    Close Browser
