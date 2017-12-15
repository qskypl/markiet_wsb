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
Strona
    Page Should Contain Element    ${projektyId}
    Page Should Contain Element    ${szukajId}
    Page Should Contain Element    ${wystawId}
    Page Should Contain Element    ${rejestracjaId}
    Page Should Contain Element    ${logowanieId}

Projekty
    Click Element    ${projektyId}
    Wait Until Keyword Succeeds    5    1    Page Should Contain Link    ${taigaLink}
    Page Should Contain Link    ${testLink}
    Page Should Contain Link    ${gitLink}
    Page Should Contain Link    ${googleLink}

*** Keywords ***
Test setup
    Open Browser    http://www.beta.markiet.pl    Chrome
    Maximize Browser Window
    Wait Until Keyword Succeeds    5    1    Page Should Contain Image    ./img/uslugi2.png

Test teardown
    Close Browser
