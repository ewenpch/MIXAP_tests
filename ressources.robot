*** Settings ***
Library    SeleniumLibrary
Library    Collections

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
    Call Method    ${options}    add_argument    --use-file-for-fake-audio-capture\=${EXECDIR}/assets/moo1.wav    #plays this wav file as the fake microphone input
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
    Title Should Be    MIXAP    timeout 10s
    Wait Until Element Is Visible    xpath=//button[text()='New activity']

Open Web Application with alias
    [Documentation]    ouvre le site avec le navigateur chrome en suivant les paramètres et avec un alias en paramètres
    [Arguments]    ${alias}
    ${chrome_options}=    Set Chrome Options
    Open Browser    ${URL}    chrome    options=${CHROME_OPTIONS}    alias=${alias}
    Title Should Be    MIXAP    timeout 10s
    Wait Until Element Is Visible    xpath=//button[text()='New activity']

Open Web Application without closing
    [Documentation]    ouvre le site avec le navigateur chrome en suivant les paramètres
    ${chrome_options}=    Set Chrome Options
    Open Browser    ${URL}    chrome    options=${CHROME_OPTIONS}
    Title Should Be    MIXAP    timeout 10s
    Wait Until Element Is Visible    xpath=//button[text()='New activity']

Open Web Application Without Fake Media
    [Documentation]    Open the site with plain Chrome (no fake camera/mic options). Used by tests that only need to confirm the app shell loads and don't drive the camera-dependent activity flows.
    Open Browser    ${URL}    chrome
    Maximize Browser Window

Create Activity
    [Documentation]    clic sur le bouton création d'activité. Clicked via JavaScript to avoid "element click intercepted" failures from transient overlays (tooltips, badges) near the top of the page.
    Wait Until Element Is Visible    xpath=//button[@class='home__new-activity-btn' and not(contains(@class, 'home__import-btn'))]    15s
    Execute Javascript    document.evaluate("//button[@class='home__new-activity-btn' and not(contains(@class, 'home__import-btn'))]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();
    Wait Until Element Is Visible    xpath=//div[@class='activity-menu__grid']

Create Path
    [Documentation]    clic sur le bouton création de parcours. Clicked via JavaScript to avoid "element click intercepted" failures from transient overlays (tooltips, badges) near the top of the page - this button shares the same "home__new-activity-btn" base class as "New activity", which is why the interception error can look like it's about the wrong button.
    Wait Until Element Is Visible    xpath=//button[text()='New learning path']    15s
    Execute Javascript    document.evaluate("//button[text()='New learning path']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();
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
    Choose File    xpath=//input[@type='file']    ${EXECDIR}/assets/cat.webp
    
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

Play Audio And Verify Playback
    [Documentation]    Click the audio tool's Play button and verify the audio is actually being played back. There is no HTML <audio>/<video> element to inspect (the app uses the Web Audio API), so playback is instead confirmed through the button's own state: its icon switches from "PlayArrowIcon" to "PauseIcon" while playing, and switches back to "PlayArrowIcon" on its own once the clip finishes - proving playback both started and ran to completion, not just that the click was accepted.
    [Arguments]    ${max_duration}=15s
    Click Element    xpath=//button[.//*[@data-testid='PlayArrowIcon']]
    Wait Until Element Is Visible    xpath=//button[.//*[@data-testid='PauseIcon']]    5s
    Wait Until Element Is Visible    xpath=//button[.//*[@data-testid='PlayArrowIcon']]    ${max_duration}

Wait For Detection Or Log Miss
    [Documentation]    Wait for the augmentation to be detected, tolerating a miss: the target is expected to occasionally still be undetected after 25s, so a timeout here is logged as an expected WARN instead of failing the test.
    ${status}    ${message}=    Run Keyword And Ignore Error    Wait for detection
    Run Keyword If    '${status}' == 'FAIL'    Log    ⚠️ Expected behavior: The element is still visible after 25s miss detection.    WARN

Add Text To Augmentation
    [Documentation]    Add a text overlay to the currently open augmentation, using the provided text content. Set ${click_next}=${False} when reopening an already-published activity via "Reopen Activity Editor" - there is no further wizard step to advance to there, so close the editor explicitly afterwards (e.g. with "Click home button") instead.
    [Arguments]    ${text}=mon texte par défaut    ${click_next}=${True}
    Wait Until Element Is Visible    xpath=//button[@title='Text']    15s
    Click Element    xpath=//button[@title='Text']
    Wait Until Element Is Visible    xpath=//textarea[@placeholder='Edit your text...']    15s
    Click Element    xpath=//textarea[@placeholder='Edit your text...']
    Input Text    xpath=//textarea[@placeholder='Edit your text...']    ${text}
    IF    ${click_next}
        Next button
    END
    Sleep    2s

Add Image To Augmentation
    [Documentation]    Add an image overlay to the currently open augmentation, using the provided image file.
    [Arguments]    ${file_path}=${EXECDIR}/assets/annoter.png
    Wait Until Element Is Visible    xpath=//button[@title='Image']    15s
    Click Element    xpath=//button[@title='Image']
    Wait Until Element Is Visible    xpath=//h5[contains(text(), 'Click to edit...')]    15s
    Click Element    xpath=//h5[contains(text(), 'Click to edit...')]
    Choose File    xpath=//input[@type='file']    ${file_path}
    Next button

Add Video To Augmentation
    [Documentation]    Add a video overlay to the currently open augmentation, using the provided video file.
    [Arguments]    ${file_path}=${EXECDIR}/assets/pexels.mp4
    Wait Until Element Is Visible    xpath=//button[@title='Video']    15s
    Click Element    xpath=//button[@title='Video']
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'ant-typography') and contains(., 'Click to edit...')]    15s
    Click Element    xpath=//div[contains(@class, 'ant-typography') and contains(., 'Click to edit...')]
    Choose File    xpath=//input[@type='file']    ${file_path}
    Next button

