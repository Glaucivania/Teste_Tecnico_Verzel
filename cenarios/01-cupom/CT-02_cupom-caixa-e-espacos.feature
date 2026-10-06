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

  @CT-02 @regressao @ui @P1
  Esquema do Cenário: CT-02 O código do cupom ignora maiúsculas e espaços nas pontas (CA02)
    Resultado da execução: Passou. Evidência: evidencias/CT-02_caixa-e-espacos-ui.png.
    O código "  bemvindo10  " também foi exercitado no CT-01.

    Dado que abri uma nova aba na loja
    E que adicionei 1 "Camiseta Essencial" pela vitrine e abri o "Carrinho"
    Quando digito "<codigo>" no campo "Cupom de desconto"
    E clico em "Aplicar cupom"
    Então vejo a mensagem "Cupom BEMVINDO10 aplicado."
    E vejo desconto "- R$ 5,99" e total "R$ 73,81"

    Exemplos:
      | codigo         |
      | bemvindo10     |
      | BemVindo10     |
      |   BEMVINDO10   |
