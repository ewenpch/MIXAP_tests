*** Settings ***
Library    SeleniumLibrary
Resource       ./ressources.robot

*** Variables ***
${URL}    https://mixap-lium-preprod.univ-lemans.fr/
#${VERIFY_TEXT_FR}    MIXAP est un outil auteur, créé par le LIUM, qui vous permet de créer vos propres applications de Réalité Augmentée.
#${VERIFY_TEXT_EN}    MIXAP is an authoring tool, created by LIUM, that allows you to create your own Augmented Reality educational activities.
#${VERIFY_TEXT_DA}    MIXAP er et forfatterværktøj, skabt af LIUM, som giver dig mulighed for at skabe dine egne Udvidet Virkelighed aktiviteter.
#${VERIFY_TEXT_EL}    MIXAP είναι ένα εργαλείο συγγραφής, που δημιουργήθηκε από την LIUM, το οποίο σας επιτρέπει να δημιουργήσετε τις δικές σας δραστηριότητες Επαυξημένης Πραγματικότητας.
#${VERIFY_TEXT_TR}    MIXAP tarafından oluşturulan bir yazma aracıdır. LIUM, oluşturmanıza olanak tanıyan Artırılmış Gerçeklik eğitsel etkinlikler.

*** Test Cases ***
open Application
    Open Web Application
    Maximize Browser Window
    Go Offline
Change to French
    Open drawer
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'ant-space-item')]//span[text()='Français']    10s
    Click Element    xpath=//div[contains(@class, 'ant-space-item')]//span[text()='Français']
    #Wait Until Element Contains    xpath=//body    ${VERIFY_TEXT_FR}    10s
    Wait Until Element Contains    xpath=//body    Nouvelle activité    10s

Change to Danish
    Open drawer
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'ant-space-item')]//span[text()='Dansk']    10s
    Click Element    xpath=//div[contains(@class, 'ant-space-item')]//span[text()='Dansk']
    #Wait Until Element Contains    xpath=//body    ${VERIFY_TEXT_DA}    10s
    Wait Until Element Contains    xpath=//body    Ny aktivitet    10s

Change to Greek
    Open drawer
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'ant-space-item')]//span[text()='Ελληνικά']    10s
    Click Element    xpath=//div[contains(@class, 'ant-space-item')]//span[text()='Ελληνικά']
    #Wait Until Element Contains    xpath=//body    ${VERIFY_TEXT_EL}    10s
    Wait Until Element Contains    xpath=//body    Νέα δραστηριότητα    10s

Change to Turkish
    Open drawer
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'ant-space-item')]//span[text()='Türkçe']    10s
    Click Element    xpath=//div[contains(@class, 'ant-space-item')]//span[text()='Türkçe']
    #Wait Until Element Contains    xpath=//body    ${VERIFY_TEXT_TR}    10s
    Wait Until Element Contains    xpath=//body    Yeni etkinlik    10s

Change to English
    Open drawer
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'ant-space-item')]//span[text()='English']    10s
    Click Element    xpath=//div[contains(@class, 'ant-space-item')]//span[text()='English']
    #Wait Until Element Contains    xpath=//body    ${VERIFY_TEXT_EN}    10s
    Wait Until Element Contains    xpath=//body    New activity    10s

#change the activity rendering mode

    #Click Element    xpath=//span[contains(@class, 'mix-switcher_bt')]
    #Sleep    1s

Check filtering activities buttons
    Create empty augementation    augmentation numéro 1
    Create empty augementation    augmentation numéro 2
    Create empty validation    validation numéro 1    instruction 1
    Create empty validation    validation numéro 2    instruction 2
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__filter-btn') and @title='Filter']    timeout=10
    Click Element    xpath=//button[contains(@class, 'home__filter-btn') and @title='Filter']
    Wait Until Element Is Visible    xpath=//label[.//span[text()='Augmented activity']]    timeout=10
    Click Element    xpath=//label[.//span[text()='Augmented activity']]
    Wait Until Element Contains    xpath=//body//*[text()='Augmented activity']    text=Augmented activity    timeout=10
    Element Should Not Contain    xpath=//div[contains(@class, 'home__grid')]    Search and Find
    #Wait Until Element Is Visible    xpath=//button[contains(@class, 'home__filter-btn') and @title='Filter']    timeout=10
    #Click Element    xpath=//button[contains(@class, 'home__filter-btn') and @title='Filter']
    Wait Until Element Is Visible    xpath=//label[.//span[text()='Augmented activity']]    timeout=10
    Click Element    xpath=//label[.//span[text()='Augmented activity']]
    Wait Until Element Is Visible    xpath=//label[.//span[text()='Search and Find']]    timeout=10
    Click Element    xpath=//label[.//span[text()='Search and Find']]
    Wait Until Element Contains    xpath=//body//*[text()='Search and Find']    text=Search and Find    timeout=10
    Element Should Not Contain    xpath=//div[contains(@class, 'home__grid')]    Augmented activity

    #Wait Until Element Is Visible    xpath=//div[@data-node-key='group']//div[@role='tab' and @aria-selected='false']    timeout=10
    #Click Element    xpath=//div[@data-node-key='group']//div[@role='tab' and @aria-selected='false']
    #Wait Until Element Is Not Visible    xpath=//div[@class='mix-tab_filters']    timeout=10
    #Wait Until Element Is Visible    xpath=//div[@data-node-key='activity']//div[@role='tab' and @aria-selected='false']    timeout=10
    #Click Element    xpath=//div[@data-node-key='activity']//div[@role='tab' and @aria-selected='false']
    #Wait Until Element Is Visible    xpath=//div[@class='mix-tab_filters']    timeout=10
    #Wait Until Element Is Visible    xpath=//div[@data-node-key='path']//div[@role='tab' and @aria-selected='false']    timeout=10
    #Click Element    xpath=//div[@data-node-key='path']//div[@role='tab' and @aria-selected='false']
    #Wait Until Element Is Not Visible    xpath=//div[@class='mix-tab_filters']    timeout=10

    Close Browser


*** Keywords ***

Open drawer
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'ant-select') and contains(@class, 'ant-select-single') and contains(@class, 'ant-select-show-arrow')]
    Click Element    xpath=//div[contains(@class, 'ant-select') and contains(@class, 'ant-select-single') and contains(@class, 'ant-select-show-arrow')]