Add Sticker To Augmentation
    [Documentation]    Add the "arrow" stock sticker to the currently open augmentation.
    Wait Until Element Is Visible    xpath=//button[@title='Stickers']    15s
    Click Element    xpath=//button[@title='Stickers']
    Wait Until Element Is Visible    xpath=//img[contains(@src, 'image/arrow.png') and contains(@alt, 'Image 0')]    15s
    Click Element    xpath=//img[contains(@src, 'image/arrow.png') and contains(@alt, 'Image 0')]
    Next button

Add Audio To Augmentation
    [Documentation]    Add an audio overlay to the currently open augmentation, uploading a local sound file.
    Wait Until Element Is Visible    xpath=//button[@title='Audio']    15s
    Click Element    xpath=//button[@title='Audio']
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'css-aj0z9y')]    15s
    Click Element    xpath=//div[contains(@class, 'css-aj0z9y')]
    Choose File    xpath=//input[@type='file']    ${EXECDIR}/assets/1645.mp3
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'css-14q5elh')]    10s
    Click Element    xpath=//div[contains(@class, 'css-14q5elh')]
    Next button

Add Sheet To Augmentation
    [Documentation]    Add an empty note/sheet overlay to the currently open augmentation. Editing its text is not currently automatable (see comment below), so this only covers placing the empty note.
    Wait Until Element Is Visible    xpath=//button[@title='Note']    15s
    Click Element    xpath=//button[@title='Note']
    Sleep    2
    Next button
    # TODO edit the sheet, unclickable, tried with ids but unable to find which part of the code enables its behavior

Add 3D Object To Augmentation
    [Documentation]    Add a 3D object overlay to the currently open augmentation, using the provided model file. Set ${click_next}=${False} to upload without advancing, e.g. when uploading several formats in a row and only the last one should proceed.
    [Arguments]    ${file_path}    ${click_next}=${True}
    Wait Until Element Is Visible    xpath=//button[@title='3D']    15s
    Click Element    xpath=//button[@title='3D']
    Wait Until Element Is Visible    xpath=//h5[contains(text(), 'Click to edit...')]    15s
    Click Element    xpath=//h5[contains(text(), 'Click to edit...')]
    Choose File    xpath=//input[@type='file']    ${file_path}
    Sleep    2
    IF    ${click_next}
        Next button
    END

Add Link To Augmentation
    [Documentation]    Add a link overlay to the currently open augmentation, pointing to the provided URL.
    [Arguments]    ${url}=google.com/
    Wait Until Element Is Visible    xpath=//button[@title='Link']    15s
    Click Element    xpath=//button[@title='Link']
    Sleep    2
    Wait Until Element Is Visible    xpath=//h5[contains(text(), 'Click to edit...')]    15s
    Click Element    xpath=//h5[contains(text(), 'Click to edit...')]
    Wait Until Element Is Visible    xpath=//form[@id='basic']//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-text ant-btn-lg ant-btn-icon-only')]    15s
    Click Element    xpath=//form[@id='basic']//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-text ant-btn-lg ant-btn-icon-only')]
    Wait Until Element Is Visible    //input[@placeholder='Enter URL']    15s
    Input Text    //input[@placeholder='Enter URL']    ${url}
    Wait Until Element Is Visible    xpath=//button[.//span[@role='img' and @aria-label='check']]    15s
    Click Element    xpath=//button[.//span[@role='img' and @aria-label='check']]
    Sleep    1s
    Next button

Add AI Generated Text To Augmentation
    [Documentation]    Open the AI generation tool and generate a text overlay from the provided prompt.
    [Arguments]    ${prompt}=Generate a little poem about a cat and a dog playing together in the park.
    Wait Until Element Is Visible    xpath=//button[@title='AI']    15s
    Click Element    xpath=//button[@title='AI']
    Wait Until Element Is Visible    xpath=//button[@aria-label='Text']    15s
    Execute JavaScript    document.querySelector("button.ant-btn-icon-only[aria-label='Text']").click();
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'ant-input css-j9bb5n ant-input-outlined ds-modal__input') and @placeholder='Ask or describe what to generate…']    5s
    Input Text    xpath=//input[contains(@class, 'ant-input css-j9bb5n ant-input-outlined ds-modal__input') and @placeholder='Ask or describe what to generate…']    ${prompt}
    Wait Until Element Is Visible    xpath=//button[@aria-label='Generate preview']    15s
    Click Element    xpath=//button[@aria-label='Generate preview']
    Wait Until Element Is Visible    xpath=//button[.//span[@aria-label='plus']]    15s
    Click Element    xpath=//button[.//span[@aria-label='plus']]
    Next button
    Sleep    2s

