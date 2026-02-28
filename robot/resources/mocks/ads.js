async function AdCreationMock(page, testData) {
  
    await page.route('**/anuncios', route => route.fulfill({
        status: 201,
        contentType: "application/json",
        body: JSON.stringify({
          sucesso: true,
          mensagem: "Anúncio criado com sucesso!",
          anuncio: {
            id: 1,
            titulo: testData.title,
            descricao: testData.description,
            marca: testData.brand,
            modelo: testData.model,
            preco: testData.price,
            anoFabricacao: testData.year,
            nomeVendedor: testData.sellerName,
            whatsapp: testData.whatsapp,
            status: "em analise",
            criadoEm: new Date().toISOString(),
            atualizadoEm: new Date().toISOString()
          }
        })
    }))
  }
  
  exports.__esModule = true;
  exports.AdCreationMock = AdCreationMock;
  