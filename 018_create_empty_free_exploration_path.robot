*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

Suite Teardown    Run Keyword And Ignore Error    Close All Browsers

*** Test Cases ***
Create empty path
    Open Web Application
    Create empty path
    Close Browser

Create empty path - Slow 3G
    Open Web Application
    Set Network Speed
    Create empty path
    Close Browser
