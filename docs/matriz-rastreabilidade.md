# Matriz de rastreabilidade

Liga cada regra da documentação aos cenários. Os cenários estão em [`../cenarios/`](../cenarios/). CA01 a CA11 têm pelo menos um cenário cada.

| Regra | Descrição | Cenários |
|---|---|---|
| CA01 | BEMVINDO10 dá 10% sobre o subtotal | CT-01, CT-14, CT-20 |
| CA02 | Cupom sem diferenciar caixa e com espaços ignorados | CT-02 |
| CA03 | Cupom inexistente: "Cupom inválido." | CT-03, CT-15, CT-18 |
| CA04 | Cupom expirado: "Cupom expirado." | CT-03, CT-15, CT-18 |
| CA05 | Um cupom por vez | CT-04 |
| CA06 | Frete grátis a partir de R$ 200,00, inclusive | CT-06, CT-16, CT-20 |
| CA07 | Abaixo de R$ 200,00: R$ 19,90 e faltante exibido | CT-06, CT-16 |
| CA08 | Frete considera o subtotal antes do desconto | CT-07 |
| CA09 | Desconto não incide sobre o frete | CT-01 |
| CA10 | Máximo de 5 unidades por produto (UI e API) | CT-08, CT-17 |
| CA11 | Arredondamento em 2 casas | CT-05 |
| Fórmula | `total = subtotal - desconto + frete` | CT-01, CT-05, CT-20 |
| Cliente | Nome com sobrenome, e-mail e CEP válidos | CT-10, CT-11, CT-19 |
| Carrinho | Persistência na aba, remoção de itens e cupom | CT-05, CT-09 |
| API | Produtos, calcular, pedidos e códigos de erro | CT-13 a CT-19 |
| Não funcional | Responsividade e acessibilidade básicas | CT-12 |

## Cobertura por critério

| Critério | Cenários | Automatizado |
|---|---|---|
| CA01 | 3 | CT-01, CT-14 |
| CA02 | 1 | CT-01 (caixa baixa e espaços) |
| CA03 | 3 | |
| CA04 | 3 | |
| CA05 | 1 | |
| CA06 e CA07 | 3 | CT-06 |
| CA08 | 1 | |
| CA09 | 1 | CT-01 |
| CA10 | 2 | |
| CA11 | 1 | |
