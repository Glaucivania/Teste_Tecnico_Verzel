@consistency
Feature: Consistency between UI and API
  The UI only displays what the API calculates. The values must be the same.

  @CT-24 @regression @ui @api @P1
  Scenario Outline: CT-24 UI values match the API values for the same cart
    Given the cart has <items> and the coupon "<coupon>"
    When I compare the displayed summary with the response of "/api/carrinho/calcular"
    Then subtotal, discount, shipping and total are equal in both layers
    And free shipping and the missing amount are consistent with each other

    Examples:
      | items                   | coupon     |
      | 1 Camiseta Essencial    | BEMVINDO10 |
      | 4 Garrafa Térmica 750ml |            |
      | 4 Garrafa Térmica 750ml | BEMVINDO10 |
      | 1 Jaqueta Corta-Vento   | BEMVINDO10 |
