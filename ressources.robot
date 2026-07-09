*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://mixap-lium-preprod.univ-lemans.fr/
${RELATIVE_VIDEO_PATH}    ./assets/fakecamfeed_cortez.mjpeg


*** Keywords ***
Bypass https alert
    [Documentation]    passe l'alerte de certificat https invalide
    Sleep    2
    Click Element    id=details-button
    Sleep    2
    Click Element    id=proceed-link

Set Chrome Options
    [Documentation]    Défini les paramètres du navigateur au besoin décommenter la ligne pour utiliser un flux caméra fictif
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --use-fake-ui-for-media-stream
    Call Method    ${options}    add_argument    --use-fake-device-for-media-stream    #display a fake video if the machine doesnt have any camera
    Call Method    ${options}    add_argument    --use-file-for-fake-video-capture\=${EXECDIR}/assets/fakecamfeed_cortez.y4m
    ${prefs}=    Create Dictionary
    ...    profile.default_content_setting_values.media_stream_camera=1
    ...    profile.default_content_setting_values.media_stream_mic=1
    ...    credentials_enable_service=${False}
    ...    profile.password_manager_enabled=${False}
    ...    profile.password_manager_leak_detection=${False}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Call Method    ${options}    add_argument    --disable-features\=PasswordLeakDetection,LeakDetectionUnauthenticated,PasswordChange
    RETURN    ${options}

Open Web Application
    [Documentation]    ouvre le site avec le navigateur chrome en suivant les paramètres
    ${chrome_options}=    Set Chrome Options
    Close All Browsers
    Open Browser    ${URL}    chrome    options=${CHROME_OPTIONS}
    #Wait Until Element Is Visible    id=details-button    timeout=10s
    #Click Element    id=details-button
    #Wait Until Element Is Visible    id=proceed-link    timeout=10s
    #Click Element    id=proceed-link
    Title Should Be    MIXAP    timeout 10s
    Wait Until Element Is Visible    xpath=//button[text()='New activity']

Open Web Application without closing
    [Documentation]    ouvre le site avec le navigateur chrome en suivant les paramètres
    ${chrome_options}=    Set Chrome Options
    Open Browser    ${URL}    chrome    options=${CHROME_OPTIONS}
    #Wait Until Element Is Visible    id=details-button    timeout=10s
    #Click Element    id=details-button
    #Wait Until Element Is Visible    id=proceed-link    timeout=10s
    #Click Element    id=proceed-link
    Title Should Be    MIXAP    timeout 10s
    Wait Until Element Is Visible    xpath=//button[text()='New activity']

Create Activity
    [Documentation]    clic sur le bouton création d'activité
    Wait Until Keyword Succeeds    3x    2s    Click Element    xpath=//button[text()='New activity']
    Wait Until Element Is Visible    xpath=//div[h3[text()='Augmented activity']]

Create Path
    [Documentation]    clic sur le bouton création de parcours
    Click Element    xpath=//button[text()='New learning path']
    Wait Until Element Is Visible    xpath=//div[h3[text()='Free Exploration Path']]

Next button
    [Documentation]    clic sur le bouton suivant en bas a droite de l'application pour passer a l'étape suivante.
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-primary editor__nav-button editor__nav-button--primary')]   10s
    Click Element    xpath=//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-primary editor__nav-button editor__nav-button--primary')]

Snap the background
    [Documentation]    take the photo of the background used to display medias on
    Sleep    2s
    #Click Element    xpath=//button[div/div[text()='Cliquer ici pour prendre une photo.']]
    Wait Until Element Is Visible    xpath=//span[text()='Take a photo']
    Click Element    xpath=//span[text()='Take a photo']
    Sleep    5s
    Wait Until Element Is Visible    xpath=//button[.//span[text()='Snap']]    20s
    Click Element    xpath=//button[.//span[text()='Snap']]

Use template image
    [Documentation]    use a template image instead of taking a photo
    Sleep    2s
    Wait Until Element Is Visible    xpath=//span[text()='upload image']
    Click Element    xpath=//span[text()='upload image']
    Choose File    xpath=//input[@type='file']    ${EXECDIR}/assets/fakecamfeed_cortez.png
    
Select Activity Type
    [Documentation]    Select the activity type using a parameter
    [Arguments]    ${activity_type}
    Wait Until Element Is Visible    xpath=//div[h3[text()='${activity_type}']]
    #Click Element    xpath=//div[h3[text()='${activity_type}']]
    #Click element using JavaScript to avoid issues with overlapping elements
    Execute JavaScript    Array.from(document.querySelectorAll("h3.activity-menu__card-title")).find(el => el.textContent.trim() === "${activity_type}").click();
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'activity-view__input activity-view__input--title')]

