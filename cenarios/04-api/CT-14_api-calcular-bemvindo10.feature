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

  @CT-14 @smoke @regressao @api @P1 @automatizado
  Cenário: CT-14 Calcular um carrinho com BEMVINDO10 (exemplo da documentação)
    Resultado da execução: Passou. Evidência: evidencias/CT-14_calcular-bemvindo10.png.
    Automatizado em automacao/tests/calculo.api.spec.ts.

    Quando envio "POST {{base}}/carrinho/calcular" com o corpo
      """
      {
        "itens": [
          { "produtoId": "P002", "quantidade": 1 },
          { "produtoId": "P004", "quantidade": 2 }
        ],
        "cupom": "BEMVINDO10"
      }
      """
    Então o status é 200
    E o subtotal é 239.7 e o desconto é 23.97
    E o frete é 0, "freteGratis" é true e "valorFaltanteFreteGratis" é 0
    E o total é 215.73
    E "cupom.aplicado" é true
