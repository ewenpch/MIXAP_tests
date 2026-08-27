*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

Suite Teardown    Run Keyword And Ignore Error    Close All Browsers

*** Test Cases ***
Create empty path offline
    Open Web Application
    Maximize Browser Window
    Go Offline
    Create empty path    path_type=Auto-Triggered path
    Close Browser
