@api
Feature: Products, cart calculation and orders API
  As a Verzel Store API consumer
  I want to calculate carts and confirm orders
  So that I get correct values and clear errors

  Background:
    Given the API is at "/api"
    And requests use "Content-Type: application/json"

  @CT-17 @smoke @regression @api @P2
  Scenario: CT-17 List products and fetch a single product
    When I send GET to "/api/produtos"
    Then the status is 200 and the list has 8 products
    When I send GET to "/api/produtos/P001"
    Then the status is 200 and the product is "Camiseta Essencial" with price 59.9
    When I send GET to "/api/produtos/P999"
    Then the status is 404 with the code "PRODUTO_NAO_ENCONTRADO"

  @CT-18 @smoke @regression @api @P1 @automated
  Scenario: CT-18 Calculate a cart with BEMVINDO10 (documentation example)
    When I send POST to "/api/carrinho/calcular" with 1 "P002", 2 "P004" and the coupon "BEMVINDO10"
    Then the status is 200
    And the subtotal is 239.7
    And the discount is 23.97
    And the shipping is 0 and "freteGratis" is true
    And the total is 215.73
    And "cupom.aplicado" is true

  @CT-19 @regression @api @P1
  Scenario Outline: CT-19 Calculating with an invalid or expired coupon does not raise an error (CA03, CA04)
    When I send POST to "/api/carrinho/calcular" with 2 "P005" and the coupon "<coupon>"
    Then the status is 200
    And the discount is 0
    And "cupom.aplicado" is false
    And "cupom.mensagem" is "<message>"

    Examples:
      | coupon      | message         |
      | INEXISTENTE | Cupom inválido. |
      | VERAO2026   | Cupom expirado. |

  @CT-20 @regression @api @P1
  Scenario Outline: CT-20 Free shipping threshold in the API (CA06, CA07)
    When I send POST to "/api/carrinho/calcular" with <items>
    Then the shipping is <shipping> and "freteGratis" is <free>
    And "valorFaltanteFreteGratis" is <missing>
    And the total is <total>

    Examples:
      | items               | shipping | free  | missing | total |
      | 1 "P004" and 3 "P008" | 19.9   | false | 0.1     | 219.8 |
      | 4 "P008"           | 0        | true  | 0       | 200   |
      | 1 "P007"           | 0        | true  | 0       | 229.9 |

  @CT-21 @regression @api @P2
  Scenario Outline: CT-21 API validation and protocol errors (CA10)
    When I send <request>
    Then the status is <status> and the error code is "<code>"

    Examples:
      | request                                | status | code                       |
      | POST calcular with 6 units of "P001"   | 422    | QUANTIDADE_MAXIMA_EXCEDIDA |
      | POST calcular with quantity 0          | 422    | QUANTIDADE_INVALIDA        |
      | POST calcular with quantity 1.5        | 422    | QUANTIDADE_INVALIDA        |
      | POST calcular with an empty item list  | 422    | ITENS_OBRIGATORIOS         |
      | POST calcular with "P001" repeated     | 422    | ITEM_DUPLICADO             |
      | POST calcular with product "P999"      | 422    | PRODUTO_NAO_ENCONTRADO     |
      | POST calcular with a non-JSON body     | 400    | JSON_INVALIDO              |
      | GET on "/api/carrinho/calcular"        | 405    | METODO_NAO_PERMITIDO       |
      | GET on "/api/rota-inexistente"         | 404    | ROTA_NAO_ENCONTRADA        |

  @CT-22 @smoke @regression @api @P1
  Scenario: CT-22 Confirm an order and reject an invalid or expired coupon
    When I send POST to "/api/pedidos" with a valid customer, 1 "P005" and the coupon "BEMVINDO10"
    Then the status is 201 and the order number follows the format "VZ-000000"
    And the subtotal is 100, the discount is 10, the shipping is 19.9 and the total is 109.9
    And the ZIP code comes back without a hyphen
    When I send POST to "/api/pedidos" with the coupon "INEXISTENTE"
    Then the status is 422 and the code is "CUPOM_INVALIDO"
    When I send POST to "/api/pedidos" with the coupon "VERAO2026"
    Then the status is 422 and the code is "CUPOM_EXPIRADO"

  @CT-23 @regression @api @P2
  Scenario Outline: CT-23 Order with invalid customer data
    When I send POST to "/api/pedidos" with name "<name>", email "<email>" and ZIP code "<zip>"
    Then the status is 422 and the code is "DADOS_INVALIDOS"
    And "campos" points to the invalid field

    Examples:
      | name        | email             | zip      |
      | Maria       | maria@exemplo.com | 01310100 |
      | Maria Silva | maria@exemplo     | 01310100 |
      | Maria Silva | maria@exemplo.com | 0131010  |
