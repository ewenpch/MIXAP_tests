*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Create empty path offline
    Open Web Application
    Maximize Browser Window
    Go Offline
    Create empty path
    Close Browser