Select Path Type
    [Documentation]    Select the path type using a parameter
    [Arguments]    ${path_type}
    Wait Until Element Is Visible    xpath=//div[h3[text()='${path_type}']]
    #Click Element    xpath=//div[h3[text()='${path_type}']]
    #Click element using JavaScript to avoid issues with overlapping elements
    Execute JavaScript    Array.from(document.querySelectorAll("h3.activity-menu__card-title")).find(el => el.textContent.trim() === "${path_type}").click();
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'activity-view__input activity-view__input--title')]


Validate the image
    [Documentation]    click on the validation button to send the background image
    Wait Until Element Is Visible    xpath=//button[.//span[text()='Save']]     10s
    Click Element    xpath=//button[.//span[text()='Save']]

Validation button
    [Documentation]    click on the validation when rating the background picture
    Wait Until Element Is Visible        xpath=//button[text()='Next']    30s
    Click Element    xpath=//button[text()='Next']

Wait for detection
    [Documentation]    wait for the augementation to be detected using the visibility of instructions
    Wait Until Element Is Not Visible     xpath=//span[contains(text(), 'Place the image in the frame')]    timeout=5s

Click home button
    [Documentation]    Click on the home button using the house icon
    Wait Until Page Contains Element    xpath=//button[contains(@class, 'editor__close-button')]    timeout=5s
    #Click Element    xpath=//button[contains(@class, 'editor__close-button')]
    #Click element using JavaScript to avoid issues with overlapping elements
    Execute JavaScript    document.querySelector("button.editor__close-button").click();

Add Tag to Activity
    [Documentation]    Add a tag to the activity using the provided tag name
    [Arguments]    ${tag_name}
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__labels-btn')]    5s
    Click Element    xpath=//button[contains(@class, 'home__labels-btn')]
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'labels-panel__action-btn')]    5s
    Click Element    xpath=//button[contains(@class, 'labels-panel__action-btn')]
    Input Text    xpath=//input[contains(@class, 'labels-panel__add-name-input')]    ${tag_name}
    Press Keys    xpath=//input[contains(@class, 'ant-select-selection-search-input')]    RETURN
    Click Element    xpath=//button[contains(@class, 'labels-panel__add-submit')]
    Click Element    xpath=//button[contains(@class, 'labels-panel__close')]

Delete Tag from Activity
    [Documentation]    Delete a tag from the activity using the provided tag name
    [Arguments]    ${tag_name}
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__labels-btn')]    5s
    Click Element    xpath=//button[contains(@class, 'home__labels-btn')]
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'labels-panel__chip-icon-btn')]    5s
    Click Element    xpath=//button[contains(@class, 'labels-panel__chip-icon-btn')]
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'confirmation-dialog__button')]    5s
    Click Element    xpath=//button[contains(@class, 'confirmation-dialog__button')]
    Click Element    xpath=//button[contains(@class, 'labels-panel__close')]

Edit Activity Title
    [Arguments]    ${title}
    #Click Element    xpath=//span[@id='title_editor']/div[@role='button']
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'activity-view__input--title')]    5s
    Input Text    xpath=//input[contains(@class, 'activity-view__input--title')]    ${title}
    #Press Keys    xpath=//textarea[not(contains(@style, 'visibility:hidden'))]    RETURN
    Sleep    2    # Manually wait for the text to be updated

Edit Path Title
    [Arguments]    ${title}
    #Click Element    xpath=//span[@id='title_editor']/div[@role='button']
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'activity-view__input--title')]    5s
    Input Text    xpath=//input[contains(@class, 'activity-view__input--title')]    ${title}
    #Press Keys    xpath=//textarea[not(contains(@style, 'visibility:hidden'))]    RETURN
    Sleep    2    # Manually wait for the text to be updated

Edit Activity Instructions
    [Arguments]    ${instructions}
    #Click Element    xpath=//span[@id='instruction_editor']/div[@role='button']
    Wait Until Element Is Visible    xpath=//textarea[contains(@class, 'activity-view__input--instruction')]    5s
    Input Text    xpath=//textarea[contains(@class, 'activity-view__input--instruction')]    ${instructions}
    #Press Keys    xpath=//textarea[not(contains(@style, 'visibility:hidden'))]    RETURN
    Sleep    2    # Manually wait for the text to be updated

Edit Path Instructions
    [Arguments]    ${instructions}
    #Click Element    xpath=//span[@id='instruction_editor']/div[@role='button']
    Wait Until Element Is Visible    xpath=//textarea[contains(@class, 'activity-view__input--instruction')]    5s
    Input Text    xpath=//textarea[contains(@class, 'activity-view__input--instruction')]    ${instructions}
    #Press Keys    xpath=//textarea[not(contains(@style, 'visibility:hidden'))]    RETURN
    Sleep    2    # Manually wait for the text to be updated

