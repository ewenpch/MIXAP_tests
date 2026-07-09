*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/


*** Test Cases ***
Open application and change language
    Open Web Application
    Change Language    Français
    Sleep    5s

Test everything is in French
    Check that the page is in French
    Close Browser