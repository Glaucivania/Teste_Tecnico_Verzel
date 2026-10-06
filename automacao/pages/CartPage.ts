import { Locator, Page, expect } from '@playwright/test';

export type CartItem = { produtoId: string; quantidade: number };

export class CartPage {
  readonly couponField: Locator;
  readonly applyCouponButton: Locator;

  constructor(private readonly page: Page) {
    this.couponField = page.getByRole('textbox', { name: 'Cupom de desconto' });
    this.applyCouponButton = page.getByRole('button', { name: 'Aplicar cupom' });
  }

  /**
   * Prepara o carrinho da aba antes do carregamento da página.
   * O carrinho vive no sessionStorage, então cada teste (contexto novo) tem o seu.
   */
  async seed(items: CartItem[]) {
    await this.page.addInitScript((value) => {
      if (!sessionStorage.getItem('qa-seeded')) {
        sessionStorage.setItem('verzel-store:itens', JSON.stringify(value));
        sessionStorage.setItem('verzel-store:cupom', 'null');
        sessionStorage.setItem('qa-seeded', '1');
      }
    }, items);
  }

  async open() {
    await this.page.goto('/carrinho');
    await expect(this.page.getByRole('heading', { name: 'Carrinho', level: 1 })).toBeVisible();
  }

  async applyCoupon(code: string) {
    await this.couponField.fill(code);
    await this.applyCouponButton.click();
  }

  couponMessage(text: string | RegExp) {
    return this.page.getByText(text);
  }

  /** Valores do resumo. O app expõe data-valor="subtotal|desconto|frete|total" (testIdAttribute no config). */
  value(name: 'subtotal' | 'desconto' | 'frete' | 'total') {
    return this.page.getByTestId(name);
  }

  freeShippingHint() {
    return this.page.locator('.aviso-frete');
  }
}