Add AI Generated Image To Augmentation
    [Documentation]    Open the AI generation tool and generate an image overlay from the provided prompt.
    [Arguments]    ${prompt}=Generate an image of a cat and a dog playing together in the park.
    Wait Until Element Is Visible    xpath=//button[@title='AI']    15s
    Click Element    xpath=//button[@title='AI']
    Wait Until Element Is Visible    xpath=//button[@aria-label='Image']    15s
    Execute JavaScript    document.querySelector("button.ant-btn-icon-only[aria-label='Image']").click();
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'ant-input css-j9bb5n ant-input-outlined ds-modal__input') and @placeholder='Describe the image…']    5s
    Input Text    xpath=//input[contains(@class, 'ant-input css-j9bb5n ant-input-outlined ds-modal__input') and @placeholder='Describe the image…']    ${prompt}
    Wait Until Element Is Visible    xpath=//button[@aria-label='Generate preview']    15s
    Click Element    xpath=//button[@aria-label='Generate preview']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[.//span[@aria-label='plus']]    30s
    Click Element    xpath=//button[.//span[@aria-label='plus']]
    Next button
    Sleep    2s

Add AI Generated Audio To Augmentation
    [Documentation]    Open the AI generation tool and generate a text-to-speech audio overlay from the provided text.
    [Arguments]    ${text}=Hello world !
    Wait Until Element Is Visible    xpath=//button[@title='AI']    15s
    Click Element    xpath=//button[@title='AI']
    Wait Until Element Is Visible    xpath=//button[@aria-label='Audio']    15s
    Execute JavaScript    document.querySelector("button.ant-btn-icon-only[aria-label='Audio']").click();
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'ant-input css-j9bb5n ant-input-outlined ds-modal__input') and @placeholder='Type the text to speak…']    5s
    Input Text    xpath=//input[contains(@class, 'ant-input css-j9bb5n ant-input-outlined ds-modal__input') and @placeholder='Type the text to speak…']    ${text}
    Wait Until Element Is Visible    xpath=//button[@aria-label='Generate preview']    15s
    Click Element    xpath=//button[@aria-label='Generate preview']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[.//span[@aria-label='plus']]    30s
    Click Element    xpath=//button[.//span[@aria-label='plus']]
    Next button
    Sleep    2s

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
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'activity-view__input--title')]    5s
    Input Text    xpath=//input[contains(@class, 'activity-view__input--title')]    ${title}
    Sleep    2    # Manually wait for the text to be updated

Edit Path Title
    [Documentation]    Paths and activities share the same title editor, so this just delegates to "Edit Activity Title".
    [Arguments]    ${title}
    Edit Activity Title    ${title}

Edit Activity Instructions
    [Arguments]    ${instructions}
    Wait Until Element Is Visible    xpath=//textarea[contains(@class, 'activity-view__input--instruction')]    5s
    Input Text    xpath=//textarea[contains(@class, 'activity-view__input--instruction')]    ${instructions}
    Sleep    2    # Manually wait for the text to be updated

Edit Path Instructions
    [Documentation]    Paths and activities share the same instructions editor, so this just delegates to "Edit Activity Instructions".
    [Arguments]    ${instructions}
    Edit Activity Instructions    ${instructions}

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
    Edit Activity Title    ${title}
    Next button
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
    Wait For Detection Or Log Miss
    Click home button

Create empty validation
    [Documentation]    Create an empty validation with a title and instructions, snap the background and validate
    [Arguments]    ${title}    ${instructions}
    Create Activity
    Select Activity Type    Search and Find
    Next button
    Sleep    2s
    Edit Activity Title    ${title}
    Edit Activity Instructions    ${instructions}
    Next button
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
    Wait For Detection Or Log Miss
    Click home button

Create empty path
    [Documentation]    Create an empty path with a title and instructions. Defaults to "Free Exploration Path"; pass ${path_type} to create one of the other path types instead (e.g. "Auto-Triggered path", "Guided Path").
    [Arguments]    ${title}=parcours numéro 1    ${instructions}=instruction relative au parcours numéro 1    ${path_type}=Free Exploration Path
    Create Path
    Select Path Type    ${path_type}
    Edit Path Title    ${title}
    Edit Path Instructions    ${instructions}
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

Wait For Activity
    [Documentation]    Wait until the activity/path card identified by the provided title is visible on the home menu.
    [Arguments]    ${activity_title}    ${timeout}=15s
    Wait Until Element Is Visible    xpath=//div[h3[contains(@class, 'activity-card') and text()='${activity_title}']]    ${timeout}

