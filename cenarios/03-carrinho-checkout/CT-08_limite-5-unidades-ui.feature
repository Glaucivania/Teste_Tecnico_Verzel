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

  @CT-08 @regressao @ui @P1
  Cenário: CT-08 Limite de 5 unidades por produto na interface (CA10, AMB-02)
    Resultado da execução: Passou. Evidência: evidencias/CT-08_limite-5-unidades-ui.png.
    A interface não permite chegar a 6 unidades. O valor 6 foi coberto pela API no CT-17 (BUG-002).

    Dado que abri uma nova aba na loja
    E que adicionei 1 "Camiseta Essencial" pela vitrine, abri o "Carrinho" e apliquei o cupom "BEMVINDO10"
    Então o botão "-" está desabilitado
    Quando clico 3 vezes no botão "+"
    Então a quantidade exibida é 4
    E vejo subtotal "R$ 239,60", desconto "- R$ 23,96", frete "Grátis" e total "R$ 215,64"
    Quando clico mais uma vez no botão "+"
    Então a quantidade exibida é 5
    E vejo "Limite de 5 unidades por produto."
    E o botão "+" está desabilitado
    E vejo total "R$ 269,55"
