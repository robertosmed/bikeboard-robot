*** Settings ***
Library    Browser

*** Keywords ***
Click Advertise Link
    [Documentation]    Clica no link para anunciar e verifica se a página correta foi carregada.
    Click    a >> text=Anunciar Grátis
    Wait For Elements State    h3 >> text=Anunciar Bicicleta    visible

Fill Ad Form
    [Arguments]    ${Bike}
    [Documentation]    Preenche o formulário de anúncio com os dados fornecidos.
    Fill Text    label:has-text("Título do Anúncio *") >> .. >> input    ${Bike.title}
    Fill Text    label:has-text("Descrição Detalhada *") >> .. >> textarea    ${Bike.description}
    Select Options By    select    text    ${Bike.brand}
    Fill Text    label:has-text("Modelo *") >> .. >> input    ${Bike.model}
    Fill Text    label:has-text("Preço (R$) *") >> .. >> input    ${Bike.price}
    Fill Text    label:has-text("Ano de Fabricação *") >> .. >> input    ${Bike.year}
    Fill Text    label:has-text("Seu Nome *") >> .. >> input    ${Bike.sellerName}
    Fill Text    label:has-text("WhatsApp *") >> .. >> input    ${Bike.whatsapp}

Submit Ad Form
    [Documentation]    Clica no botão para submeter o formulário de anúncio.
    Click    button >> text=Publicar Anúncio
