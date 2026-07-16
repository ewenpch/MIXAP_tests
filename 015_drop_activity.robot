*** Settings ***
Library    SeleniumLibrary
Resource       ./ressources.robot

*** Test Cases ***
create an activity
    Open Web Application without closing
    Create empty augmented activity    activité numéro 1

drop activity
    Delete Activity Or Path    activité numéro 1
    Sleep    5s
    Close Browser

create an activity - Slow 3G
    Open Web Application without closing
    Set Network Speed
    Create empty augmented activity    activité numéro 1 Slow3G

drop activity - Slow 3G
    Delete Activity Or Path    activité numéro 1 Slow3G
    Sleep    5s
    Close Browser
