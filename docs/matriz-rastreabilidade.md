# Matriz de rastreabilidade

Liga cada regra da documentação aos cenários previstos. Os cenários estão em [`../cenarios/`](../cenarios/). CA01 a CA11 têm pelo menos um cenário cada.

| Regra | Descrição | Cenários |
|---|---|---|
| CA01 | BEMVINDO10 dá 10% sobre o subtotal | CT-01, CT-18, CT-24 |
| CA02 | Cupom sem diferenciar caixa e com espaços ignorados | CT-02 |
| CA03 | Cupom inexistente: "Cupom inválido." | CT-03, CT-05, CT-19, CT-22 |
| CA04 | Cupom expirado: "Cupom expirado." | CT-04, CT-19, CT-22 |
| CA05 | Um cupom por vez | CT-06 |
| CA06 | Frete grátis a partir de R$ 200,00, inclusive | CT-08, CT-20, CT-24 |
| CA07 | Abaixo de R$ 200,00: R$ 19,90 e faltante exibido | CT-08, CT-20 |
| CA08 | Frete considera o subtotal antes do desconto | CT-09 |
| CA09 | Desconto não incide sobre o frete | CT-10 |
| CA10 | Máximo de 5 unidades por produto (UI e API) | CT-12, CT-21 |
| CA11 | Arredondamento em 2 casas | CT-11 |
| Fórmula | `total = subtotal - desconto + frete` | CT-01, CT-10, CT-11, CT-24 |
| Cliente | Nome com sobrenome, e-mail e CEP válidos | CT-14, CT-15, CT-23 |
| Carrinho | Persistência na aba, remoção de itens e cupom | CT-07, CT-13 |
| API | Produtos, calcular, pedidos e códigos de erro | CT-17 a CT-23 |
| Não funcional | Responsividade e acessibilidade básicas | CT-16 |

## Cobertura por critério

| Critério | Cenários | Automatizado |
|---|---|---|
| CA01 | 3 | CT-01, CT-18 |
| CA02 | 1 | |
| CA03 | 4 | CT-03 |
| CA04 | 3 | CT-04 |
| CA05 | 1 | |
| CA06 e CA07 | 3 | CT-08 |
| CA08 | 1 | CT-09 |
| CA09 | 1 | |
| CA10 | 2 | |
| CA11 | 1 | |
