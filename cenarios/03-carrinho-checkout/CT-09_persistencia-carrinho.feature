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

  @CT-09 @regressao @ui @P2
  Cenário: CT-09 O carrinho e o cupom persistem ao recarregar a aba (AMB-01)
    Resultado da execução: Passou. Evidência: evidencias/CT-09_persistencia-ui.png.

    Dado que abri uma nova aba na loja
    E que montei 5 "Camiseta Essencial" no carrinho, usando o botão "+"
    E que apliquei o cupom "BEMVINDO10"
    Quando pressiono F5 para recarregar a página
    Então vejo 5 unidades de "Camiseta Essencial"
    E vejo "Cupom BEMVINDO10 aplicado."
    E vejo total "R$ 269,55"
    Quando clico em "Esvaziar carrinho" e adiciono 1 "Mochila Urbana 20L"
    Então o cupom não está mais aplicado
