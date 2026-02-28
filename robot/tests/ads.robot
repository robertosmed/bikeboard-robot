*** Settings ***
Documentation     Suite de testes para cadastro de anúncios de bicicletas.

Library           Browser    jsextension=${EXECDIR}/robot/resources/mocks/ads.js

Resource          ../resources/base.resource

Test Setup        Begin Web Test
Test Teardown     End Web Test

*** Variables ***
&{MY_BIKE}    title=Caloi Cross 1994 - clássica e conservada
...           description=Relíquia dos anos 90! Bicicleta Caloi Cross original, toda revisada e em excelente estado. Pneus novos, pintura retrô preservada e selim original da época. Ideal para colecionadores e fãs de bikes vintage.
...           brand=Caloi
...           model=Cross Aro 20
...           price=${1800}
...           year=${1994}
...           sellerName=Fernando Papito
...           whatsapp=11930091001

*** Test Cases ***
Deve cadastrar um anúncio com sucesso
    [Tags]    success    smoke
    
    Ad Creation Mock    ${MY_BIKE}

    Click Advertise Link
    Fill Ad Form              ${MY_BIKE}
    Submit Ad Form

    Wait For Elements State     h3 >> text=Anúncio Enviado com Sucesso!    visible
    
    Wait For Elements State     text=Obrigado por escolher o BikeBoard para anunciar sua bicicleta    visible
    Wait For Elements State     text=Seu anúncio foi enviado para nossa equipe de moderação    visible

Deve exibir erros para todos os campos obrigatórios não preenchidos
    [Tags]    validation
    Click Advertise Link
    Submit Ad Form

    @{Alerts}=    Create List
    ...    Título deve ter pelo menos 10 caracteres
    ...    Descrição deve ter pelo menos 30 caracteres
    ...    Marca é obrigatória
    ...    Modelo é obrigatório
    ...    Preço mínimo é R$ 100
    ...    Nome é obrigatório
    ...    WhatsApp inválido (formato: 11999999999)

    FOR    ${msg}    IN    @{Alerts}
        Wait For Elements State     text=${msg}    visible
    END

Deve exibir erro quando o WhatsApp tem formato inválido
    [Tags]    validation    temp
    ${TestData}=    Create Dictionary    &{MY_BIKE}    whatsapp=1111
    
    Click Advertise Link
    Fill Ad Form       ${TestData}
    Submit Ad Form

    Wait For Elements State     text=WhatsApp inválido (formato: 11999999999)    visible

Deve exibir erro quando o WhatsApp tem menos de 10 dígitos
    [Tags]    validation
     ${TestData}=    Create Dictionary    &{MY_BIKE}    whatsapp=119999999
    
    Click Advertise Link
    Fill Ad Form       ${TestData}
    Submit Ad Form

    Wait For Elements State     text=WhatsApp deve ter 10 ou 11 dígitos    visible

Deve exibir erro quando a descrição tem menos de 30 caracteres
    [Tags]    validation
    ${TestData}=    Create Dictionary    &{MY_BIKE}    description=Bike muito bonita!
    
    Click Advertise Link
    Fill Ad Form       ${TestData}
    Submit Ad Form

    Wait For Elements State     text=Descrição deve ter pelo menos 30 caracteres    visible

Deve mostrar erro quando o preço é menor que R$ 100
    [Tags]    validation
    ${TestData}=    Create Dictionary    &{MY_BIKE}    price=99
    
    Click Advertise Link
    Fill Ad Form       ${TestData}
    Submit Ad Form

    Wait For Elements State     text=Preço mínimo é R$ 100    visible