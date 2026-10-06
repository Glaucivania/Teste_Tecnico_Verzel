# Cenários

Escritos em Gherkin, em português (`# language: pt`). 24 cenários, 5 arquivos.

| Arquivo | Cenários | Foco |
|---|---|---|
| [`cupom.feature`](cupom.feature) | CT-01 a CT-07 | Cupom válido, caixa e espaços, inválido, expirado, vazio, um por vez, remoção |
| [`frete.feature`](frete.feature) | CT-08 a CT-11 | Limite do frete grátis, cupom com frete, desconto sem incidir no frete, casas decimais |
| [`carrinho-checkout.feature`](carrinho-checkout.feature) | CT-12 a CT-16 | Quantidade máxima, persistência, checkout, validação de cliente, responsividade e acessibilidade |
| [`api.feature`](api.feature) | CT-17 a CT-23 | Produtos, cálculo, erros e pedidos |
| [`consistencia.feature`](consistencia.feature) | CT-24 | UI x API |

## Tags

- **Tipo:** `@ui`, `@api`
- **Suíte:** `@smoke`, `@regressao`
- **Prioridade:** `@P1`, `@P2`, `@P3`
- **Automação:** `@automatizado` marca os 3 cenários implementados no Playwright (CT-01, CT-08 e CT-18)
- **Rastreio:** `@CT-NN` identifica o cenário

Os IDs `CT-NN` são os mesmos usados em `execucao/resultados.md`, na matriz de rastreabilidade e nos nomes das evidências.

## Observação sobre valores limite

O catálogo não permite subtotais de R$ 199,99 e R$ 200,01. Os valores usados são 199,90, 200,00 e 229,90. Detalhes em [`../docs/estrategia-de-testes.md`](../docs/estrategia-de-testes.md).
