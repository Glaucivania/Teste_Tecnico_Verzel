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

  @CT-19 @regressao @api @P2
  Esquema do Cenário: CT-19 Pedido com dados do cliente inválidos
    Resultado da execução: Passou. Evidência: evidencias/CT-19_nome-sem-sobrenome.jpeg.

    Quando envio "POST {{base}}/pedidos" com 1 "P005", nome "<nome>", e-mail "<email>" e CEP "<cep>"
    Então o status é 422 e o código é "DADOS_INVALIDOS"
    E "campos" aponta "<campo>" com a mensagem "<mensagem>"

    Exemplos:
      | nome        | email             | cep      | campo         | mensagem                      |
      | Maria       | maria@exemplo.com | 01310100 | cliente.nome  | Informe nome e sobrenome.     |
      | Maria Silva | maria@exemplo     | 01310100 | cliente.email | Informe um e-mail válido.     |
      | Maria Silva | maria@exemplo.com | 0131010  | cliente.cep   | Informe um CEP com 8 dígitos. |
