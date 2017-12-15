*** Settings ***
Test Setup        Test setup
Test Teardown     Test teardown
Library           Selenium2Library
Resource          Btns.txt
Resource          Ids.txt
Resource          Links.txt

*** Variables ***
${emailTest}      jkowalski5@wp.pl
${passTest}       zaq1@WSX
${emailGood}      owiecpl@gmail.com
${passGood}       zaq1@WSX

*** Test Cases ***
[?]Logowanie
    Click Element    ${logowanieId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się
    Page Should Contain Button    ${logowanieBtn}

[@]Logowanie
    Click Element    ${logowanieId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się
    Page Should Contain Element    ${projektyId}
    Page Should Contain Element    ${szukajId}
    Page Should Contain Element    ${wystawId}
    Page Should Contain Element    ${rejestracjaId}

[0]Logowanie
    Logowanie    ${EMPTY}    ${EMPTY}
    Wait Until Keyword Succeeds    5    1    Page Should Contain Element    //*[@class="tooltip-inner"]
    Page Should Contain    Podaj nazwę użytkownika

[-]Logowanie
    Logowanie    ${emailTest}    ${passTest}
    Wait Until Keyword Succeeds    5    1    Page Should Contain Element    //*[@class="alert alert-danger"]
    Page Should Contain    Błędny użytkownik lub hasło

[+]Logowanie
    Logowanie    ${emailGood}    ${passGood}
    Wait Until Keyword Succeeds    5    1    Page Should Contain Element    ${kontoId}
    Page Should Not Contain Element    ${logowanieId}
    Page Should Not Contain Element    ${rejestracjaId}

Logowanie do rejestracji
    Click Element    ${logowanieId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się
    Click Link    ${rejestracjaLink}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zarejestruj się

Logowanie do przypomnienia
    Click Element    ${logowanieId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się
    Click Link    ${przypomnienieLink}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zresetuj hasło

*** Keywords ***
Test setup
    Open Browser    http://www.beta.markiet.pl    Chrome
    Maximize Browser Window
    Wait Until Keyword Succeeds    5    1    Page Should Contain Image    ./img/uslugi2.png

Test teardown
    Close Browser

Logowanie
    [Arguments]    ${user}    ${pass}
    Click Element    ${logowanieId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się
    Input Text    ${emailId}    ${user}
    Input Password    ${passId}    ${pass}
    Click Button    ${logowanieBtn}
