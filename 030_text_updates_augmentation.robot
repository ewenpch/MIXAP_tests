*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
Create empty Augmented activity offline
    Open Web Application
    Maximize Browser Window
    Create Activity

Select Type
    Select Activity Type    Augmented activity

Edit activity details
    Edit Activity Title    activité numéro 1

Snap the background
    Next button
    Snap the background
    Sleep    2s
    Validate the image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button

Add text to the augmented activity
    Wait Until Element Is Visible    xpath=//button[@title='Text']    15s
    Click Element    xpath=//button[@title='Text']
    Wait Until Element Is Visible    xpath=//textarea[@placeholder='Edit your text...']    15s
    Click Element    xpath=//textarea[@placeholder='Edit your text...']
    Input Text    xpath=//textarea[@placeholder='Edit your text...']    mon texte par défaut
    Sleep    2s

Change text
    Wait Until Element Is Visible    xpath=//textarea[@placeholder='Edit your text...']    15s
    Click Element    xpath=//textarea[@placeholder='Edit your text...']
    Input Text    xpath=//textarea[@placeholder='Edit your text...']    mon texte modifié

Change text properties to bold
    Sleep    2s
    Mouse Over    xpath=//textarea[@placeholder='Edit your text...']
    Wait Until Element Is Visible    xpath=//button[@value='bold']    15s
    Click Element    xpath=//button[@value='bold']
    Click Element    xpath=//textarea[@placeholder='Edit your text...']

    ${element}=    Get WebElement    xpath=//textarea[@placeholder='Edit your text...']
    ${font_weight}=    Execute Javascript    return window.getComputedStyle(arguments[0]).fontWeight;    ARGUMENTS    ${element}
    Log To Console    font-weight=${font_weight}
    Log    ${font_weight}
    Should Be True    ${font_weight} == 700

Change text properties to italic
    Mouse Over    xpath=//textarea[@placeholder='Edit your text...']
    Wait Until Element Is Visible    xpath=//button[@value='italic']    15s
    Click Element    xpath=//button[@value='italic']
    Click Element    xpath=//textarea[@placeholder='Edit your text...']

    ${element}=    Get WebElement    xpath=//textarea[@placeholder='Edit your text...']
    ${font_weight}=    Execute Javascript    return window.getComputedStyle(arguments[0]).fontStyle;    ARGUMENTS    ${element}
    Log To Console    font-style=${font_weight}
    Log    ${font_weight}
    Should Be True    '${font_weight}'    'italic'

Change text properties to small-caps
    Mouse Over    xpath=//textarea[@placeholder='Edit your text...']
    Wait Until Element Is Visible    xpath=//button[@value='small-caps']    15s
    Click Element    xpath=//button[@value='small-caps']
    Click Element    xpath=//textarea[@placeholder='Edit your text...']

    ${element}=    Get WebElement    xpath=//textarea[@placeholder='Edit your text...']
    ${font_weight}=    Execute Javascript    return window.getComputedStyle(arguments[0]).fontVariant;    ARGUMENTS    ${element}
    Log To Console    font-variant=${font_weight}
    Log    ${font_weight}
    Should Be True    '${font_weight}'    'small-caps'

Change text to normal
    Wait Until Element Is Visible    xpath=//button[@value='normal']    15s

    ${elements}=    Get WebElements    xpath=//button[@value='normal']

    FOR    ${elem}    IN    ${elements}
        Mouse Over    ${elem}
        Click Element    ${elem}
    END

    Sleep    2s

    ${element}=    Get WebElement    xpath=//textarea[@placeholder='Edit your text...']
    ${font_weight}=    Execute Javascript    return window.getComputedStyle(arguments[0]).fontWeight;    ARGUMENTS    ${element}
    Log To Console    font-weight=${font_weight}
    Log    ${font_weight}
    Should Be True    ${font_weight}    400

    ${element}=    Get WebElement    xpath=//textarea[@placeholder='Edit your text...']
    ${font_weight}=    Execute Javascript    return window.getComputedStyle(arguments[0]).fontStyle;    ARGUMENTS    ${element}
    Log To Console    font-style=${font_weight}
    Log    ${font_weight}
    Should Be True    '${font_weight}'    'normal'

    ${element}=    Get WebElement    xpath=//textarea[@placeholder='Edit your text...']
    ${font_weight}=    Execute Javascript    return window.getComputedStyle(arguments[0]).fontVariant;    ARGUMENTS    ${element}
    Log To Console    font-variant=${font_weight}
    Log    ${font_weight}
    Should Be True    '${font_weight}'    'normal'

