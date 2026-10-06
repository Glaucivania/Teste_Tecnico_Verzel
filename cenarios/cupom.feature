# language: pt
@cupom
Funcionalidade: Cupom de desconto no carrinho
  Como cliente da Verzel Store
  Quero aplicar um cupom de desconto no carrinho
  Para pagar menos nas minhas compras

  Contexto:
    Dado que o carrinho está vazio

  @CT-01 @smoke @regressao @ui @P1 @automatizado
  Cenário: CT-01 Aplicar o cupom BEMVINDO10 dá 10% sobre o subtotal (CA01)
    Dado que adicionei "Camiseta Essencial" ao carrinho
    Quando aplico o cupom "BEMVINDO10"
    Então vejo a mensagem "Cupom BEMVINDO10 aplicado."
    E o subtotal é "R$ 59,90"
    E o desconto é "- R$ 5,99"
    E o frete é "R$ 19,90"
    E o total é "R$ 73,81"

  @CT-02 @regressao @ui @P1
  Esquema do Cenário: CT-02 O código do cupom ignora maiúsculas e espaços nas pontas (CA02)
    Dado que adicionei "Camiseta Essencial" ao carrinho
    Quando aplico o cupom "<codigo>"
    Então o cupom "BEMVINDO10" fica aplicado
    E o desconto é "- R$ 5,99"

    Exemplos:
      | codigo         |
      | bemvindo10     |
      | BemVindo10     |
      |   BEMVINDO10   |
      |   bemvindo10   |

  @CT-03 @smoke @regressao @ui @P1
  Cenário: CT-03 Cupom inexistente exibe "Cupom inválido." e não dá desconto (CA03)
    Dado que adicionei "Camiseta Essencial" ao carrinho
    Quando aplico o cupom "INEXISTENTE"
    Então vejo a mensagem "Cupom inválido."
    E o desconto é "R$ 0,00"
    E o total é "R$ 79,80"

  @CT-04 @smoke @regressao @ui @P1
  Cenário: CT-04 Cupom expirado exibe "Cupom expirado." e não dá desconto (CA04)
    Dado que adicionei "Camiseta Essencial" ao carrinho
    Quando aplico o cupom "VERAO2026"
    Então vejo a mensagem "Cupom expirado."
    E o desconto é "R$ 0,00"
    E o total é "R$ 79,80"

  @CT-05 @regressao @ui @P3
  Esquema do Cenário: CT-05 Cupom vazio ou cupom com carrinho vazio não aplica desconto (AMB-05, AMB-08)
    Dado que o carrinho tem <itens>
    Quando aplico o cupom "<codigo>"
    Então nenhum cupom fica aplicado
    E o desconto é "R$ 0,00"
    E vejo um feedback claro ao usuário

    Exemplos:
      | itens                  | codigo     |
      | "Camiseta Essencial"   |            |
      | "Camiseta Essencial"   | somente espaços |
      | nenhum item            | BEMVINDO10 |

  @CT-06 @regressao @ui @P2
  Cenário: CT-06 Só um cupom por vez e sem acúmulo ao reaplicar (CA05, AMB-06, AMB-07)
    Dado que adicionei "Camiseta Essencial" ao carrinho
    E que apliquei o cupom "BEMVINDO10"
    Quando aplico o cupom "BEMVINDO10" novamente
    Então o desconto continua "- R$ 5,99"
    Quando tento aplicar o cupom "VERAO2026" com o "BEMVINDO10" ainda ativo
    Então o cupom "BEMVINDO10" continua aplicado
    E há apenas um cupom ativo

  @CT-07 @regressao @ui @P1
  Cenário: CT-07 Remover item ou cupom recalcula desconto e frete (AMB-04)
    Dado que adicionei "Calça Jeans Slim" ao carrinho
    E que adicionei "Boné Aba Curva" ao carrinho com quantidade 2
    E que apliquei o cupom "BEMVINDO10"
    Então o subtotal é "R$ 239,70"
    E o desconto é "- R$ 23,97"
    E o frete é "Grátis"
    E o total é "R$ 215,73"
    Quando removo "Calça Jeans Slim" do carrinho
    Então o subtotal é "R$ 99,80"
    E o desconto é "- R$ 9,98"
    E o frete é "R$ 19,90"
    E o total é "R$ 109,72"
    Quando removo o cupom
    Então o desconto é "R$ 0,00"
    E o total é "R$ 119,70"