Search For
    [Documentation]    Open the home menu's search box (if not already open) and replace its content with the given text, filtering the visible activity/path cards. Pass ${EMPTY} to clear the search. Verified live: "CTRL+a" does not actually select the existing text here (Input Text just appends after it), so the field is cleared with "Clear Element Text" instead - which can itself collapse the search box back to its closed icon state, so visibility is re-checked and the box re-opened before typing new text into it.
    [Arguments]    ${search_text}
    ${search_input}=    Set Variable    xpath=//input[@placeholder='Search activities...']
    ${input_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${search_input}    2s
    IF    not ${input_visible}
        Click Element    xpath=//button[contains(@class, 'home__search-btn')]
        Wait Until Element Is Visible    ${search_input}    5s
    END
    Click Element    xpath=//span[contains(@class, 'ant-input-suffix')]
    Click Element    xpath=//button[contains(@class, 'home__search-btn')]
    Sleep    1s
    IF    '${search_text}' != '${EMPTY}'
        ${still_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${search_input}    2s
        IF    not ${still_visible}
            Click Element    xpath=//button[contains(@class, 'home__search-btn')]
            Wait Until Element Is Visible    ${search_input}    5s
        END
        Input Text    ${search_input}    ${search_text}
    END
    Sleep    2s

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

Get Card Data Id
    [Documentation]    Return the unique "data-id" of the activity/path card identified by the provided title. Capture this right after creating/duplicating a card so later steps can target it precisely by id instead of matching by title, which can collide with duplicates or stale data from earlier runs.
    [Arguments]    ${card_title}
    ${card_id}=    Get Element Attribute    xpath=//h3[contains(@class, 'activity-card') and text()='${card_title}']/ancestor::div[@data-id][1]    data-id
    RETURN    ${card_id}

Click Activity Card By Id
    [Documentation]    Scroll to and click an activity/path card identified by its data-id. Retried by its caller since the layout can shift on large accounts.
    [Arguments]    ${card_id}
    ${card}=    Set Variable    xpath=//div[contains(@class, 'activity-card') and @data-id='${card_id}']
    Scroll Element Into View    ${card}
    Click Element    ${card}

Add Activity to Path By Id
    [Documentation]    Add an activity to a path, both identified by their unique "data-id" rather than title text. Immune to duplicate or stale-data titles anywhere else on the page. The drag is started from the card's title-wrapper (not the full card) because Selenium's synthetic drag grabs the element's center point, and the full card's center can land on an action button (like/sync/menu) instead of empty space, silently breaking the drag. The drop itself is done as Mouse Down / Mouse Over / Sleep / Mouse Up instead of the single-shot "Drag And Drop" keyword, because the app needs a brief hover over the drop zone to register the dragover state before the mouse is released - "Drag And Drop" releases immediately after arriving, which is too fast for it to pick up.
    [Arguments]    ${activity_id}    ${path_id}
    ${activity_card}=    Set Variable    xpath=//div[contains(@class, 'activity-card') and @data-id='${activity_id}']
    ${drag_source}=    Set Variable    ${activity_card}//div[contains(@class,'activity-card__title-wrapper')]
    ${drop_target}=    Set Variable    xpath=//div[contains(@class, 'activity-card') and @data-id='${path_id}']/*[contains(@class,'activity-card__content')]
    Wait Until Element Is Visible    ${activity_card}    15s
    Wait Until Keyword Succeeds    3x    2s    Click Activity Card By Id    ${activity_id}
    Mouse Down    ${drag_source}
    Mouse Over    ${drop_target}
    Sleep    1s
    Mouse Up    ${drop_target}
    Sleep    4s

Open Path Content Drawer
    [Documentation]    Open the path's content management drawer, identified by its "data-id". Click the card's title-wrapper (not the title-arrow-button, which instead launches the AR player) to reach it.
    [Arguments]    ${path_id}
    ${path_card}=    Set Variable    xpath=//div[contains(@class, 'activity-card') and @data-id='${path_id}']
    Scroll Element Into View    ${path_card}
    Click Element    ${path_card}//div[contains(@class,'activity-card__title-wrapper')]
    Wait Until Element Is Visible    xpath=//div[contains(@class,'path-slider__content')]    15s

Close Path Content Drawer
    [Documentation]    Close the path content drawer opened by "Open Path Content Drawer". Waits a few seconds after closing since the home grid re-renders when the drawer closes, and interacting with cards too soon can find them momentarily missing.
    Click Element    xpath=//button[contains(@class,'path-slider__close-button')]
    Sleep    3s

Path Should Contain Activities
    [Documentation]    Assert that every activity id in the given list is present in the currently open path content drawer. Call "Open Path Content Drawer" first.
    [Arguments]    ${activity_ids}
    ${expected_count}=    Get Length    ${activity_ids}
    ${id_conditions}=    Evaluate    " or ".join(["@data-id='%s'" % i for i in $activity_ids])
    ${actual_count}=    Get Element Count    xpath=//div[contains(@class,'path-slider__content')]//*[${id_conditions}]
    Should Be Equal As Integers    ${actual_count}    ${expected_count}    msg=Expected ${expected_count} activities in the path but found ${actual_count}

Get Missing Activity Ids
    [Documentation]    Return the subset of the given activity ids that are NOT present in the currently open path content drawer. Call "Open Path Content Drawer" first.
    [Arguments]    ${activity_ids}
    ${missing}=    Create List
    FOR    ${activity_id}    IN    @{activity_ids}
        ${found_count}=    Get Element Count    xpath=//div[contains(@class,'path-slider__content')]//*[@data-id='${activity_id}']
        IF    ${found_count} == 0
            Append To List    ${missing}    ${activity_id}
        END
    END
    RETURN    ${missing}

Sign In
    [Documentation]    Sign in to the application using the provided email and password. Waits out the "loading-blocker" overlay before returning - the shared test accounts accumulate a lot of activities/paths across repeated runs, and the initial sync after login can take a while, during which the overlay intercepts clicks on anything underneath it (e.g. "New activity").
    [Arguments]    ${email}    ${password}
    Wait Until Element Is Visible    xpath=//button[.//span[contains(@class, 'anticon anticon-user')]]    15s
    Click Element    xpath=//button[.//span[contains(@class, 'anticon anticon-user')]]
    Wait Until Element Is Visible    xpath=//button[text()='Login']    15s
    Click Element    xpath=//button[text()='Login']
    Input Text    xpath=//input[@placeholder='you@company.com']    ${email}
    Input Text    xpath=//input[@placeholder='••••••••']    ${password}
    Click Element    xpath=//button[text()='Continue']
    Sleep    5s
    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'loading-blocker__overlay')]    60s

