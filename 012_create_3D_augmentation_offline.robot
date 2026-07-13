*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Create empty augmented activity offline
    Open Web Application
    Maximize Browser Window
    Go Offline
    Create Activity

Select Type
    Select Activity Type    Augmented activity

Edit activity details
    Edit Activity Title    activité numéro 1

Snap the background
    Next button
    Snap the background
    Sleep    5s
    Validate the image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button

Add fbx 3d object to the augmentation
    Add 3D Object To Augmentation    ${EXECDIR}/assets/Tree.fbx    click_next=${False}

Add glb 3d object to the augmentation
    Add 3D Object To Augmentation    ${EXECDIR}/assets/3d_Ingenuity.glb    click_next=${False}

Add obj 3d object to the augmentation
    Add 3D Object To Augmentation    ${EXECDIR}/assets/blender.obj

display augmented activity
    Sleep    2s
    Wait For Detection Or Log Miss
    Click home button
    Close Browser
