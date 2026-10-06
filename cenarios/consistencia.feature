# language: pt
@consistencia
Funcionalidade: Consistência entre interface e API
  A interface apenas exibe o que a API calcula. Os valores precisam ser iguais.

  @CT-24 @regressao @ui @api @P1
  Esquema do Cenário: CT-24 Valores da interface iguais aos da API para o mesmo carrinho
    Dado que o carrinho tem <itens> e o cupom "<cupom>"
    Quando comparo o resumo exibido com a resposta de "/api/carrinho/calcular"
    Então subtotal, desconto, frete e total são iguais nas duas camadas
    E o frete grátis e o valor faltante são coerentes entre si

    Exemplos:
      | itens                    | cupom       |
      | 1 Camiseta Essencial     | BEMVINDO10  |
      | 4 Garrafa Térmica 750ml  |             |
      | 4 Garrafa Térmica 750ml  | BEMVINDO10  |
      | 1 Jaqueta Corta-Vento    | BEMVINDO10  |
