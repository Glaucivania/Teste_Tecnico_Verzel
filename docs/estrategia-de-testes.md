# Estratégia de testes

## Objetivo

Validar a entrega VZS-142 (cupom de desconto e frete grátis) na UI e na API, e a consistência entre as duas camadas.

## Escopo

**Dentro:** cupom, frete grátis, cálculo de totais, quantidade máxima, carrinho, checkout, API (produtos, calcular, pedidos) e mensagens de erro.

**Fora:** testes de carga, estresse e segurança, login, cadastro, pagamento online e consulta de pedidos.

## Técnicas

| Técnica | Aplicação |
|---|---|
| Partição de equivalência | Cupom válido, inválido, expirado e vazio. |
| Valor limite | Subtotal 199,90, 200,00 e 229,90 (veja a nota abaixo). Quantidade 0, 1, 5 e 6. |
| Tabela de decisão | Cupom x faixa de frete (total e frete esperados). |
| Transição de estados | Carrinho vazio, com itens, com cupom e após remoção. |
| Exploratório | 2 sessões de 30 minutos com charter. |

**Nota sobre os valores limite:** os preços do catálogo terminam em 0,90 ou 0,00, então os subtotais de R$ 199,99 e R$ 200,01 não podem ser montados na loja nem na API. Os valores mais próximos do limite são **R$ 199,90** (1 Boné + 3 Garrafas, abaixo), **R$ 200,00** (4 Garrafas, exato) e **R$ 229,90** (1 Jaqueta, acima). O arredondamento também não aparece com 10%, pois todo subtotal é múltiplo de R$ 0,10 e o desconto fecha em centavos exatos. Por isso o CT-11 verifica casas decimais e ponto flutuante (por exemplo 3 x 59,90 = 179,70).

## Priorização

- **P1:** núcleo do cupom e do frete, quantidade máxima, pedido e consistência UI x API.
- **P2:** variações de entrada, persistência, validação de cliente e erros de API.
- **P3:** responsividade e acessibilidade básicas, casos de borda improváveis.

## Convenções

- Gherkin em português. Tags `@smoke`, `@regressao`, `@api`, `@ui`, `@automatizado` e `@P1` a `@P3`.
- IDs de cenário `CT-NN`, de bug `BUG-NNN`, de ambiguidade `AMB-NN`.
- Evidências em `evidencias/CT-NN_descricao.ext`.
- Resultados: Passou, Falhou ou Bloqueado.

## Automação

Playwright com TypeScript, limitado a **3 cenários** de maior valor: CT-01 (cupom válido, UI), CT-08 (limite do frete, UI) e CT-18 (cálculo da API). Os demais ficam como execução manual. Detalhes no README.

## Critérios de pronto

Todo critério de aceite (CA01 a CA11) tem pelo menos um cenário, todo cenário tem resultado e evidência, e todo bug está documentado com referência à documentação.

## Riscos

- Ambiente compartilhado, que exige execução leve.
- Confundir simplificação de propósito com bug (ver [ambiguidades](ambiguidades.md)).
