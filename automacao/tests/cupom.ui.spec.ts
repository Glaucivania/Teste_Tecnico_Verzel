import { expect, test } from '@playwright/test';
import { CartPage } from '../pages/CartPage';
import { ProductsPage } from '../pages/ProductsPage';
import { brl, discount } from '../support/money';

test.describe('Cupom de desconto', () => {
  // CT-01 | CA01 | @smoke @regressao @ui @P1
  test('CT-01 aplicar BEMVINDO10 dá 10% sobre o subtotal', async ({ page }) => {
    const products = new ProductsPage(page);
    const cart = new CartPage(page);

    await products.open();
    await products.addToCart('Camiseta Essencial');
    await products.openCart();

    // usa caixa baixa e espaços de propósito: o cupom não diferencia caixa (CA02)
    await cart.applyCoupon('  bemvindo10  ');

    await expect(cart.couponMessage('Cupom BEMVINDO10 aplicado.')).toBeVisible();
    await expect(cart.value('subtotal')).toHaveText(brl(59.9));
    await expect(cart.value('desconto')).toHaveText(discount(5.99));
    await expect(cart.value('frete')).toHaveText(brl(19.9));
    await expect(cart.value('total')).toHaveText(brl(73.81));
  });
});
