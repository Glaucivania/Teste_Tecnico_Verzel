# Cenários

Escritos em Gherkin, em português (`# language: pt`). **20 cenários, um arquivo por cenário**, ordenados de CT-01 a CT-20 e agrupados em subpastas numeradas por tema. O nome do arquivo segue o padrão `CT-NN_descricao.feature`, o mesmo usado nas evidências em [`../evidencias/`](../evidencias/).

```
cenarios/
├── 01-cupom/                 CT-01 a CT-05
├── 02-frete/                 CT-06 e CT-07
├── 03-carrinho-checkout/     CT-08 a CT-12
├── 04-api/                   CT-13 a CT-19
└── 05-consistencia/          CT-20
```

## Índice

| CT | Cenário | Tipo | Prio | Suíte | Resultado | Automatizado |
|---|---|---|---|---|---|---|
| 01 | [BEMVINDO10 dá 10% sobre o subtotal e não incide sobre o frete (CA01, CA09)](01-cupom/CT-01_bemvindo10-desconto-e-frete.feature) | UI | P1 | smoke | ✅ | sim |
| 02 | [O código do cupom ignora maiúsculas e espaços nas pontas (CA02)](01-cupom/CT-02_cupom-caixa-e-espacos.feature) | UI | P1 | regressão | ✅ |  |
| 03 | [Cupom inexistente ou expirado não dá desconto e informa o motivo (CA03, CA04)](01-cupom/CT-03_cupom-invalido-ou-expirado.feature) | UI | P1 | smoke | ✅ |  |
| 04 | [Só um cupom por vez, sem acúmulo, e casos de borda do campo (CA05, AMB-05 a AMB-08)](01-cupom/CT-04_cupom-unico-e-casos-de-borda.feature) | UI | P2 | regressão | ✅ |  |
| 05 | [Remover item ou cupom recalcula desconto, frete e total com 2 casas decimais (AMB-04, CA11)](01-cupom/CT-05_remocao-recalcula-valores.feature) | UI | P1 | regressão | ✅ |  |
| 06 | [Limite do frete grátis na interface (CA06, CA07)](02-frete/CT-06_frete-limite-ui.feature) | UI | P1 | smoke | ❌ BUG-001 | sim |
| 07 | [O frete grátis usa o subtotal antes do cupom (CA08)](02-frete/CT-07_cupom-e-frete-subtotal.feature) | UI | P1 | regressão | ❌ BUG-001 |  |
| 08 | [Limite de 5 unidades por produto na interface (CA10, AMB-02)](03-carrinho-checkout/CT-08_limite-5-unidades-ui.feature) | UI | P1 | regressão | ✅ |  |
| 09 | [O carrinho e o cupom persistem ao recarregar a aba (AMB-01)](03-carrinho-checkout/CT-09_persistencia-carrinho.feature) | UI | P2 | regressão | ✅ |  |
| 10 | [Finalizar a compra com dados válidos confirma o pedido](03-carrinho-checkout/CT-10_checkout-valido.feature) | UI | P1 | smoke | ✅ |  |
| 11 | [Validação de nome, e-mail e CEP no checkout](03-carrinho-checkout/CT-11_validacao-checkout.feature) | UI | P2 | regressão | ✅ |  |
| 12 | [Responsividade e acessibilidade básicas](03-carrinho-checkout/CT-12_responsividade-acessibilidade.feature) | UI | P3 | regressão | ✅ |  |
| 13 | [Listar produtos e consultar um produto](04-api/CT-13_api-produtos.feature) | API | P2 | smoke | ✅ |  |
| 14 | [Calcular um carrinho com BEMVINDO10 (exemplo da documentação)](04-api/CT-14_api-calcular-bemvindo10.feature) | API | P1 | smoke | ✅ | sim |
| 15 | [Calcular com cupom inválido ou expirado não gera erro (CA03, CA04)](04-api/CT-15_api-calcular-cupom-invalido.feature) | API | P1 | regressão | ✅ |  |
| 16 | [Limite do frete grátis na API (CA06, CA07)](04-api/CT-16_api-limite-frete.feature) | API | P1 | regressão | ❌ BUG-001 |  |
| 17 | [Erros de validação e de protocolo da API (CA10)](04-api/CT-17_api-erros-validacao.feature) | API | P2 | regressão | ❌ BUG-002 |  |
| 18 | [Confirmar um pedido e rejeitar cupom inválido ou expirado](04-api/CT-18_api-pedidos.feature) | API | P1 | smoke | ✅ |  |
| 19 | [Pedido com dados do cliente inválidos](04-api/CT-19_api-pedidos-cliente-invalido.feature) | API | P2 | regressão | ✅ |  |
| 20 | [Os valores da interface são iguais aos da API para o mesmo carrinho](05-consistencia/CT-20_consistencia-ui-api.feature) | UI e API | P1 | regressão | ✅ |  |

Ordem das subpastas e dos cenários: CT-01 a CT-05 (cupom), CT-06 e CT-07 (frete), CT-08 a CT-12 (carrinho, checkout e qualidade da interface), CT-13 a CT-19 (API) e CT-20 (consistência entre UI e API).

Resultado da execução de 06/10/2026: 16 passaram e 4 falharam (CT-06, CT-07, CT-16 e CT-17), por 2 bugs. Detalhes em [`../execucao/resultados.md`](../execucao/resultados.md).

## Passo a passo da execução

Os passos de cada cenário descrevem **como executar o teste à mão**, com as entradas exatas: montar o carrinho pela vitrine (cliques em "Adicionar ao carrinho" e nos botões `+` e `-`), digitar o cupom, preencher o checkout ou enviar a requisição no Postman ou no Insomnia. Logo abaixo do título de cada cenário, um parágrafo de descrição registra o resultado da execução de 06/10/2026 (Passou ou Falhou, com o ID do bug), a evidência e, quando houver, o teste automatizado.

Nos cenários que falharam (CT-06, CT-07, CT-16 e CT-17), os passos afirmam o resultado esperado pela documentação, então executá-los reproduz a falha.

## Tags

- **Tipo:** `@ui`, `@api`
- **Suíte:** `@smoke`, `@regressao`
- **Prioridade:** `@P1`, `@P2`, `@P3`
- **Automação:** `@automatizado` marca os 3 cenários implementados no Playwright (CT-01, CT-06 e CT-14)
- **Rastreio:** `@CT-NN` identifica o cenário
- **Agrupamento:** `@cupom`, `@frete`, `@carrinho`, `@api` e `@consistencia` identificam o tema de cada cenário

Os IDs `CT-NN` são os mesmos usados em `execucao/resultados.md`, na matriz de rastreabilidade e nos nomes das evidências.

## Observação sobre valores limite

O catálogo não permite subtotais de R$ 199,99 e R$ 200,01. Os valores usados são 199,90, 200,00 e 229,90. Detalhes em [`../docs/estrategia-de-testes.md`](../docs/estrategia-de-testes.md).
