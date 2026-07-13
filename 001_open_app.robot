*** Settings ***
Library    SeleniumLibrary
Resource       ./ressources.robot

*** Test Cases ***
Open Web Application
    Open Web Application Without Fake Media
    Title Should Be    MIXAP
    Sleep    5s   # Attend 5 secondes pour vérifier si la page s'ouvre correctement
    Close All Browsers