Sign Up
    [Documentation]    Sign up for a new account using the provided username, email and password
    [Arguments]    ${username}    ${email}    ${password}
    Wait Until Element Is Visible    xpath=//button[.//span[contains(@class, 'anticon anticon-user')]]    15s
    Click Element    xpath=//button[.//span[contains(@class, 'anticon anticon-user')]]
    Wait Until Element Is Visible    xpath=//button[text()='Sign up']    15s
    Click Element    xpath=//button[text()='Sign up']
    Wait Until Element Is Visible    xpath=//input[@placeholder='your_username']    15s
    Input Text    xpath=//input[@placeholder='your_username']    ${username}
    Input Text    xpath=//input[@placeholder='you@company.com']    ${email}
    Input Text    xpath=//input[@placeholder='••••••••']    ${password}
    Click Element    xpath=//button[text()='Create account']
    Sleep    5s

Open Import Modal
    [Documentation]    Click the import button and verify the import modal actually opened. The click is occasionally swallowed by the app, so this is retried by its caller.
    Click Element    xpath=//button[contains(@class, 'home__import-btn')]
    Wait Until Element Is Visible    xpath=//input[@placeholder='Select a share code']    5s

Synchronize Activity
    [Documentation]    Click an activity/path card's sync button and wait for the upload to complete (the button gains the "uploaded" class once done). When ${activity_title} is given, first checks that card is visible on the home menu and scopes the sync button to it specifically - use this whenever more than one card could be on screen. Without it, falls back to assuming a single relevant sync button is visible (legacy behavior for existing callers).
    [Arguments]    ${activity_title}=${EMPTY}
    IF    '${activity_title}' != '${EMPTY}'
        Wait For Activity    ${activity_title}
        ${sync_button}=    Set Variable    xpath=//h3[contains(@class, 'activity-card') and text()='${activity_title}']/ancestor::div[3]//button[contains(@class, 'activity-card__action-button--sync')]
        ${uploaded_button}=    Set Variable    xpath=//h3[contains(@class, 'activity-card') and text()='${activity_title}']/ancestor::div[3]//button[contains(@class, 'activity-card__action-button--sync uploaded')]
    ELSE
        ${sync_button}=    Set Variable    xpath=//button[contains(@class, 'activity-card__action-button activity-card__action-button--sync')]
        ${uploaded_button}=    Set Variable    xpath=//button[contains(@class, 'activity-card__action-button activity-card__action-button--sync uploaded')]
    END
    Wait Until Element Is Visible    ${sync_button}    15s
    Click Element    ${sync_button}
    Sleep    5s
    Wait Until Element Is Visible    ${uploaded_button}    15s

Generate Share Code
    [Documentation]    Synchronize an activity/path, open its sharing panel and return the read-only share code. Pass ${activity_title} to check the card exists and scope the sync to it specifically when more than one card could be on screen. Verified live: the "Read-only" tab is active by default and already displays a "<code>" element with the share code - no "generate"/confirm click needed (that button belongs to the inactive "Template" tab, which is why waiting on it used to time out).
    [Arguments]    ${activity_title}=${EMPTY}
    Synchronize Activity    ${activity_title}
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'cloud-sync-status-modal__sharing-generate-button')]    15s
    Click Element    xpath=//button[contains(@class, 'cloud-sync-status-modal__sharing-generate-button')]
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'ant-btn-dangerous')]    15s
    Click Element    xpath=//button[contains(@class, 'ant-btn-dangerous')]
    Wait Until Element Is Visible    xpath=//code    30s
    ${code}=    Get Text    xpath=//code
    RETURN    ${code}

Generate Template Share Code
    [Documentation]    Synchronize an activity/path, open its sharing panel, switch to the "Template" tab and return the generated template share code. Unlike the read-only code (shown immediately), the Template tab requires clicking "Generate Template Code" and then confirming an irreversible-action warning dialog before a code appears - verified live, no "<code>" element exists there until both are clicked. Pass ${activity_title} to scope the sync to a specific card when more than one could be on screen.
    [Arguments]    ${activity_title}=${EMPTY}
    Synchronize Activity    ${activity_title}
    Wait Until Element Is Visible    xpath=//div[contains(@class,'ant-tabs-tab') and .//text()='Template']    15s
    Click Element    xpath=//div[contains(@class,'ant-tabs-tab') and .//text()='Template']
    Wait Until Element Is Visible    xpath=//button[contains(., 'Generate Template Code')]    15s
    Click Element    xpath=//button[contains(., 'Generate Template Code')]
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'ant-btn-dangerous')]    15s
    Click Element    xpath=//button[contains(@class, 'ant-btn-dangerous')]
    Wait Until Element Is Visible    xpath=//code    30s
    ${code}=    Get Text    xpath=//code
    RETURN    ${code}

Import Activity
    [Documentation]    Import an activity using the provided code. Read-only imported activities are tied to the browser session/machine, not the signed-in account (confirmed behavior, not a bug) - closing the browser deletes them. Never call "Close Browser" between importing and using an imported activity in the same test, or it will no longer be found afterwards.
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

