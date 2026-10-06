# language: pt
@cupom
Funcionalidade: Cupom de desconto no carrinho
  Como cliente da Verzel Store
  Quero aplicar um cupom de desconto no carrinho
  Para pagar menos nas minhas compras

  Ambiente de execução: loja v2.3.0, Google Chrome 153 (Windows 11), em 2026-10-06.
  O carrinho vive no sessionStorage da aba, então cada cenário parte de um carrinho próprio.

  Contexto:
    Dado que a loja está aberta em "https://verzel-store.qa-test-verzel-store.workers.dev/"
    E que o carrinho da aba está vazio

  @CT-01 @smoke @regressao @ui @P1 @automatizado
  Cenário: CT-01 BEMVINDO10 dá 10% sobre o subtotal e não incide sobre o frete (CA01, CA09)
    Resultado da execução: Passou. Evidência: evidencias/CT-01_aplicar-bemvindo10-ui.png.
    Automatizado em automacao/tests/cupom.ui.spec.ts.

    Dado que abri uma nova aba e a vitrine "/"
    E que cliquei 1 vez em "Adicionar ao carrinho" na "Camiseta Essencial"
    E que abri o "Carrinho"
    Então vejo subtotal "R$ 59,90", desconto "R$ 0,00", frete "R$ 19,90" e total "R$ 79,80"
    E vejo o aviso "Faltam R$ 140,10 para o frete grátis."
    Quando digito "  bemvindo10  " (minúsculas, com 2 espaços antes e depois) no campo "Cupom de desconto"
    E clico em "Aplicar cupom"
    E aguardo o resumo atualizar
    Então vejo a mensagem "Cupom BEMVINDO10 aplicado."
    E vejo desconto "- R$ 5,99", frete "R$ 19,90" e total "R$ 73,81"
    Quando clico em "Esvaziar carrinho"
    E adiciono 1 "Mochila Urbana 20L" pela vitrine e abro o "Carrinho"
    E aplico o cupom "BEMVINDO10"
    Então vejo subtotal "R$ 100,00", desconto "- R$ 10,00", frete "R$ 19,90", sem desconto, e total "R$ 109,90"