Edit Activity Description
    [Documentation]    Edit the activity description using the provided description text
    [Arguments]    ${description}
    Click Element    xpath=//span[@id='description_editor']/div[@role='button']
    Wait Until Element Is Visible    xpath=//textarea[not(contains(@style, 'visibility:hidden'))]    5s
    Execute JavaScript    document.querySelector("textarea:not([style*='visibility:hidden'])").value = "${description}";
    Press Keys    xpath=//textarea[not(contains(@style, 'visibility:hidden'))]    RETURN
    Sleep    2    # Manually wait for the text to be updated

Create empty augmented activity
    [Documentation]    Create an empty augmented activity with a title, snap the background and validate
    [Arguments]    ${title}
    Create Activity
    Select Activity Type    Augmented activity
    Next button
    Sleep    2s
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'activity-view__input--title')]    5s
    Input Text    xpath=//input[contains(@class, 'activity-view__input--title')]    ${title}
    Click Element    xpath=//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-primary editor__nav-button editor__nav-button--primary')]
    Sleep    2s
    Snap the background
    Sleep    5s
    Validate the image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button
    Sleep    2s
    Next button
    Sleep    2s
    ${status}    ${message}=    Run Keyword And Ignore Error    Wait for detection
    Run Keyword If    '${status}' == 'FAIL'    Log    ⚠️ Expected behavior: The element is still visible after 25s miss detection.    WARN
    Click home button

Create empty validation
    [Documentation]    Create an empty validation with a title and instructions, snap the background and validate
    [Arguments]    ${title}    ${instructions}
    Create Activity
    Select Activity Type    Search and Find
    Next button
    Sleep    2s
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'activity-view__input--title')]    5s
    Input Text    xpath=//input[contains(@class, 'activity-view__input--title')]    ${title}
    Wait Until Element Is Visible    xpath=//textarea[contains(@class, 'activity-view__input--instruction')]    5s
    Input Text    xpath=//textarea[contains(@class, 'activity-view__input--instruction')]    ${instructions}
    Click Element    xpath=//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-primary editor__nav-button editor__nav-button--primary')]
    Sleep    2s
    Snap the background
    Sleep    2s
    Validate the image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button
    Sleep    2s
    Next button
    Sleep    5s
    ${status}    ${message}=    Run Keyword And Ignore Error    Wait for detection
    Run Keyword If    '${status}' == 'FAIL'    Log    ⚠️ Expected behavior: The element is still visible after 25s miss detection.    WARN
    Click home button

Create empty path
    [Documentation]    Create an empty path with a title and instructions
    [Arguments]    ${title}=parcours numéro 1
    Create Path
    Select Path Type    Free Exploration Path
    Edit Path Title    ${title}
    Edit Path Instructions    instruction relative au parcours numéro 1
    Next button
    Sleep    2s
    Wait Until Element Is Visible    xpath=//div[h3[contains(@class, 'activity-card__title activity-card__title--large-light') and text()='${title}']]    15s

Go Offline
    [Documentation]    Set the browser to offline mode using Chrome DevTools Protocol (CDP)
    ${seleniumlib}    Get Library Instance    SeleniumLibrary
    VAR    ${webdriver}    ${seleniumlib.driver}
    # SetOffline
    VAR    ${novalue}    0
    ${novalue}    Convert to Integer    ${novalue}
    ${conditions}    Create Dictionary    offline=${True}    latency=${novalue}    downloadThroughput=${novalue}    uploadThroughput=${novalue}
    Call Method    ${webdriver}    execute_cdp_cmd    Network.emulateNetworkConditions    ${conditions}
    Wait Until Element Is Visible    xpath=//button[.//span[contains(@class, 'anticon-disconnect')]]    15s

Click Activity Card
    [Documentation]    Scroll to and click an activity card identified by its title. Retried by its caller since the layout can shift between the scroll and the click on large accounts.
    [Arguments]    ${activity_title}
    Scroll Element Into View    xpath=//div[h3[contains(@class, 'activity-card') and text()='${activity_title}']]
    Click Element    xpath=//div[h3[contains(@class, 'activity-card') and text()='${activity_title}']]

