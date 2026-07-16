*** Settings ***
Library    SeleniumLibrary
Resource       ./ressources.robot

*** Variables ***
${card_id}    value

*** Test Cases ***
create an activity
    Open Web Application without closing
    Create empty augmented activity    activité numéro 1

drop activity
    ${card_id}=    Delete Activity Or Path    activité numéro 1
    Set Suite Variable    ${card_id}
    Sleep    5s

restore activity
    Restore Activity Or Path    ${card_id}
    Sleep    5s
    Close Browser

create an activity - Slow 3G
    Open Web Application without closing
    Set Network Speed
    Create empty augmented activity    activité numéro 1 Slow3G

drop activity - Slow 3G
    ${card_id}=    Delete Activity Or Path    activité numéro 1 Slow3G
    Set Suite Variable    ${card_id}
    Sleep    5s

restore activity - Slow 3G
    Restore Activity Or Path    ${card_id}
    Sleep    5s
    Close Browser
