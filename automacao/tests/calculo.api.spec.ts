import { expect, test } from '@playwright/test';

test.describe('API de cálculo do carrinho', () => {
  // CT-18 | CA01 e CA06 | @smoke @regressao @api @P1 (exemplo da documentação)
  test('CT-18 calcular carrinho com BEMVINDO10', async ({ request }) => {
    const response = await request.post('/api/carrinho/calcular', {
      data: {
        itens: [
          { produtoId: 'P002', quantidade: 1 },
          { produtoId: 'P004', quantidade: 2 },
        ],
        cupom: 'BEMVINDO10',
      },
    });

    expect(response.status()).toBe(200);
    const body = await response.json();

    expect(body).toMatchObject({
      subtotal: 239.7,
      desconto: 23.97,
      frete: 0,
      freteGratis: true,
      valorFaltanteFreteGratis: 0,
      total: 215.73,
      cupom: { codigo: 'BEMVINDO10', aplicado: true },
    });
    expect(body.itens).toHaveLength(2);
  });
});
