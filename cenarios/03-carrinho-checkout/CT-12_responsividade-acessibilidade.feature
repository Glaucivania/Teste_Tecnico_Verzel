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

  @CT-12 @regressao @ui @P3
  Cenário: CT-12 Responsividade e acessibilidade básicas
    Resultado da execução: Passou. Evidência: evidencias/CT-12_responsividade-e-acessibilidade.png.
    Sem leitor de tela e sem ferramenta de contraste.

    Dado que abri uma nova aba na loja
    E que adicionei 1 "Calça Jeans Slim" e 2 "Boné Aba Curva" pela vitrine
    E que abri o "Carrinho"
    Quando abro as ferramentas do desenvolvedor com F12
    E ativo o modo dispositivo com Ctrl + Shift + M
    E defino a tela em 375 x 812
    Então não há barra de rolagem horizontal
    E nada passa da borda direita da tela
    E os botões continuam fáceis de tocar
    Quando volto à tela normal e pressiono a tecla Tab 12 vezes
    Então o foco passa por links, quantidade, remover, campo de cupom, "Aplicar cupom" e "Finalizar compra", nessa ordem
    E todo elemento focado mostra contorno visível
    Quando abro a aba "Elements" do DevTools
    Então vejo o idioma da página "pt-BR" e exatamente 1 título h1
    E todo botão, link e campo tem um nome legível
