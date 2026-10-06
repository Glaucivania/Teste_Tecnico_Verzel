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

  @CT-05 @regressao @ui @P1
  Cenário: CT-05 Remover item ou cupom recalcula desconto, frete e total com 2 casas decimais (AMB-04, CA11)
    Resultado da execução: Passou. Evidência: evidencias/CT-05_remover-item-e-cupom-ui.png.

    Dado que abri uma nova aba na loja
    E que adicionei 1 "Calça Jeans Slim" pela vitrine
    E que adicionei 2 "Boné Aba Curva" pela vitrine, clicando 2 vezes em "Adicionar ao carrinho"
    E que abri o "Carrinho" e apliquei o cupom "BEMVINDO10"
    Então vejo subtotal "R$ 239,70", desconto "- R$ 23,97", frete "Grátis" e total "R$ 215,73"
    Quando clico em "Remover" na "Calça Jeans Slim"
    Então vejo subtotal "R$ 99,80", desconto "- R$ 9,98", frete "R$ 19,90" e total "R$ 109,72"
    E vejo o aviso "Faltam R$ 100,20 para o frete grátis."
    Quando clico em "Remover cupom"
    Então vejo desconto "R$ 0,00" e total "R$ 119,70"
    Quando repito em abas novas, com o cupom "BEMVINDO10", carrinhos com 3 "Camiseta Essencial", 3 "Boné Aba Curva" e 3 "Kit 3 Pares de Meias"
    Então os totais são "R$ 181,63", "R$ 154,63" e "R$ 100,63"
    E todos os valores têm 2 casas decimais
