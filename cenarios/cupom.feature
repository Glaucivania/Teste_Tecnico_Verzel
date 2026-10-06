@coupon
Feature: Discount coupon in the cart
  As a Verzel Store customer
  I want to apply a discount coupon in the cart
  So that I pay less on my purchases

  Background:
    Given the cart is empty

  @CT-01 @smoke @regression @ui @P1 @automated
  Scenario: CT-01 Applying BEMVINDO10 gives 10% off the subtotal (CA01)
    Given I added "Camiseta Essencial" to the cart
    When I apply the coupon "BEMVINDO10"
    Then I see the message "Cupom BEMVINDO10 aplicado."
    And the subtotal is "R$ 59,90"
    And the discount is "- R$ 5,99"
    And the shipping is "R$ 19,90"
    And the total is "R$ 73,81"

  @CT-02 @regression @ui @P1
  Scenario Outline: CT-02 The coupon code ignores letter case and surrounding spaces (CA02)
    Given I added "Camiseta Essencial" to the cart
    When I apply the coupon "<code>"
    Then the coupon "BEMVINDO10" is applied
    And the discount is "- R$ 5,99"

    Examples:
      | code           |
      | bemvindo10     |
      | BemVindo10     |
      |   BEMVINDO10   |
      |   bemvindo10   |

  @CT-03 @smoke @regression @ui @P1 @automated
  Scenario: CT-03 A nonexistent coupon shows "Cupom inválido." and gives no discount (CA03)
    Given I added "Camiseta Essencial" to the cart
    When I apply the coupon "INEXISTENTE"
    Then I see the message "Cupom inválido."
    And the discount is "R$ 0,00"
    And the total is "R$ 79,80"

  @CT-04 @smoke @regression @ui @P1 @automated
  Scenario: CT-04 An expired coupon shows "Cupom expirado." and gives no discount (CA04)
    Given I added "Camiseta Essencial" to the cart
    When I apply the coupon "VERAO2026"
    Then I see the message "Cupom expirado."
    And the discount is "R$ 0,00"
    And the total is "R$ 79,80"

  @CT-05 @regression @ui @P3
  Scenario Outline: CT-05 An empty coupon, or a coupon on an empty cart, gives no discount (AMB-05, AMB-08)
    Given the cart has <items>
    When I apply the coupon "<code>"
    Then no coupon is applied
    And the discount is "R$ 0,00"
    And I see clear feedback

    Examples:
      | items                | code            |
      | "Camiseta Essencial" |                 |
      | "Camiseta Essencial" | only spaces     |
      | no items             | BEMVINDO10      |

  @CT-06 @regression @ui @P2
  Scenario: CT-06 Only one coupon at a time, with no stacking on reapply (CA05, AMB-06, AMB-07)
    Given I added "Camiseta Essencial" to the cart
    And I applied the coupon "BEMVINDO10"
    When I apply the coupon "BEMVINDO10" again
    Then the discount is still "- R$ 5,99"
    When I try to apply the coupon "VERAO2026" while "BEMVINDO10" is still active
    Then the coupon "BEMVINDO10" is still applied
    And there is only one active coupon

  @CT-07 @regression @ui @P1
  Scenario: CT-07 Removing an item or the coupon recalculates discount and shipping (AMB-04)
    Given I added "Calça Jeans Slim" to the cart
    And I added "Boné Aba Curva" to the cart with quantity 2
    And I applied the coupon "BEMVINDO10"
    Then the subtotal is "R$ 239,70"
    And the discount is "- R$ 23,97"
    And the shipping is "Grátis"
    And the total is "R$ 215,73"
    When I remove "Calça Jeans Slim" from the cart
    Then the subtotal is "R$ 99,80"
    And the discount is "- R$ 9,98"
    And the shipping is "R$ 19,90"
    And the total is "R$ 109,72"
    When I remove the coupon
    Then the discount is "R$ 0,00"
    And the total is "R$ 119,70"
