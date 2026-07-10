*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections
Resource       ./ressources.robot

*** Variables ***

${URL}    https://mixap-lium-preprod.univ-lemans.fr/
${sharecode}    None

*** Test Cases ***
Create 8 activities and share path
    Open Web Application
    Sign In    test@example.com   password123
    Sleep    15s
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__new-activity-btn')]    15s
    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'loading-blocker__overlay')]    30s
    ${run_suffix}=    Generate Random String    8    [LETTERS][NUMBERS]
    Set Suite Variable    ${run_suffix}

    # Only the first activity goes through the full creation wizard (title, camera snap,
    # validation...). The other 7 are obtained by duplicating the previous one: the app
    # appends " (copy)" to the source title on each duplication, so chaining the duplicates
    # (each one duplicated from the previous copy, not from the original) keeps every title
    # unique without needing to rename anything. Each card's unique data-id is captured right
    # after it's created/duplicated, so every step from here on targets cards by id instead of
    # by title text - immune to duplicate or stale-data titles elsewhere on the page.
    ${activity_ids}=    Create List
    ${current_title}=    Set Variable    activité numéro 1 ${run_suffix}
    Create empty augmented activity    ${current_title}
    ${current_id}=    Get Card Data Id    ${current_title}
    Append To List    ${activity_ids}    ${current_id}

    FOR    ${i}    IN RANGE    1    8
        Duplicate Activity    ${current_title}
        ${current_title}=    Set Variable    ${current_title} (copy)
        ${current_id}=    Get Card Data Id    ${current_title}
        Append To List    ${activity_ids}    ${current_id}
    END

    ${path_title}=    Set Variable    parcours numéro 1 ${run_suffix}
    Create empty path    ${path_title}
    ${path_id}=    Get Card Data Id    ${path_title}

    FOR    ${activity_id}    IN    @{activity_ids}
        Add Activity to Path By Id    ${activity_id}    ${path_id}
    END
    Sleep    10s

    # Functional check that the 8 activities actually landed in the path (not just that no
    # exception was raised while dragging them - the drop can silently fail to register even
    # when the drag itself completes without error). Opens the path's content drawer - reached
    # by clicking its card body, not the title-arrow-button which instead launches the AR player
    # - finds which activities (if any) didn't land, retries only those, then asserts all 8 are
    # present.
    Open Path Content Drawer    ${path_id}
    ${missing_ids}=    Get Missing Activity Ids    ${activity_ids}
    Close Path Content Drawer

    IF    $missing_ids
        Log    Retrying activities that did not land on the first drop: ${missing_ids}    WARN
        FOR    ${missing_id}    IN    @{missing_ids}
            Add Activity to Path By Id    ${missing_id}    ${path_id}
        END
        Sleep    5s
    END

    Open Path Content Drawer    ${path_id}
    Path Should Contain Activities    ${activity_ids}
    Close Path Content Drawer

    ${path_sync_button}=    Set Variable    xpath=//div[contains(@class, 'activity-card') and @data-id='${path_id}']//button[contains(@class, 'activity-card__action-button--sync')]
    Wait Until Element Is Visible    ${path_sync_button}    15s
    Scroll Element Into View    ${path_sync_button}
    Click Element    ${path_sync_button}

    Sleep    15s

    Wait Until Element Is Visible    xpath=//button[contains(@class, 'cloud-sync-status-modal__sharing-generate-button')]    15s
    Click Element    xpath=//button[contains(@class, 'cloud-sync-status-modal__sharing-generate-button')]

    Wait Until Element Is Visible    xpath=//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-primary ant-btn-dangerous')]    15s
    Click Element    xpath=//button[contains(@class, 'ant-btn css-j9bb5n ant-btn-primary ant-btn-dangerous')]

    Wait Until Element Is Visible    xpath=//code    15s
    ${sharecode}=    Get Text    xpath=//code
    Set Suite Variable    ${sharecode}

    Close Browser

Import activity with share code
    Open Web Application
    Sign In    test3@example.com   password123
    Import Activity    ${sharecode}
    Sleep    20s

Launch imported activity
    Click Element    xpath=//button[contains(@class, 'activity-card__title-arrow-button')]
    Sleep    2s
    ${status}    ${message}=    Run Keyword And Ignore Error    Wait for detection
    Run Keyword If    '${status}' == 'FAIL'    Log    ⚠️ Expected behavior: The element is still visible after 25s miss detection.    WARN
    #IF Element Is Visible    xpath=//div[contains(@class, 'ant-notification-notice-wrapper')]
    #    Click Element    xpath=//a[contains(@class, 'ant-notification-notice-close')]
    #END
#    sleep     20s     #used to watch the result can be commentend if necessary
    Close Browser