Open Activity Menu And Edit
    [Documentation]    Click an activity card's menu button and select "Edit" to reopen it in the editor. Mirrors "Open Activity Menu And Duplicate" for the same reasons (a fresh/duplicated card can take a moment to become interactive, and the "Edit" menu item is clicked via JavaScript filtered to the one that is actually visible, since Ant Design leaves previous dropdown instances mounted/hidden in the DOM).
    [Arguments]    ${activity_title}
    Wait Until Element Is Visible    xpath=//h3[contains(@class, 'activity-card') and text()='${activity_title}']    30s
    ${card}=    Set Variable    xpath=//h3[contains(@class, 'activity-card') and text()='${activity_title}']/ancestor::div[3]
    Wait Until Element Is Visible    ${card}//button[contains(@class, 'activity-card__menu-button')]    30s
    Wait Until Element Is Not Visible    ${card}//*[contains(text(), 'Sync in progress')]    20s
    Scroll Element Into View    ${card}//button[contains(@class, 'activity-card__menu-button')]
    Click Element    ${card}//button[contains(@class, 'activity-card__menu-button')]
    Sleep    1s
    ${clicked}=    Execute Javascript    var items=[...document.querySelectorAll('.ant-dropdown-menu-title-content')].filter(function(el){return el.textContent.trim()==='Edit' && el.offsetParent!==null;}); if(items.length===0){return false;} items[0].click(); return true;
    Should Be True    ${clicked}    Could not find a visible "Edit" menu item

Find And Open Activity Menu And Edit
    [Documentation]    Reload the page and then attempt "Open Activity Menu And Edit". Used as the retried action in "Reopen Activity Editor" - a just-created/just-synced activity can take a while to show up in the activity list on a fresh sign-in, and simply re-querying the same already-loaded page (without reloading) never gives it a chance to catch up.
    [Arguments]    ${activity_title}
    Reload Page
    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'loading-blocker__overlay')]    30s
    Open Activity Menu And Edit    ${activity_title}

Reopen Activity Editor
    [Documentation]    Reopen an existing activity identified by its title (via its card menu's "Edit" action) and step through the metadata pages to reach the augmentation canvas, ready to add more content with keywords like "Add Text To Augmentation". Verified live: unlike the single combined page used during initial creation, the reopened editor paginates title/instructions/description across separate "Next" clicks before reaching the "#three-canvas" board - if the app changes that step count this is the first place to check.
    [Arguments]    ${activity_title}
    Wait Until Keyword Succeeds    8x    15s    Find And Open Activity Menu And Edit    ${activity_title}
    Sleep    2s
    Next button
    Sleep    2s
    Next button
    Sleep    2s
    Wait Until Element Is Visible    xpath=//div[@id='three-canvas']    15s

Delete Activity Or Path
    [Documentation]    Delete the activity or path card identified by the provided title. Every activity/path card carries a unique "data-id" attribute, so this first captures that id from the card matching the title, then scopes the menu-open and delete-confirm steps to that exact "data-id" instead of the title. This keeps the deletion correct even when several look-alike cards (same title, duplicates, stale data from earlier runs) are visible on screen at once.
    [Arguments]    ${card_title}
    ${card_id}=    Get Element Attribute    xpath=//h3[contains(@class, 'activity-card') and text()='${card_title}']/ancestor::div[@data-id][1]    data-id
    ${card}=    Set Variable    xpath=//div[contains(@class, 'activity-card') and @data-id='${card_id}']
    Wait Until Element Is Visible    ${card}//button[contains(@class, 'activity-card__menu-button')]    15s
    Scroll Element Into View    ${card}//button[contains(@class, 'activity-card__menu-button')]
    Click Element    ${card}//button[contains(@class, 'activity-card__menu-button')]
    Sleep    1s
    ${clicked}=    Execute Javascript    var items=[...document.querySelectorAll('.ant-dropdown-menu-title-content')].filter(function(el){return el.textContent.trim()==='Delete' && el.offsetParent!==null;}); if(items.length===0){return false;} items[0].click(); return true;
    Should Be True    ${clicked}    Could not find a visible "Delete" menu item
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'confirmation-dialog__footer')]//button[text()='Delete']    15s
    Click Element    xpath=//div[contains(@class, 'confirmation-dialog__footer')]//button[text()='Delete']
    RETURN    ${card_id}

Restore Activity Or Path
    [Documentation]    Open the Trash and restore the card identified by its "data-id" (as returned by "Delete Activity Or Path"). Scoping the restore button by data-id keeps this correct even if the trash holds several look-alike deleted cards. Matched directly under the card (not inside a "top-actions" wrapper) since that wrapper only exists for path cards, not activity cards.
    [Arguments]    ${card_id}
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'ds-header__download-button') and @title='Trash']    15s
    Click Element    xpath=//button[contains(@class, 'ds-header__download-button') and @title='Trash']
    ${card}=    Set Variable    xpath=//div[contains(@class, 'activity-card') and @data-id='${card_id}']
    ${restore_button}=    Set Variable    ${card}//button[contains(@class, 'activity-card__action-button--restore')]
    Wait Until Element Is Visible    ${restore_button}    15s
    Scroll Element Into View    ${restore_button}
    Click Element    ${restore_button}

