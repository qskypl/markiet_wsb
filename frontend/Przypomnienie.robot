*** Settings ***
Test Setup        Test setup
Test Teardown     Test teardown
Library           Selenium2Library
Resource          Ids.txt
Resource          Links.txt

*** Variables ***
${emailTest}      jkowalski5@wp.pl
${emailGood}      owiecpl@gmail.com

*** Test Cases ***
[?]Przypomnienie
    Click Element    ${logowanieId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się
    Click Link    ${przypomnienieLink}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zresetuj hasło
    Page Should Contain Button    Wyślij nowe hasło

[@]Przypomnienie
    Click Element    ${logowanieId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się
    Click Link    ${przypomnienieLink}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zresetuj hasło
    Page Should Contain Element    ${projektyId}
    Page Should Contain Element    ${szukajId}
    Page Should Contain Element    ${wystawId}
    Page Should Contain Element    ${rejestracjaId}
    Page Should Contain Element    ${logowanieId}

[0]Przypomnienie
    Przypomnienie    ${EMPTY}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Podaj nazwę użytkownika

[-]Przypomnienie
    Przypomnienie    ${emailTest}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Użytkownik o tym adresie email nie istnieje

[+]Przypomnienie
    Przypomnienie    ${emailGood}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Na podany adres e-mail ${emailGood} zostało wysłane nowe hasło

Przypomnienie do logowania
    Click Element    ${logowanieId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się
    Click Link    ${przypomnienieLink}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zresetuj hasło
    Click Link    ${logowanieLink}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się

*** Keywords ***
Test setup
    Open Browser    http://www.beta.markiet.pl    Chrome
    Maximize Browser Window
    Wait Until Keyword Succeeds    5    1    Page Should Contain Image    ./img/uslugi2.png

Test teardown
    Close Browser

Przypomnienie
    [Arguments]    ${mail}
    Click Element    ${logowanieId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się
    Click Link    ${przypomnienieLink}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zresetuj hasło
    Input Text    ${emailId}    ${mail}
    Click Button    Wyślij nowe hasło
