# Verzel Store: teste técnico QA Júnior

Validação de QA da entrega **VZS-142 (v2.3.0): cupom de desconto e frete grátis** da Verzel Store, uma loja fictícia usada como ambiente de teste.

>  20 cenários em Gherkin, 16 passaram e 4 falharam, por causa de **2 bugs** ([BUG-001](bugs/BUG-001.md), alta: frete cobrado com subtotal de R$ 200,00, e [BUG-002](bugs/BUG-002.md), média: API aceita mais de 5 unidades). A automação Playwright cobre 3 cenários e roda verde. Histórico em [CHANGELOG](CHANGELOG.md).

## Visão geral

A entrega adiciona à loja a aplicação de cupons no carrinho e a regra de frete grátis. Os cálculos são feitos pela API e a interface só exibe o resultado. Por isso o trabalho valida as duas camadas e a consistência entre elas.

**Ambiente testado**

| Item | Link |
|---|---|
| Loja | https://verzel-store.qa-test-verzel-store.workers.dev/ |
| Documentação da entrega | https://verzel-store.qa-test-verzel-store.workers.dev/documentacao |
| API | https://verzel-store.qa-test-verzel-store.workers.dev/api |

**Regras de negócio em resumo** (fonte: documentação, critérios CA01 a CA11)

- O cupom `BEMVINDO10` dá 10% sobre o subtotal. `VERAO2026` está expirado.
- O código do cupom ignora maiúsculas e espaços nas pontas. Só um cupom por vez.
- Frete de R$ 19,90 abaixo de R$ 200,00 de subtotal e grátis a partir de R$ 200,00, inclusive.
- O frete grátis considera o subtotal antes do desconto, e o desconto não incide sobre o frete.
- Máximo de 5 unidades por produto, na interface e na API.
- Valores arredondados em 2 casas. `total = subtotal - desconto + frete`.

## Resultado da validação

| Métrica | Valor |
|---|---|
| Cenários planejados e executados | 20 |
| Passou | 16 |
| Falhou | 4 (CT-06, CT-07, CT-16 e CT-17) |
| Bloqueado | 0 |
| Bugs | 2 (1 alta, 1 média) |
| Testes automatizados | 5 testes em 3 cenários, suíte verde |

Recomendação: corrigir o BUG-001 antes de liberar a entrega, pois afeta exatamente o valor mais divulgado da promoção ("a partir de R$ 200,00"). Detalhes em [`docs/evidencias.md`](docs/evidencias.md).

## Onde encontrar cada entrega

Cada item do desafio e o lugar onde ele está:

| # | Entrega | Onde encontrar | Estado |
|---|---|---|---|
| 1 | Cenários de teste (Gherkin) | [`cenarios/`](cenarios/) e [`docs/matriz-rastreabilidade.md`](docs/matriz-rastreabilidade.md) | Concluído |
| 2 | Execução (manual e exploratória) | [`execucao/resultados.md`](execucao/resultados.md) | Concluído (16 passaram, 4 falharam) |
| 3 | Report de bugs | [`bugs/`](bugs/) | Concluído (2 bugs) |
| 4 | Documento de evidências | [`docs/evidencias.md`](docs/evidencias.md) e [`evidencias/`](evidencias/) | Concluído |
| 5 | Automação com Playwright | [`automacao/`](automacao/) | Concluído (3 cenários, 5 testes) |
| 6 | README | Este arquivo | Concluído |

Documentos de apoio:

- [`postman/`](postman/): workspace do Postman versionado no repositório. A coleção dos testes de API (CT-13 a CT-20, 30 requisições com testes) está em [`postman/collections/Verzel Store API/`](<postman/collections/Verzel Store API/>), no formato v3 (YAML) do Postman. Para usá-la, abra a pasta do projeto no Postman (workspace local com Git), vá em Collections e use o Run. Os testes afirmam o resultado esperado pela documentação, então 6 asserções falham de propósito por causa do BUG-001 e do BUG-002.
- [`docs/ambiguidades.md`](docs/ambiguidades.md): ambiguidades da documentação e a interpretação adotada para cada uma.
- [`docs/estrategia-de-testes.md`](docs/estrategia-de-testes.md): técnicas, escopo, priorização e critérios de pronto.

## Estrutura do repositório

```
.
├── README.md
├── CHANGELOG.md                versionamento (Keep a Changelog + SemVer)
├── docs/
│   ├── ambiguidades.md
│   ├── estrategia-de-testes.md
│   ├── matriz-rastreabilidade.md
│   └── evidencias.md
├── cenarios/                   um .feature por cenário (CT-01 a CT-20), em subpastas por tema
├── execucao/
│   └── resultados.md           resultado de cada cenário e sessões exploratórias
├── bugs/                       um arquivo por bug (BUG-001.md ...), resumo e modelo
├── postman/                    coleção e ambiente do Postman (testes de API), versionados
├── evidencias/                 uma imagem de evidência por cenário (capturas da UI e requisição com resposta da API), nomeadas por ID (CT-06_...)
└── automacao/                  Playwright + TypeScript
    ├── playwright.config.ts
    ├── package.json
    ├── pages/                  Page Objects
    ├── support/                helpers (formato de valores)
    └── tests/                  testes de UI e API
```

## Estratégia resumida

