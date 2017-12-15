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
