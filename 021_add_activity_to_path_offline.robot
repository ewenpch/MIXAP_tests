*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

Suite Teardown    Run Keyword And Ignore Error    Close All Browsers

*** Test Cases ***
create activity and path
    Open Web Application without closing
    Maximize Browser Window
    Go Offline
    Create empty augmented activity    activité numéro 1
    Create empty path

put activity in path
    Add Activity to Path    activité numéro 1
    Close Browser
