import { Page } from '@playwright/test';

export class ProductsPage {
  constructor(private readonly page: Page) {}

  async open() {
    await this.page.goto('/');
  }

  async addToCart(productName: string) {
    await this.page
      .getByRole('heading', { name: productName })
      .locator('xpath=..')
      .getByRole('button', { name: 'Adicionar ao carrinho' })
      .click();
  }

  async openCart() {
    await this.page.getByRole('link', { name: /^Carrinho/ }).click();
  }
}
