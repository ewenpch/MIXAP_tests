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
