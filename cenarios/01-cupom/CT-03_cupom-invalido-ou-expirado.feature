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

  @CT-03 @smoke @regressao @ui @P1
  Esquema do Cenário: CT-03 Cupom inexistente ou expirado não dá desconto e informa o motivo (CA03, CA04)
    Resultado da execução: Passou. Evidência: evidencias/CT-03_cupom-invalido-expirado-ui.png.

    Dado que abri uma nova aba na loja
    E que adicionei 1 "Camiseta Essencial" pela vitrine e abri o "Carrinho"
    Quando digito "<codigo>" no campo "Cupom de desconto"
    E clico em "Aplicar cupom"
    Então vejo a mensagem "<mensagem>"
    E vejo desconto "R$ 0,00" e total "R$ 79,80"

    Exemplos:
      | codigo      | mensagem        |
      | INEXISTENTE | Cupom inválido. |
      | VERAO2026   | Cupom expirado. |
