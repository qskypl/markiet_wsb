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
[?]Rejestracja
    Click Link    ${rejestracjaId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zarejestruj się
    Click Element    ${akceptacjaBtn}
    Click Element    //*[@value="Zatwierdź"]

[@]Rejestracja
    Click Link    ${rejestracjaId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zarejestruj się
    Page Should Contain Element    ${projektyId}
    Page Should Contain Element    ${szukajId}
    Page Should Contain Element    ${wystawId}
    Page Should Contain Element    ${logowanieId}

[0]Rejestracja
    Rejestracja    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ...    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    False
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Podaj imię
    Page Should Contain    Podaj datę urodzenia
    Page Should Contain    Podaj adres e-mail
    Page Should Contain    Zaakceptuj regulamin

[-]Rejestracja
    Rejestracja    Jan    Kowalski    ul    13    00000    Warszawa
    ...    1850/03/15    abc    123456789    ${passTest}    ${passTest}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Pole ulica musi zawierać przynajmniej 3 znaki
    Page Should Contain    Pole kod pocztowy jest nieprawidłowe
    Page Should Contain    Pole e-mail jest błędnie wypełnione

[+]Rejestracja
    [Tags]    not_ready
    Rejestracja    Jan    Kowalski    Rondo Dmowskiego Romana    13    00-000    Warszawa
    ...    1850/03/15    ${emailGood}    123456789    ${passTest}    ${passTest}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Na podany adres e-mail ${emailGood} został wysłany link aktywacyjny w celu dokończenia rejestracji

[==]Rejestracja
    Rejestracja    Jan    Kowalski    Rondo Dmowskiego Romana    13    00-000    Warszawa
    ...    1850/03/15    ${emailGood}    123456789    ${passTest}    ${passTest}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Użytkownik o tym adresie email już istnieje

Rejestracja do logowania
    Click Element    ${rejestracjaId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zarejestruj się
    Click Link    ${logowanieLink}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się

*** Keywords ***
Test setup
    Open Browser    http://www.beta.markiet.pl    Chrome
    Maximize Browser Window
    Wait Until Keyword Succeeds    5    1    Page Should Contain Image    ./img/uslugi2.png

Test teardown
    Close Browser

Rejestracja
    [Arguments]    ${imie}    ${nazwisko}    ${ulica}    ${numer}    ${kod}    ${miasto}
    ...    ${data}    ${email}    ${telefon}    ${pass1}    ${pass2}    ${accept}=True
    Click Link    ${rejestracjaId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zarejestruj się
    Input Text    ${nameId}    ${imie}
    Input Text    ${surnameId}    ${nazwisko}
    Input Text    ${streeteId}    ${ulica}
    Input Text    ${streetnoId}    ${numer}
    Input Text    ${zipId}    ${kod}
    Input Text    ${cityId}    ${miasto}
    Input Text    ${dataId}    ${data}
    Input Text    ${emailId}    ${email}
    Input Text    ${phoneId}    ${telefon}
    Input Text    ${passId}    ${pass1}
    Input Text    ${pass2Id}    ${pass2}
    Run Keyword If    ${accept}==True    Click Element    ${akceptacjaBtn}
    Click Element    //*[@value="Zatwierdź"]
