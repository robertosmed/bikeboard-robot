*** Settings ***
Library           Browser
Resource          ./actions/ads.resource

*** Variables ***
${BASE_URL}       http://localhost:3000
${BROWSER}        chromium

*** Keywords ***
Begin Web Test
    [Documentation]    Navega para a página inicial e verifica o título.
    New Browser    ${BROWSER}    headless=Yes
    
    New Context    viewport={'width': 1920, 'height': 1080}
    
    New Page       ${BASE_URL}
    Get Title    ==    BikeBoard by Papito

End Web Test
    [Documentation]    Executado ao final de cada teste para tirar screenshot e salvar o vídeo.
    Take Screenshot
    
    Close Context