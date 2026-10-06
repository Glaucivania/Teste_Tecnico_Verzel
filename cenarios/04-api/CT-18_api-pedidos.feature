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

  @CT-18 @smoke @regressao @api @P1
  Cenário: CT-18 Confirmar um pedido e rejeitar cupom inválido ou expirado
    Resultado da execução: Passou. Evidência: evidencias/CT-18_pedido-bemvindo10.png.

    Quando envio "POST {{base}}/pedidos" com o corpo
      """
      {
        "cliente": { "nome": "Maria Silva", "email": "maria@exemplo.com", "cep": "01310-100" },
        "itens": [ { "produtoId": "P005", "quantidade": 1 } ],
        "cupom": "BEMVINDO10"
      }
      """
    Então o status é 201 e o número do pedido segue o formato "VZ-000000"
    E o subtotal é 100, o desconto é 10, o frete é 19.9 e o total é 109.9
    E o CEP volta sem hífen, como "01310100"
    Quando envio o mesmo pedido com o cupom "INEXISTENTE"
    Então o status é 422, o código é "CUPOM_INVALIDO" e o campo é "cupom"
    Quando envio o mesmo pedido com o cupom "VERAO2026"
    Então o status é 422, o código é "CUPOM_EXPIRADO" e o campo é "cupom"
