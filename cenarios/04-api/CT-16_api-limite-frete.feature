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

  @CT-16 @regressao @api @P1
  Esquema do Cenário: CT-16 Limite do frete grátis na API (CA06, CA07)
    Resultado da execução: Falhou no subtotal de R$ 200,00 (BUG-001), também com o cupom BEMVINDO10
    (frete 19.9 e total 199.9, esperado 0 e 180). Passou em 199,90 e em 229,90.
    Evidência: evidencias/CT-16_calcular-200-00.png.

    Quando envio "POST {{base}}/carrinho/calcular", sem cupom, com <itens>
    Então o status é 200
    E o frete é <frete> e "freteGratis" é <gratis>
    E "valorFaltanteFreteGratis" é <faltante>
    E o total é <total>

    Exemplos:
      | itens               | frete | gratis | faltante | total |
      | 1 "P004" e 3 "P008" | 19.9  | false  | 0.1      | 219.8 |
      | 4 "P008"            | 0     | true   | 0        | 200   |
      | 1 "P007"            | 0     | true   | 0        | 229.9 |