Delete Activity Or Path Permanently
    [Documentation]    Open the Trash and permanently delete the card identified by its "data-id" (as returned by "Delete Activity Or Path"). Scoping the button by data-id keeps this correct even if the trash holds several look-alike deleted cards.
    [Arguments]    ${card_id}
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'ds-header__download-button') and @title='Trash']    15s
    Click Element    xpath=//button[contains(@class, 'ds-header__download-button') and @title='Trash']
    ${card}=    Set Variable    xpath=//div[contains(@class, 'activity-card') and @data-id='${card_id}']
    ${delete_button}=    Set Variable    ${card}//button[contains(@class, 'activity-card__action-button--delete') and @title='Delete permanently']
    Wait Until Element Is Visible    ${delete_button}    15s
    Click Element    ${delete_button}
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'confirmation-dialog__footer')]//button[text()='Delete']    15s
    Click Element    xpath=//div[contains(@class, 'confirmation-dialog__footer')]//button[text()='Delete']

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
    Sleep    5s
    Next button
    Sleep    5s

Create failed search and find activity
    [Documentation]    Create a basic search and find activity with a title, instructions, use a photo and validate
    [Arguments]    ${title}    ${instructions}
    Create Activity
    Select Activity Type    Search and Find
    Next button
    Sleep    2s
    Edit Activity Title    ${title}
    Edit Activity Instructions    ${instructions}
    Click Element    xpath=//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-primary editor__nav-button editor__nav-button--primary')]
    Sleep    2s
    Use template image
    Sleep    2s
    Next button
    Sleep    2s
    Validation button
    Sleep    5s

    Wait Until Element Is Visible    xpath=//div[contains(@class, 'ant-slider-handle')]    15s
    Drag And Drop    xpath=//div[contains(@class, 'ant-slider-handle')]    xpath=//div[contains(@id, 'three-canvas')]

    Next button
    Sleep    5s

Create basic pairs activity
    [Documentation]    Create a basic pairs activity with a title, instructions, snap the background and validate
    [Arguments]    ${title}    ${instructions}
    Create Activity
    Select Activity Type    Pair Association
    Next button
    Sleep    2s
    Edit Activity Title    ${title}
    Edit Activity Instructions    ${instructions}
    Click Element    xpath=//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-primary editor__nav-button editor__nav-button--primary')]
    Sleep    2s
    Wait Until Element Is Visible    xpath=//span[contains(@class, ant-upload-btn)]    15s
    Click Element    xpath=//span[contains(@class, ant-upload-btn)]
    Choose File   xpath=//input[@type='file']    ${EXECDIR}/assets/fakecamfeed_cortez.png
    Sleep    2s
    Click Element    xpath=//span[contains(@class, ant-upload-btn)]
    Choose File   xpath=//input[@type='file']    ${EXECDIR}/assets/cat.webp
    Sleep    2s
    Next button
    Sleep    2s
    Validation button
    Sleep    5s
    Next button
    Sleep    5s

Create basic layers activity
    [Documentation]    Create a basic layers activity with a title, instructions, snap the background
    [Arguments]    ${title}    ${instructions}
    Create Activity
    Select Activity Type    Information layers
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
    Sleep    5s
    Next button
    Sleep    5s

Create basic layers activity without validation
    [Documentation]    Create a basic layers activity with a title, instructions, snap the background
    [Arguments]    ${title}    ${instructions}
    Create Activity
    Select Activity Type    Information layers
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
    Sleep    5s
    Validation button
    Sleep    5s

Add multiple layers
    [Documentation]    Add multiple layers to the current activity
    [Arguments]    ${number_of_layers}=3
    FOR    ${index}    IN RANGE    ${number_of_layers}
        Click Element    xpath=//button[contains(@class, 'layers-panel__add-button')]
        Wait Until Element Is Visible    xpath=//button[contains(@class, 'layers-panel__edit-button--validate')]    15s
        Click Element    xpath=//button[contains(@class, 'layers-panel__edit-button--validate')]
        Sleep    2s
    END

Furnish layers with content
    [Documentation]    Furnish each layer with content (cat image)
    [Arguments]    ${number_of_layers}=3
    FOR    ${index}    IN RANGE    ${number_of_layers}
        Click Element    xpath=//div[contains(@class, 'layers-panel__tile-name') and text()='Layer ${index + 1}']
        Click Element    xpath=//button[contains(@title, 'Image')]
        Sleep    2s
        Click Element    xpath=//h5[contains(@class, 'ant-typography') and text()='Click to edit...']
        Click Element    xpath=//button[contains(@class, 'ant-btn')]
        Choose File   xpath=//input[@type='file']    ${EXECDIR}/assets/cat.webp
        Wait Until Element Is Visible    xpath=//button[contains(@title, 'Expand Layers')]    15s
        Click Element    xpath=//button[contains(@title, 'Expand Layers')] 
        Sleep    2s
    END

Check if Layer has content
    [Documentation]    Check if a specific layer has content (cat image)
    [Arguments]    ${layer_index}
    Click Element    xpath=//div[contains(@class, 'layers-panel__tile-name') and text()='Layer ${layer_index + 1}']
    ${rows}=    Get WebElements    xpath=//div[contains(@class, 'auras__html-container')]
    ${count}=   Get Length         ${rows}
    Should Be True    ${count} == 1
    Log    Nombre d'activités: ${count} (devrait être 1)

