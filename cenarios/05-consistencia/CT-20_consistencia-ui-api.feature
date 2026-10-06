# language: pt
@consistencia
Funcionalidade: Consistência entre interface e API
  A interface apenas exibe o que a API calcula. Os valores precisam ser iguais.

  Ambiente de execução: loja v2.3.0, Google Chrome 153 (UI) e Postman (API), em 2026-10-06.

  @CT-20 @regressao @ui @api @P1
  Esquema do Cenário: CT-20 Os valores da interface são iguais aos da API para o mesmo carrinho
    Resultado da execução: Passou. Evidência: evidencias/CT-20_consistencia-ui-vs-api.png.
    As duas camadas são iguais entre si, inclusive no erro do limite de R$ 200,00 (BUG-001),
    que é coberto pelos cenários CT-06, CT-07 e CT-16.
    As requisições da API estão na pasta "CT-20 Consistência UI e API" da coleção do Postman.

    Dado que abri uma nova aba na loja
    E que montei o carrinho com <itens> e apliquei o cupom "<cupom>", quando houver
    E que abri o "Carrinho"
    Quando leio na tela subtotal, desconto, frete e total
    E envio "POST {{base}}/carrinho/calcular" com o mesmo carrinho e o mesmo cupom
    Então subtotal, desconto, frete e total são iguais na tela e na API
    E "freteGratis" e "valorFaltanteFreteGratis" são coerentes entre si e com a tela

    Exemplos:
      | itens                   | cupom      | total na tela |
      | 1 Camiseta Essencial    | BEMVINDO10 | R$ 73,81      |
      | 4 Garrafa Térmica 750ml |            | R$ 219,90     |
      | 4 Garrafa Térmica 750ml | BEMVINDO10 | R$ 199,90     |
      | 1 Jaqueta Corta-Vento   | BEMVINDO10 | R$ 206,91     |
