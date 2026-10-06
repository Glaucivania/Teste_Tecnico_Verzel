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

  @CT-17 @regressao @api @P2
  Esquema do Cenário: CT-17 Erros de validação e de protocolo da API (CA10)
    Resultado da execução: Falhou em duas linhas: 6 unidades em calcular respondeu 200 e 6 unidades em pedidos
    respondeu 201 (VZ-737777), em vez de 422 (BUG-002). As demais passaram.
    A quantidade 1000000 também foi aceita em calcular (sessão exploratória SE-02).
    Evidência: evidencias/CT-17_quantidade-6.jpeg.

    Quando envio <requisicao>
    Então o status é <status> e o código de erro é "<codigo>"

    Exemplos:
      | requisicao                                                  | status | codigo                     |
      | POST calcular com 6 unidades de "P001"                      | 422    | QUANTIDADE_MAXIMA_EXCEDIDA |
      | POST pedidos com cliente válido e 6 unidades de "P001"      | 422    | QUANTIDADE_MAXIMA_EXCEDIDA |
      | POST calcular com quantidade 0                              | 422    | QUANTIDADE_INVALIDA        |
      | POST calcular com quantidade 1.5                            | 422    | QUANTIDADE_INVALIDA        |
      | POST calcular com a lista de itens vazia                    | 422    | ITENS_OBRIGATORIOS         |
      | POST calcular com "P001" repetido nos itens                 | 422    | ITEM_DUPLICADO             |
      | POST calcular com o produto "P999"                          | 422    | PRODUTO_NAO_ENCONTRADO     |
      | POST calcular com o corpo em texto puro "nao e json"        | 400    | JSON_INVALIDO              |
      | GET em "{{base}}/carrinho/calcular"                         | 405    | METODO_NAO_PERMITIDO       |
      | GET em "{{base}}/rota-inexistente"                          | 404    | ROTA_NAO_ENCONTRADA        |