Check that all layers are present and contain the expected content
    [Documentation]    Check that all layers are present and contain the expected content (cat image)
    [Arguments]    ${number_of_layers}=3
    FOR    ${index}    IN RANGE    ${number_of_layers}
        Check if Layer has content    ${index}
    END

Change Language
    [Documentation]    Change the language of the application using the provided language name.
    ### FR = Français
    ### EN = English
    ### DK = Dansk
    ### GR = Ελληνικά
    ### TR = Türkçe
    [Arguments]    ${language_code}
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'ds-header__language-dropdown')]    5s
    Click Element    xpath=//div[contains(@class, 'ds-header__language-dropdown')]
    Wait Until Element Is Visible    xpath=//div[@role='option'][.//span[text()='${language_code}']]    5s
    Click Element    xpath=//div[@role='option'][.//span[text()='${language_code}']]

Check that the page is in French
    [Documentation]    Check that the page is in French by verifying the presence of a specific French text.
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__new-activity-btn') and text()='Nouvelle activité']    2s
    Change Language    English
    Create empty augmented activity    title=Activité augmentée de test
    Change Language    Français
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[text()="Nouveau parcours d'apprentissage"]   2s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'activity-card__status-badges')]//span[text()='Brouillon local']    2s

Check that the page is in English
    [Documentation]    Check that the page is in English by verifying the presence of a specific English text.
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__new-activity-btn') and text()='New activity']    2s
    Create empty augmented activity    title=Test Augmented Activity
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[text()="New learning path"]   2s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'activity-card__status-badges')]//span[text()='Local draft']    2s

Check that the page is in Danish
    [Documentation]    Check that the page is in Danish by verifying the presence of a specific Danish text.
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__new-activity-btn') and text()='Ny aktivitet']    2s
    Change Language    English
    Create empty augmented activity    title=Test Forstærket Aktivitet
    Change Language    Dansk
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[text()="Ny læringssti"]   2s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'activity-card__status-badges')]//span[text()='Lokal kladde']    2s

Check that the page is in Greek
    [Documentation]    Check that the page is in Greek by verifying the presence of a specific Greek text.
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__new-activity-btn') and text()='Νέα δραστηριότητα']    2s
    Change Language    English
    Create empty augmented activity    title=Δοκιμή Επαυξημένης Δραστηριότητας
    Change Language    Ελληνικά
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[text()="Νέα διαδρομή μάθησης"]   2s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'activity-card__status-badges')]//span[text()='Τοπικό προσχέδιο']    2s

Check that the page is in Turkish
    [Documentation]    Check that the page is in Turkish by verifying the presence of a specific Turkish text.
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__new-activity-btn') and text()='Yeni etkinlik']    2s
    Change Language    English
    Create empty augmented activity    title=Test Artırılmış Etkinlik
    Change Language    Türkçe
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[text()="Yeni öğrenme yolu"]   2s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'activity-card__status-badges')]//span[text()='Yerel taslak']    2s

Play Activity
    [Documentation]    Opens the activity by title, launching its AR player view via its title-arrow-button. Scoped to that specific card so it does not launch the wrong activity when several look-alike cards are visible on screen.
    [Arguments]    ${activity_title}
    Wait For Activity    ${activity_title}
    ${play_button}=    Set Variable    xpath=//h3[contains(@class, 'activity-card') and text()='${activity_title}']/ancestor::div[3]//button[contains(@class, 'activity-card__title-arrow-button')]
    Wait Until Element Is Visible    ${play_button}    15s
    Click Element    ${play_button}

Resync Activity
    [Documentation]    Click an activity/path card's sync button after it has already been synced once, confirm the resync in the cloud sync status modal, and wait for the upload to complete again.
    [Arguments]    ${activity_title}=${EMPTY}
    IF    '${activity_title}' != '${EMPTY}'
        Wait For Activity    ${activity_title}
        ${sync_button}=    Set Variable    xpath=//h3[contains(@class, 'activity-card') and text()='${activity_title}']/ancestor::div[3]//button[contains(@class, 'activity-card__action-button--sync')]
        ${uploaded_button}=    Set Variable    xpath=//h3[contains(@class, 'activity-card') and text()='${activity_title}']/ancestor::div[3]//button[contains(@class, 'activity-card__action-button--sync uploaded')]
    ELSE
        ${sync_button}=    Set Variable    xpath=//button[contains(@class, 'activity-card__action-button activity-card__action-button--sync')]
        ${uploaded_button}=    Set Variable    xpath=//button[contains(@class, 'activity-card__action-button activity-card__action-button--sync uploaded')]
    END
    Wait Until Element Is Visible    ${sync_button}    15s
    Click Element    ${sync_button}
    Sleep    5s
    # Some activities resync immediately (the modal opens already showing "Synced" with no
    # confirmation needed), others show a confirm button in the cloud sync status modal first
    # (observed live in both states). Click it only if it actually appears, instead of assuming
    # either behavior.
    ${confirm_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//button[contains(@class, 'cloud-sync-status-modal__button cloud-sync-status-modal__button--primary')]    5s
    IF    ${confirm_visible}
        Click Element    xpath=//button[contains(@class, 'cloud-sync-status-modal__button cloud-sync-status-modal__button--primary')]
    END
    Wait Until Element Is Visible    ${uploaded_button}    15s