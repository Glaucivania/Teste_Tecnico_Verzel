# language: pt
@frete
Funcionalidade: Frete grátis e cálculo de totais
  Como cliente da Verzel Store
  Quero ganhar frete grátis em compras a partir de R$ 200,00
  Para pagar menos nas minhas compras

  Regras de negócio: frete grátis a partir de R$ 200,00, inclusive; abaixo disso R$ 19,90.
  O frete considera o subtotal antes do desconto. O desconto não incide sobre o frete.
  Nota: com o catálogo fixo não é possível montar subtotais de 199,99 e 200,01.
  Os valores mais próximos do limite são 199,90 (abaixo), 200,00 (exato) e 229,90 (acima).
  Ambiente de execução: loja v2.3.0, Google Chrome 153 (UI) e Postman (API), em 2026-10-06.

  Contexto:
    Dado que a loja está aberta em "https://verzel-store.qa-test-verzel-store.workers.dev/"
    E que o carrinho da aba está vazio

  @CT-06 @smoke @regressao @ui @P1 @automatizado
  Esquema do Cenário: CT-06 Limite do frete grátis na interface (CA06, CA07)
    Resultado da execução: Falhou no subtotal de R$ 200,00 (BUG-001). Passou em 199,90 e em 229,90.
    Evidência: evidencias/CT-06_frete-limite-ui-vs-api.png.
    Automatizado em automacao/tests/frete.ui.spec.ts, com o caso de 200,00 marcado como test.fail.

    Dado que abri uma nova aba na loja
    E que montei o carrinho com <itens>, clicando em "Adicionar ao carrinho" na vitrine
    E que abri o "Carrinho", sem aplicar cupom
    Então vejo subtotal "<subtotal>", frete "<frete>" e total "<total>"
    E o aviso de frete grátis é "<aviso>"

    Exemplos:
      | itens                                      | subtotal  | frete    | total     | aviso                               |
      | 1 Boné Aba Curva e 3 Garrafa Térmica 750ml | R$ 199,90 | R$ 19,90 | R$ 219,80 | Faltam R$ 0,10 para o frete grátis. |
      | 4 Garrafa Térmica 750ml                    | R$ 200,00 | Grátis   | R$ 200,00 | nenhum                              |
      | 1 Jaqueta Corta-Vento                      | R$ 229,90 | Grátis   | R$ 229,90 | nenhum                              |