- **20 cenários** priorizados (P1 a P3), cobrindo cupom, frete grátis, quantidade máxima, checkout, API e consistência entre UI e API.
- **Técnicas:** partição de equivalência, análise de valor limite (subtotal 199,90, 200,00 e 229,90, já que o catálogo não permite 199,99 e 200,01; quantidade 0, 1, 5 e 6), tabela de decisão e transição de estados.
- **Gherkin em português**, com Esquema do Cenário para casos de limite, e tags `@smoke`, `@regressao`, `@api`, `@ui`, `@automatizado` e `@P1` a `@P3`.
- **Execução:** manual guiada pelos cenários, 2 sessões exploratórias com charter e testes de API no Postman, com poucas requisições.
- **Automação:** 3 cenários de maior valor para o negócio, escolhidos por cobrirem o coração da entrega: **CT-01** (aplicar cupom válido, UI), **CT-06** (limite do frete grátis, UI, 3 valores) e **CT-14** (cálculo da API com cupom e frete). Bugs conhecidos ficam como `test.fail` com o ID do bug.

## Como rodar a automação

**Pré-requisitos**

- Node.js 18 ou superior e npm
- Google Chrome instalado (a suíte de UI usa o Chrome pelo canal `chrome` do Playwright)
- Acesso à internet (os testes rodam contra a loja pública)

**Instalação e execução** (a partir da raiz do repositório)

```bash
cd automacao
npm install
npm test
```

**Abrir o relatório HTML**

```bash
npm run report
```

Outros comandos úteis:

```bash
npm run test:ui      # apenas testes de interface
npm run test:api     # apenas testes de API
npm run test:headed  # com o navegador visível
```

**O que a suíte executa** (5 testes, cerca de 10 segundos)

| Teste | Cenário | Camada | Resultado esperado |
|---|---|---|---|
| CT-01 BEMVINDO10 dá 10% sobre o subtotal e não incide no frete | CT-01 | UI | Passa |
| CT-06 frete abaixo do limite (R$ 199,90) | CT-06 | UI | Passa |
| CT-06 frete exatamente no limite (R$ 200,00) | CT-06 | UI | **Marcado `test.fail` (BUG-001)** |
| CT-06 frete acima do limite (R$ 229,90) | CT-06 | UI | Passa |
| CT-14 calcular carrinho com BEMVINDO10 | CT-14 | API | Passa |

A suíte fica **verde** (`5 passed`). O teste do limite de R$ 200,00 falha de propósito por causa do [BUG-001](bugs/BUG-001.md). Quando o bug for corrigido, o Playwright vai acusar esse teste como "esperava falhar, mas passou", sinal para remover o `test.fail`.

**Como a automação é organizada** (em [`automacao/`](automacao/))

- `pages/`: Page Objects enxutos (`ProductsPage`, `CartPage`).
- `tests/`: `*.ui.spec.ts` (projeto `ui`, Google Chrome) e `*.api.spec.ts` (projeto `api`, `request` do Playwright).
- `support/money.ts`: formatação de valores em reais para as asserções.
- Seletores: `getByRole`, `getByTestId` (a loja expõe `data-valor` nos valores do resumo, configurado como `testIdAttribute`) e `getByText`. Sem `sleep` fixo, só asserções com espera automática.
- Independência: cada teste roda em um contexto novo, com carrinho próprio. Nos testes de frete, o carrinho é preparado no `sessionStorage` antes de a página carregar, para montar o subtotal rápido. O CT-01 usa o fluxo completo (vitrine, adicionar, carrinho, cupom).
- Ambiente compartilhado: 1 worker, sem repetições e sem loops de requisições.
- Relatório HTML em `automacao/playwright-report/`, com trace e screenshot em caso de falha.


## Premissas e interpretações

- O que a seção "Sobre este ambiente" descreve como simplificação de propósito **não é reportado como bug**: carrinho só na aba, pedidos fictícios sem consulta, sem e-mail, cobrança ou estoque, e API sem estado.
- Testes de carga, estresse e segurança estão fora do escopo, assim como login, cadastro, pagamento online e consulta de pedidos.
- Onde a documentação é ambígua, a interpretação adotada está registrada em [`docs/ambiguidades.md`](docs/ambiguidades.md). As principais:
  - O carrinho e o cupom devem persistir ao recarregar a mesma aba (confirmado).
  - Ao tentar passar de 5 unidades, qualquer feedback claro vale, desde que a quantidade nunca passe de 5 (a UI desabilita o botão e avisa).
  - O arredondamento é comercial, em 2 casas. Com 10% de desconto ele nunca é exercido, pois todo subtotal é múltiplo de R$ 0,10.
  - Remover item ou cupom recalcula desconto e frete sobre o novo subtotal.
  - O "faltante para frete grátis" usa o subtotal antes do desconto.
- Os valores limite de R$ 199,99 e R$ 200,01 não podem ser montados com o catálogo fixo. Foram usados R$ 199,90, R$ 200,00 e R$ 229,90.

## Limitações

- O trabalho é uma amostra priorizada, não uma cobertura exaustiva. Navegadores e dispositivos são testados de forma pontual.
- Acessibilidade e responsividade têm checagem básica, sem ferramentas automatizadas completas.
- A automação cobre só 3 cenários, por decisão de priorizar o que mais importa. Os demais 17 foram executados manualmente.
- Os testes dependem da disponibilidade da loja pública e de comportamento estável dela.
- Os testes de UI manuais foram feitos no Google Chrome 153.
- As 2 sessões exploratórias foram mais curtas que os 30 minutos planejados e não foram cronometradas, e foram feitas no Chromium embutido do app. A UI dos cenários foi testada no Chrome, com evidências em texto (DOM).
- Não foram feitos testes de carga, estresse ou segurança, por determinação do desafio.

## Fluxo de trabalho (Git)

- `main`: somente versões estáveis e publicadas, com tags `vX.Y.Z`.
- `develop`: integração do trabalho.
- `feature/*`: uma branch por fase, com merge na `develop`.
- Commits no padrão Conventional Commits (`docs:`, `test:`, `feat:`, `chore:`).
- Versionamento no [CHANGELOG](CHANGELOG.md).

