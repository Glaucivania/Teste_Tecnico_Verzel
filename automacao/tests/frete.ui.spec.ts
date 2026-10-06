import { expect, test } from '@playwright/test';
import { CartItem, CartPage } from '../pages/CartPage';
import { brl } from '../support/money';

type Case = {
  name: string;
  items: CartItem[];
  subtotal: number;
  freeShipping: boolean;
  total: number;
  hint?: string;
  bug?: string;
};

// O catálogo só permite subtotais terminados em 0,90 ou 0,00 (veja docs/estrategia-de-testes.md).
const cases: Case[] = [
  {
    name: 'abaixo do limite (R$ 199,90)',
    items: [
      { produtoId: 'P004', quantidade: 1 },
      { produtoId: 'P008', quantidade: 3 },
    ],
    subtotal: 199.9,
    freeShipping: false,
    total: 219.8,
    hint: 'Faltam R$ 0,10 para o frete grátis.',
  },
  {
    name: 'exatamente no limite (R$ 200,00)',
    items: [{ produtoId: 'P008', quantidade: 4 }],
    subtotal: 200,
    freeShipping: true,
    total: 200,
    bug: 'BUG-001: frete de R$ 19,90 é cobrado com subtotal de R$ 200,00 (CA06 pede frete grátis, inclusive)',
  },
  {
    name: 'acima do limite (R$ 229,90)',
    items: [{ produtoId: 'P007', quantidade: 1 }],
    subtotal: 229.9,
    freeShipping: true,
    total: 229.9,
  },
];

test.describe('Frete grátis a partir de R$ 200,00', () => {
  for (const c of cases) {
    // CT-06 | CA06 e CA07 | @smoke @regressao @ui @P1
    test(`CT-06 frete ${c.name}`, async ({ page }) => {
      if (c.bug) test.fail(true, c.bug);

      const cart = new CartPage(page);
      await cart.seed(c.items);
      await cart.open();

      await expect(cart.value('subtotal')).toHaveText(brl(c.subtotal));
      if (c.freeShipping) {
        await expect(cart.value('frete')).toHaveText('Grátis');
        await expect(cart.freeShippingHint()).toHaveCount(0);
      } else {
        await expect(cart.value('frete')).toHaveText(brl(19.9));
        await expect(cart.freeShippingHint()).toHaveText(c.hint!);
      }
      await expect(cart.value('total')).toHaveText(brl(c.total));
    });
  }
});
