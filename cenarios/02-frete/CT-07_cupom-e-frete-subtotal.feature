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

  @CT-07 @regressao @ui @P1
  Cenário: CT-07 O frete grátis usa o subtotal antes do cupom (CA08)
    Resultado da execução: Falhou (BUG-001). O erro chega também ao pedido confirmado (frete R$ 19,90 e total R$ 199,90).
    Evidência: evidencias/CT-07_cupom-e-frete-ui-vs-api.png.

    Dado que abri uma nova aba na loja
    E que adicionei 4 "Garrafa Térmica 750ml" pela vitrine, clicando 4 vezes em "Adicionar ao carrinho"
    E que abri o "Carrinho"
    Quando digito "BEMVINDO10" no campo "Cupom de desconto"
    E clico em "Aplicar cupom"
    Então vejo subtotal "R$ 200,00", desconto "- R$ 20,00", frete "Grátis" e total "R$ 180,00"
    Quando clico em "Finalizar compra"
    E preencho "Nome completo" com "Maria Silva"
    E preencho "E-mail" com "maria@exemplo.com"
    E preencho "CEP" com "01310-100"
    E clico em "Confirmar pedido"
    Então o pedido confirmado mostra frete "Grátis" e total "R$ 180,00"
