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

  @CT-04 @regressao @ui @P2
  Cenário: CT-04 Só um cupom por vez, sem acúmulo, e casos de borda do campo (CA05, AMB-05 a AMB-08)
    Resultado da execução: Passou. Evidência: evidencias/CT-04_cupom-unico-e-casos-de-borda-ui.png.
    Pela interface não é possível reaplicar o mesmo cupom nem aplicar um segundo sem remover o atual.

    Dado que abri uma nova aba na loja
    E que adicionei 1 "Camiseta Essencial" pela vitrine e abri o "Carrinho"
    Quando clico em "Aplicar cupom" com o campo "Cupom de desconto" vazio
    Então vejo a mensagem "Informe um cupom."
    E vejo desconto "R$ 0,00"
    Quando digito apenas espaços no campo "Cupom de desconto" e clico em "Aplicar cupom"
    Então vejo a mensagem "Informe um cupom."
    Quando digito "BEMVINDO10" no campo "Cupom de desconto" e clico em "Aplicar cupom"
    Então o campo "Cupom de desconto" deixa de ser exibido e resta o botão "Remover cupom"
    E vejo desconto "- R$ 5,99", sem acúmulo
    E não existe como aplicar um segundo cupom sem clicar em "Remover cupom"
    Quando clico em "Esvaziar carrinho"
    Então vejo "Seu carrinho está vazio" e o botão "Ver produtos"
    E não existe campo de cupom
