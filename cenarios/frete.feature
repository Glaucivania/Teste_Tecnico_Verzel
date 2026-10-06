# language: pt
@frete
Funcionalidade: Frete grátis e cálculo de totais
  Como cliente da Verzel Store
  Quero ganhar frete grátis em compras a partir de R$ 200,00
  Para pagar menos nas minhas compras

  Regras de negócio: frete grátis a partir de R$ 200,00, inclusive; abaixo disso R$ 19,90.
  O frete considera o subtotal antes do desconto. O desconto não incide sobre o frete.
  Nota: com o catálogo fixo não é possível montar subtotais de 199,99 e 200,01.
  Os valores mais próximos do limite são 199,90 (abaixo), 200,00 (exato) e 229,90 (acima).

  Contexto:
    Dado que o carrinho está vazio

  @CT-08 @smoke @regressao @ui @P1 @automatizado
  Esquema do Cenário: CT-08 Limite do frete grátis na interface (CA06, CA07)
    Dado que o carrinho tem <itens>
    Então o subtotal é "<subtotal>"
    E o frete é "<frete>"
    E o total é "<total>"
    E a mensagem de frete grátis é "<mensagem>"

    Exemplos:
      | itens                                    | subtotal   | frete    | total      | mensagem                              |
      | 1 Boné Aba Curva e 3 Garrafa Térmica 750ml | R$ 199,90  | R$ 19,90 | R$ 219,80  | Faltam R$ 0,10 para o frete grátis.   |
      | 4 Garrafa Térmica 750ml                  | R$ 200,00  | Grátis   | R$ 200,00  | nenhuma                               |
      | 1 Jaqueta Corta-Vento                    | R$ 229,90  | Grátis   | R$ 229,90  | nenhuma                               |

  @CT-09 @regressao @ui @P1 @automatizado
  Cenário: CT-09 O frete grátis usa o subtotal antes do cupom (CA08)
    Dado que o carrinho tem 4 Garrafa Térmica 750ml
    Quando aplico o cupom "BEMVINDO10"
    Então o subtotal é "R$ 200,00"
    E o desconto é "- R$ 20,00"
    E o frete é "Grátis"
    E o total é "R$ 180,00"

  @CT-10 @regressao @ui @P1
  Cenário: CT-10 O desconto do cupom não incide sobre o frete (CA09)
    Dado que o carrinho tem 1 Mochila Urbana 20L
    Quando aplico o cupom "BEMVINDO10"
    Então o subtotal é "R$ 100,00"
    E o desconto é "- R$ 10,00"
    E o frete é "R$ 19,90"
    E o total é "R$ 109,90"

  @CT-11 @regressao @ui @api @P2
  Esquema do Cenário: CT-11 Valores com 2 casas decimais, sem erro de ponto flutuante (CA11)
    Dado que o carrinho tem <itens>
    E que apliquei o cupom "BEMVINDO10"
    Então o subtotal é "<subtotal>"
    E o desconto é "<desconto>"
    E o total é "<total>"
    E a API devolve os mesmos valores com no máximo 2 casas decimais

    Exemplos:
      | itens                          | subtotal  | desconto   | total      |
      | 3 Camiseta Essencial           | R$ 179,70 | - R$ 17,97 | R$ 181,63  |
      | 3 Boné Aba Curva               | R$ 149,70 | - R$ 14,97 | R$ 154,63  |
      | 3 Kit 3 Pares de Meias         | R$ 89,70  | - R$ 8,97  | R$ 100,63  |
