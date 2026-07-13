*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Create empty path
    Open Web Application
    Create empty path    path_type=Guided Path
    Close Browser
