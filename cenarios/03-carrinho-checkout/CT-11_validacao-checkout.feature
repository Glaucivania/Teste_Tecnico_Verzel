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

  @CT-11 @regressao @ui @P2
  Esquema do Cenário: CT-11 Validação de nome, e-mail e CEP no checkout
    Resultado da execução: Passou. Evidência: evidencias/CT-11_validacao-checkout-ui.png.

    Dado que abri uma nova aba na loja
    E que adicionei 1 "Mochila Urbana 20L" pela vitrine e abri o "Carrinho"
    Quando clico em "Finalizar compra"
    E preencho "Nome completo" com "<nome>"
    E preencho "E-mail" com "<email>"
    E preencho "CEP" com "<cep>"
    E clico em "Confirmar pedido"
    Então o resultado é "<resultado>"

    Exemplos:
      | nome        | email             | cep       | resultado                                |
      | Maria       | maria@exemplo.com | 01310100  | bloqueado: Informe nome e sobrenome.     |
      | Maria Silva | maria@exemplo     | 01310100  | bloqueado: Informe um e-mail válido.     |
      | Maria Silva | maria@exemplo.com | 0131010   | bloqueado: Informe um CEP com 8 dígitos. |
      | Maria Silva | maria@exemplo.com | 013101000 | bloqueado: Informe um CEP com 8 dígitos. |
      | Maria Silva | maria@exemplo.com | 01310-100 | aceito: pedido confirmado                |
      | Maria Silva | maria@exemplo.com | 01310100  | aceito: pedido confirmado                |