Create empty Augmented activity offline - Slow 3G
    Open Web Application
    Set Network Speed
    Maximize Browser Window
    Create Activity

Select Type - Slow 3G
    Select Activity Type    Augmented activity

Edit activity details - Slow 3G
    Edit Activity Title    activité numéro 1 Slow3G

Snap the background - Slow 3G
    Next button
    Snap the background
    Sleep    2s
    Validate the image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button

Add text to the augmented activity - Slow 3G
    Wait Until Element Is Visible    xpath=//button[@title='Text']    15s
    Click Element    xpath=//button[@title='Text']
    Wait Until Element Is Visible    xpath=//textarea[@placeholder='Edit your text...']    15s
    Click Element    xpath=//textarea[@placeholder='Edit your text...']
    Input Text    xpath=//textarea[@placeholder='Edit your text...']    mon texte par défaut
    Sleep    2s

Change text - Slow 3G
    Wait Until Element Is Visible    xpath=//textarea[@placeholder='Edit your text...']    15s
    Click Element    xpath=//textarea[@placeholder='Edit your text...']
    Input Text    xpath=//textarea[@placeholder='Edit your text...']    mon texte modifié

Change text properties to bold - Slow 3G
    Sleep    2s
    Mouse Over    xpath=//textarea[@placeholder='Edit your text...']
    Wait Until Element Is Visible    xpath=//button[@value='bold']    15s
    Click Element    xpath=//button[@value='bold']
    Click Element    xpath=//textarea[@placeholder='Edit your text...']

    ${element}=    Get WebElement    xpath=//textarea[@placeholder='Edit your text...']
    ${font_weight}=    Execute Javascript    return window.getComputedStyle(arguments[0]).fontWeight;    ARGUMENTS    ${element}
    Log To Console    font-weight=${font_weight}
    Log    ${font_weight}
    Should Be True    ${font_weight} == 700

Change text properties to italic - Slow 3G
    Mouse Over    xpath=//textarea[@placeholder='Edit your text...']
    Wait Until Element Is Visible    xpath=//button[@value='italic']    15s
    Click Element    xpath=//button[@value='italic']
    Click Element    xpath=//textarea[@placeholder='Edit your text...']

    ${element}=    Get WebElement    xpath=//textarea[@placeholder='Edit your text...']
    ${font_weight}=    Execute Javascript    return window.getComputedStyle(arguments[0]).fontStyle;    ARGUMENTS    ${element}
    Log To Console    font-style=${font_weight}
    Log    ${font_weight}
    Should Be True    '${font_weight}'    'italic'

Change text properties to small-caps - Slow 3G
    Mouse Over    xpath=//textarea[@placeholder='Edit your text...']
    Wait Until Element Is Visible    xpath=//button[@value='small-caps']    15s
    Click Element    xpath=//button[@value='small-caps']
    Click Element    xpath=//textarea[@placeholder='Edit your text...']

    ${element}=    Get WebElement    xpath=//textarea[@placeholder='Edit your text...']
    ${font_weight}=    Execute Javascript    return window.getComputedStyle(arguments[0]).fontVariant;    ARGUMENTS    ${element}
    Log To Console    font-variant=${font_weight}
    Log    ${font_weight}
    Should Be True    '${font_weight}'    'small-caps'

Change text to normal - Slow 3G
    Wait Until Element Is Visible    xpath=//button[@value='normal']    15s

    ${elements}=    Get WebElements    xpath=//button[@value='normal']

    FOR    ${elem}    IN    ${elements}
        Mouse Over    ${elem}
        Click Element    ${elem}
    END

    Sleep    2s

    ${element}=    Get WebElement    xpath=//textarea[@placeholder='Edit your text...']
    ${font_weight}=    Execute Javascript    return window.getComputedStyle(arguments[0]).fontWeight;    ARGUMENTS    ${element}
    Log To Console    font-weight=${font_weight}
    Log    ${font_weight}
    Should Be True    ${font_weight}    400

    ${element}=    Get WebElement    xpath=//textarea[@placeholder='Edit your text...']
    ${font_weight}=    Execute Javascript    return window.getComputedStyle(arguments[0]).fontStyle;    ARGUMENTS    ${element}
    Log To Console    font-style=${font_weight}
    Log    ${font_weight}
    Should Be True    '${font_weight}'    'normal'

    ${element}=    Get WebElement    xpath=//textarea[@placeholder='Edit your text...']
    ${font_weight}=    Execute Javascript    return window.getComputedStyle(arguments[0]).fontVariant;    ARGUMENTS    ${element}
    Log To Console    font-variant=${font_weight}
    Log    ${font_weight}
    Should Be True    '${font_weight}'    'normal'
