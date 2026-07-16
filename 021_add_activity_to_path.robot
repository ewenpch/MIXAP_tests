*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
create activity and path
    Open Web Application without closing
    Create empty augmented activity    activité numéro 1
    Create empty path

put activity in path
    Add Activity to Path    activité numéro 1
    Close Browser

create activity and path - Slow 3G
    Open Web Application without closing
    Set Network Speed
    Create empty augmented activity    activité numéro 1 Slow3G
    Create empty path

put activity in path - Slow 3G
    Add Activity to Path    activité numéro 1 Slow3G
    Close Browser
