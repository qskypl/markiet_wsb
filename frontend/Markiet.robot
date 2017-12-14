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
Projekty
    Click Element    ${projektyId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain Link    ${taigaLink}
    Page Should Contain Link    ${testLink}
    Page Should Contain Link    ${gitLink}
    Page Should Contain Link    ${googleLink}

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

[0]Przypomnienie
    Przypomnienie    ${EMPTY}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Podaj nazwę użytkownika

[-]Przypomnienie
    Przypomnienie    ${emailTest}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Użytkownik o tym adresie email nie istnieje

[+]Przypomnienie
    Przypomnienie    ${emailGood}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Na podany adres e-mail ${emailGood} zostało wysłane nowe hasło

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

Rejestracja do logowania
    Click Element    ${rejestracjaId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zarejestruj się
    Click Link    ${logowanieLink}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się

Przypomnienie do logowania
    Click Element    ${logowanieId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się
    Click Link    ${przypomnienieLink}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zresetuj hasło
    Click Link    ${logowanieLink}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się

[0]Szukaj
    Click Element    ${szukajId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain Element    ${szukajFiltryId}
    Wait Until Keyword Succeeds    5    1    Click Button    ${szukajBtn}
    Wait Until Keyword Succeeds    5    1    Page Should Contain Element    //*[@class="modal-content"]
    Page Should Contain    Podaj przynajmniej jeden parametr do szukania!

[-]Szukaj
    Click Element    ${szukajId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain Element    ${szukajFiltryId}
    Wait Until Keyword Succeeds    5    1    Click Button    ${szukajBtn}
    Wait Until Keyword Succeeds    5    1    Page Should Contain Element    //*[@class="modal-content"]
    Page Should Contain    Brak ofert spełniających podane kryteria

[+]Szukaj
    Click Element    ${szukajId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain Element    ${szukajFiltryId}
    Click Element    ${szukajTypId}
    Capture Page Screenshot
    Comment    Select From List    ${szukajKategoriaId}    data-original-index="2"
    Comment    Input Text    ${szukajNazwaId}    Elektryczna
    Comment    Input Text    ${szukajKwotaId}    50
    Comment    Input Text    ${szukajUlicaId}    Grunwaldzka
    Comment    Input Text    ${szukajNumerId}    238
    Comment    Input Text    ${szukajKodId}    80-266
    Comment    Input Text    ${szukajMiastoId}    Gdańsk
    Comment    Wait Until Keyword Succeeds    5    1    Click Button    ${szukajBtn}
    Comment    Wait Until Keyword Succeeds    5    1    Page Should Contain Element    //*[@class="modal-content"]
    Comment    Page Should Contain    Podaj przynajmniej jeden parametr do szukania!

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

Przypomnienie
    [Arguments]    ${mail}
    Click Element    ${logowanieId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zaloguj się
    Click Link    ${przypomnienieLink}
    Wait Until Keyword Succeeds    5    1    Page Should Contain    Zresetuj hasło
    Input Text    ${emailId}    ${mail}
    Click Button    Wyślij nowe hasło
