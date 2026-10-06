# language: pt
@carrinho
Funcionalidade: Carrinho, checkout e qualidade da interface
  Como cliente da Verzel Store
  Quero montar o carrinho e finalizar a compra
  Para receber meus produtos

  Ambiente de execução: loja v2.3.0, Google Chrome 153 (Windows 11), em 2026-10-06.

  Contexto:
    Dado que a loja está aberta em "https://verzel-store.qa-test-verzel-store.workers.dev/"
    E que o carrinho da aba está vazio

  @CT-10 @smoke @regressao @ui @P1
  Cenário: CT-10 Finalizar a compra com dados válidos confirma o pedido
    Resultado da execução: Passou. Evidência: evidencias/CT-10_checkout-ui.png.

    Dado que abri uma nova aba na loja
    E que adicionei 1 "Mochila Urbana 20L" pela vitrine e abri o "Carrinho"
    Quando clico em "Finalizar compra"
    Então estou na página "/checkout"
    Quando preencho "Nome completo" com "Maria Silva"
    E preencho "E-mail" com "maria@exemplo.com"
    E preencho "CEP" com "01310-100"
    E clico em "Confirmar pedido"
    Então estou na página "/pedido-confirmado"
    E vejo um número de pedido no formato "VZ-000000"
    E vejo subtotal "R$ 100,00", frete "R$ 19,90" e total "R$ 119,90"
