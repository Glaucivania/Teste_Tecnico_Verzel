# language: pt
@api
Funcionalidade: API de produtos, cálculo de carrinho e pedidos
  Como consumidor da API da Verzel Store
  Quero calcular carrinhos e confirmar pedidos
  Para ter valores corretos e erros claros

  Ambiente de execução: loja v2.3.0, requisições feitas no Postman, em 2026-10-06.

  Contexto:
    Dado que a API está em "https://verzel-store.qa-test-verzel-store.workers.dev/api"
    E que as requisições usam "Content-Type: application/json"
    E que uso o Postman, com a variável "base" igual à URL da API
    E que cada requisição com corpo usa o método POST e o corpo no formato Raw JSON

  @CT-13 @smoke @regressao @api @P2
  Cenário: CT-13 Listar produtos e consultar um produto
    Resultado da execução: Passou. Evidência: evidencias/CT-13_produtos-lista.jpeg.

    Quando envio "GET {{base}}/produtos"
    Então o status é 200 e a lista tem 8 produtos, de P001 a P008
    Quando envio "GET {{base}}/produtos/P001"
    Então o status é 200 e o produto é "Camiseta Essencial" com preço 59.9
    Quando envio "GET {{base}}/produtos/P999"
    Então o status é 404 com o código "PRODUTO_NAO_ENCONTRADO"
