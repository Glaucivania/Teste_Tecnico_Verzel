@shipping
Feature: Free shipping and totals calculation
  As a Verzel Store customer
  I want free shipping on purchases of R$ 200,00 or more
  So that I pay less on my purchases

  Business rules: shipping is free from R$ 200,00 inclusive; below that it costs R$ 19,90.
  Shipping considers the subtotal before the discount. The discount does not apply to shipping.
  Note: with the fixed catalog, subtotals of 199,99 and 200,01 cannot be built.
  The closest values to the limit are 199,90 (below), 200,00 (exact) and 229,90 (above).

  Background:
    Given the cart is empty

  @CT-08 @smoke @regression @ui @P1 @automated
  Scenario Outline: CT-08 Free shipping threshold in the UI (CA06, CA07)
    Given the cart has <items>
    Then the subtotal is "<subtotal>"
    And the shipping is "<shipping>"
    And the total is "<total>"
    And the free shipping message is "<message>"

    Examples:
      | items                                        | subtotal  | shipping | total     | message                             |
      | 1 Boné Aba Curva and 3 Garrafa Térmica 750ml | R$ 199,90 | R$ 19,90 | R$ 219,80 | Faltam R$ 0,10 para o frete grátis. |
      | 4 Garrafa Térmica 750ml                      | R$ 200,00 | Grátis   | R$ 200,00 | none                                |
      | 1 Jaqueta Corta-Vento                        | R$ 229,90 | Grátis   | R$ 229,90 | none                                |

  @CT-09 @regression @ui @P1 @automated
  Scenario: CT-09 Free shipping uses the subtotal before the coupon (CA08)
    Given the cart has 4 Garrafa Térmica 750ml
    When I apply the coupon "BEMVINDO10"
    Then the subtotal is "R$ 200,00"
    And the discount is "- R$ 20,00"
    And the shipping is "Grátis"
    And the total is "R$ 180,00"

  @CT-10 @regression @ui @P1
  Scenario: CT-10 The coupon discount does not apply to shipping (CA09)
    Given the cart has 1 Mochila Urbana 20L
    When I apply the coupon "BEMVINDO10"
    Then the subtotal is "R$ 100,00"
    And the discount is "- R$ 10,00"
    And the shipping is "R$ 19,90"
    And the total is "R$ 109,90"

  @CT-11 @regression @ui @api @P2
  Scenario Outline: CT-11 Values have 2 decimal places, with no floating point error (CA11)
    Given the cart has <items>
    And I applied the coupon "BEMVINDO10"
    Then the subtotal is "<subtotal>"
    And the discount is "<discount>"
    And the total is "<total>"
    And the API returns the same values with at most 2 decimal places

    Examples:
      | items                  | subtotal  | discount   | total     |
      | 3 Camiseta Essencial   | R$ 179,70 | - R$ 17,97 | R$ 181,63 |
      | 3 Boné Aba Curva       | R$ 149,70 | - R$ 14,97 | R$ 154,63 |
      | 3 Kit 3 Pares de Meias | R$ 89,70  | - R$ 8,97  | R$ 100,63 |
