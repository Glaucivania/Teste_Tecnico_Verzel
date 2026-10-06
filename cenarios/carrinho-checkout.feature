@cart
Feature: Cart, checkout and interface quality
  As a Verzel Store customer
  I want to build my cart and check out
  So that I receive my products

  Background:
    Given the cart is empty

  @CT-12 @regression @ui @P1
  Scenario Outline: CT-12 Limit of 5 units per product in the UI (CA10, AMB-02)
    Given I added "Camiseta Essencial" to the cart
    When I set the quantity to <target>
    Then the displayed quantity is <displayed>
    And <behavior>

    Examples:
      | target | displayed | behavior                                          |
      | 1      | 1         | the decrease button does not go below 1           |
      | 5      | 5         | the increase button is disabled                   |
      | 6      | 5         | I see "Limite de 5 unidades por produto."         |

  @CT-13 @regression @ui @P2
  Scenario: CT-13 The cart and the coupon persist after reloading the tab (AMB-01)
    Given I added "Camiseta Essencial" to the cart
    And I applied the coupon "BEMVINDO10"
    When I reload the page
    Then the cart still has "Camiseta Essencial"
    And the coupon "BEMVINDO10" is still applied

  @CT-14 @smoke @regression @ui @P1
  Scenario: CT-14 Checking out with valid data confirms the order
    Given I added "Mochila Urbana 20L" to the cart
    When I check out with name "Maria Silva", email "maria@exemplo.com" and ZIP code "01310-100"
    Then I see the confirmation with an order number in the format "VZ-000000"
    And the confirmed total is "R$ 119,90"

  @CT-15 @regression @ui @P2
  Scenario Outline: CT-15 Name, email and ZIP code validation at checkout
    Given I added "Mochila Urbana 20L" to the cart
    When I check out with name "<name>", email "<email>" and ZIP code "<zip>"
    Then the result is "<result>"

    Examples:
      | name        | email             | zip       | result                      |
      | Maria       | maria@exemplo.com | 01310100  | rejected: name without surname |
      | Maria Silva | maria@exemplo     | 01310100  | rejected: invalid email     |
      | Maria Silva | maria@exemplo.com | 0131010   | rejected: ZIP with 7 digits |
      | Maria Silva | maria@exemplo.com | 013101000 | rejected: ZIP with 9 digits |
      | Maria Silva | maria@exemplo.com | 01310-100 | accepted: ZIP with hyphen   |
      | Maria Silva | maria@exemplo.com | 01310100  | accepted: ZIP without hyphen |

  @CT-16 @regression @ui @P3
  Scenario: CT-16 Basic responsiveness and accessibility
    When I open the cart at 375 px width
    Then there is no horizontal scroll and the buttons remain accessible
    And every field and button has an accessible name
    And I can apply a coupon using only the keyboard
    And the focus stays visible while navigating