Add Activity to Path
    [Documentation]    Add an activity to the path using the provided activity title. When ${path_title} is given, the drop target is scoped to that specific path's card, which matters when the account has more than one path visible on screen.
    [Arguments]    ${activity_title}    ${path_title}=${EMPTY}
    Wait Until Element Is Visible    xpath=//div[h3[contains(@class, 'activity-card') and text()='${activity_title}']]    15s
    Wait Until Keyword Succeeds    3x    2s    Click Activity Card    ${activity_title}
    IF    '${path_title}' != '${EMPTY}'
        ${drop_target}=    Set Variable    xpath=//h3[contains(@class, 'activity-card') and text()='${path_title}']/ancestor::div[contains(@class, 'activity-card--group')][1]/*[contains(@class,'activity-card__content')]
    ELSE
        ${drop_target}=    Set Variable    xpath=//*[contains(@class,'activity-card--group')]/*[contains(@class,'activity-card__content')]
    END
    Drag And Drop    xpath=//div[h3[contains(@class, 'activity-card') and text()='${activity_title}']]    ${drop_target}
    Sleep    4s

Sign In
    [Documentation]    Sign in to the application using the provided email and password
    [Arguments]    ${email}    ${password}
    Wait Until Element Is Visible    xpath=//button[.//span[contains(@class, 'anticon anticon-user')]]    15s
    Click Element    xpath=//button[.//span[contains(@class, 'anticon anticon-user')]]
    Wait Until Element Is Visible    xpath=//button[text()='Login']    15s
    Click Element    xpath=//button[text()='Login']
    Input Text    xpath=//input[@placeholder='you@company.com']    ${email}
    Input Text    xpath=//input[@placeholder='••••••••']    ${password}
    Click Element    xpath=//button[text()='Continue']
    Sleep    5s

Open Import Modal
    [Documentation]    Click the import button and verify the import modal actually opened. The click is occasionally swallowed by the app, so this is retried by its caller.
    Click Element    xpath=//button[contains(@class, 'home__import-btn')]
    Wait Until Element Is Visible    xpath=//input[@placeholder='Select a share code']    5s

Import Activity
    [Documentation]    Import an activity using the provided code
    [Arguments]    ${code}
    Wait Until Element Is Not Visible    xpath=//*[contains(text(), 'Importing')]    30s
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__import-btn')]    15s
    Wait Until Keyword Succeeds    3x    3s    Open Import Modal
    Click Element    xpath=//input[@placeholder='Select a share code']
    Input Text    xpath=//input[@placeholder='Select a share code']    ${code}
    Click Element    xpath=//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-primary ant-btn-lg ant-btn-block import-modal__button import-modal__button--primary')]

Open Activity Menu And Duplicate
    [Documentation]    Click an activity card's menu button and select "Duplicate". Retried by its caller since a freshly created or duplicated card can take a moment to become fully interactive. The "Duplicate" menu item is clicked via JavaScript, filtered to the one that is actually visible, because Ant Design leaves previous dropdown instances mounted (hidden) in the DOM, which makes a plain xpath match the wrong, invisible one once a second dropdown has been opened.
    [Arguments]    ${activity_title}
    ${card}=    Set Variable    xpath=//h3[contains(@class, 'activity-card') and text()='${activity_title}']/ancestor::div[3]
    Wait Until Element Is Visible    ${card}//button[contains(@class, 'activity-card__menu-button')]    15s
    Wait Until Element Is Not Visible    ${card}//*[contains(text(), 'Sync in progress')]    20s
    Scroll Element Into View    ${card}//button[contains(@class, 'activity-card__menu-button')]
    Click Element    ${card}//button[contains(@class, 'activity-card__menu-button')]
    Sleep    1s
    ${clicked}=    Execute Javascript    var items=[...document.querySelectorAll('.ant-dropdown-menu-title-content')].filter(function(el){return el.textContent.trim()==='Duplicate' && el.offsetParent!==null;}); if(items.length===0){return false;} items[0].click(); return true;
    Should Be True    ${clicked}    Could not find a visible "Duplicate" menu item

Duplicate Activity
    [Documentation]    Duplicate the activity identified by the provided title. Scoped to that specific card (3rd div ancestor of its title) so it does not duplicate the wrong activity when several are visible on screen.
    [Arguments]    ${activity_title}
    Wait Until Keyword Succeeds    3x    2s    Open Activity Menu And Duplicate    ${activity_title}
    Sleep    2s

Create basic search and find activity
    [Documentation]    Create a basic search and find activity with a title, instructions, snap the background and validate
    [Arguments]    ${title}    ${instructions}
    Create Activity
    Select Activity Type    Search and Find
    Next button
    Sleep    2s
    Edit Activity Title    ${title}
    Edit Activity Instructions    ${instructions}
    Click Element    xpath=//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-primary editor__nav-button editor__nav-button--primary')]
    Sleep    2s
    Snap the background
    Sleep    2s
    Validate the image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button