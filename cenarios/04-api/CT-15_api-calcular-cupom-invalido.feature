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

  @CT-15 @regressao @api @P1
  Esquema do Cenário: CT-15 Calcular com cupom inválido ou expirado não gera erro (CA03, CA04)
    Resultado da execução: Passou. Evidência: evidencias/CT-15_calcular-cupom-expirado.png.
    Com subtotal 200 a API cobrou frete 19.9, o que é o BUG-001 e não afeta este cenário.

    Quando envio "POST {{base}}/carrinho/calcular" com 2 "P005" e o cupom "<cupom>"
    Então o status é 200, sem erro
    E o desconto é 0
    E "cupom.aplicado" é false
    E "cupom.mensagem" é "<mensagem>"

    Exemplos:
      | cupom       | mensagem        |
      | INEXISTENTE | Cupom inválido. |
      | VERAO2026   | Cupom expirado. |
