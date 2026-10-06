# language: pt
@api
Funcionalidade: API de produtos, cálculo de carrinho e pedidos
  Como consumidor da API da Verzel Store
  Quero calcular carrinhos e confirmar pedidos
  Para ter valores corretos e erros claros

  Contexto:
    Dado que a API está em "/api"
    E que as requisições usam "Content-Type: application/json"

  @CT-17 @smoke @regressao @api @P2
  Cenário: CT-17 Listar produtos e consultar um produto
    Quando faço GET em "/api/produtos"
    Então o status é 200 e a lista tem 8 produtos
    Quando faço GET em "/api/produtos/P001"
    Então o status é 200 e o produto é "Camiseta Essencial" com preço 59.9
    Quando faço GET em "/api/produtos/P999"
    Então o status é 404 com o código "PRODUTO_NAO_ENCONTRADO"

  @CT-18 @smoke @regressao @api @P1 @automatizado
  Cenário: CT-18 Calcular carrinho com BEMVINDO10 (exemplo da documentação)
    Quando faço POST em "/api/carrinho/calcular" com 1 "P002", 2 "P004" e o cupom "BEMVINDO10"
    Então o status é 200
    E o subtotal é 239.7
    E o desconto é 23.97
    E o frete é 0 e "freteGratis" é verdadeiro
    E o total é 215.73
    E "cupom.aplicado" é verdadeiro

  @CT-19 @regressao @api @P1
  Esquema do Cenário: CT-19 Calcular com cupom inválido ou expirado não gera erro (CA03, CA04)
    Quando faço POST em "/api/carrinho/calcular" com 2 "P005" e o cupom "<cupom>"
    Então o status é 200
    E o desconto é 0
    E "cupom.aplicado" é falso
    E "cupom.mensagem" é "<mensagem>"

    Exemplos:
      | cupom       | mensagem          |
      | INEXISTENTE | Cupom inválido.   |
      | VERAO2026   | Cupom expirado.   |

  @CT-20 @regressao @api @P1
  Esquema do Cenário: CT-20 Limite do frete grátis na API (CA06, CA07)
    Quando faço POST em "/api/carrinho/calcular" com <itens>
    Então o frete é <frete> e "freteGratis" é <gratis>
    E "valorFaltanteFreteGratis" é <faltante>
    E o total é <total>

    Exemplos:
      | itens                    | frete | gratis      | faltante | total  |
      | 1 "P004" e 3 "P008"      | 19.9  | falso       | 0.1      | 219.8  |
      | 4 "P008"                 | 0     | verdadeiro  | 0        | 200    |
      | 1 "P007"                 | 0     | verdadeiro  | 0        | 229.9  |

  @CT-21 @regressao @api @P2
  Esquema do Cenário: CT-21 Erros de validação e de protocolo da API (CA10)
    Quando faço <requisicao>
    Então o status é <status> e o código de erro é "<codigo>"

    Exemplos:
      | requisicao                                              | status | codigo                      |
      | POST calcular com 6 unidades de "P001"                  | 422    | QUANTIDADE_MAXIMA_EXCEDIDA  |
      | POST calcular com quantidade 0                          | 422    | QUANTIDADE_INVALIDA         |
      | POST calcular com quantidade 1.5                        | 422    | QUANTIDADE_INVALIDA         |
      | POST calcular com lista de itens vazia                  | 422    | ITENS_OBRIGATORIOS          |
      | POST calcular com "P001" repetido                       | 422    | ITEM_DUPLICADO              |
      | POST calcular com produto "P999"                        | 422    | PRODUTO_NAO_ENCONTRADO      |
      | POST calcular com corpo que não é JSON                  | 400    | JSON_INVALIDO               |
      | GET em "/api/carrinho/calcular"                         | 405    | METODO_NAO_PERMITIDO        |
      | GET em "/api/rota-inexistente"                          | 404    | ROTA_NAO_ENCONTRADA         |

  @CT-22 @smoke @regressao @api @P1
  Cenário: CT-22 Confirmar pedido e rejeitar cupom inválido ou expirado
    Quando faço POST em "/api/pedidos" com cliente válido, 1 "P005" e o cupom "BEMVINDO10"
    Então o status é 201 e o número do pedido segue o formato "VZ-000000"
    E o subtotal é 100 e o desconto é 10 e o frete é 19.9 e o total é 109.9
    E o CEP volta sem hífen
    Quando faço POST em "/api/pedidos" com o cupom "INEXISTENTE"
    Então o status é 422 e o código é "CUPOM_INVALIDO"
    Quando faço POST em "/api/pedidos" com o cupom "VERAO2026"
    Então o status é 422 e o código é "CUPOM_EXPIRADO"

  @CT-23 @regressao @api @P2
  Esquema do Cenário: CT-23 Pedido com dados do cliente inválidos
    Quando faço POST em "/api/pedidos" com nome "<nome>", e-mail "<email>" e CEP "<cep>"
    Então o status é 422 e o código é "DADOS_INVALIDOS"
    E "campos" indica o dado inválido

    Exemplos:
      | nome        | email             | cep       |
      | Maria       | maria@exemplo.com | 01310100  |
      | Maria Silva | maria@exemplo     | 01310100  |
      | Maria Silva | maria@exemplo.com | 0131010   |
