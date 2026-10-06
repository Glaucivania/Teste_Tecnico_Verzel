# Verzel Store: teste técnico QA Júnior

Validação de QA da entrega **VZS-142 (v2.3.0): cupom de desconto e frete grátis** da Verzel Store, uma loja fictícia usada como ambiente de teste.

> **Status do projeto:** Fases 0, 1, 2 e 4 concluídas (v0.5.0). Cenários, execução, bugs e automação serão preenchidos fase a fase. Veja o [CHANGELOG](CHANGELOG.md) para o andamento e a seção [Entregas](#onde-encontrar-cada-entrega) para o estado de cada item.

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

## Entregas

Cada item do desafio e o lugar onde ele está:

| # | Entrega | Onde encontrar | Estado |
|---|---|---|---|
| 1 | Cenários de teste (Gherkin) | [`cenarios/`](cenarios/) e [`docs/matriz-rastreabilidade.md`](docs/matriz-rastreabilidade.md) | Concluído |
| 2 | Execução (manual e exploratória) | [`execucao/resultados.md`](execucao/resultados.md) | Concluído (20 passaram, 4 falharam) |
| 3 | Report de bugs | [`bugs/`](bugs/) | Concluído (2 bugs) |
| 4 | Documento de evidências | [`docs/evidencias.md`](docs/evidencias.md) e [`evidencias/`](evidencias/) | Concluído |
| 5 | Automação com Playwright | [`automacao/`](automacao/) | Concluído (3 cenários, 5 testes) |
| 6 | README | Este arquivo | Em andamento |

Documentos de apoio:

- [`docs/ambiguidades.md`](docs/ambiguidades.md): ambiguidades da documentação e a interpretação adotada para cada uma.
- [`docs/estrategia-de-testes.md`](docs/estrategia-de-testes.md): técnicas, escopo, priorização e critérios de pronto.
- [`docs/enunciado-teste-tecnico-qa-junior.pdf`](docs/enunciado-teste-tecnico-qa-junior.pdf): enunciado original do desafio.

## Estrutura do repositório

```
.
├── README.md
├── CHANGELOG.md                versionamento (Keep a Changelog + SemVer)
├── docs/
│   ├── enunciado-teste-tecnico-qa-junior.pdf
│   ├── ambiguidades.md
│   ├── estrategia-de-testes.md
│   ├── matriz-rastreabilidade.md
│   └── evidencias.md
├── cenarios/                   arquivos .feature (Gherkin, em português)
├── execucao/
│   └── resultados.md           resultado de cada cenário e sessões exploratórias
├── bugs/                       um arquivo por bug (BUG-001.md ...)
├── evidencias/                 prints e gravações nomeados por ID (CT-08_...)
└── automacao/                  Playwright + TypeScript
    ├── playwright.config.ts
    ├── package.json
    ├── pages/                  Page Objects
    ├── support/                helpers (formato de valores)
    └── tests/                  testes de UI e API
```

## Estratégia resumida

- **24 cenários** priorizados (P1 a P3), cobrindo cupom, frete grátis, quantidade máxima, checkout, API e consistência entre UI e API.
- **Técnicas:** partição de equivalência, análise de valor limite (subtotal 199,90, 200,00 e 229,90, já que o catálogo não permite 199,99 e 200,01; quantidade 0, 1, 5 e 6), tabela de decisão e transição de estados.
- **Gherkin em português**, com Esquema do Cenário para casos de limite, e tags `@smoke`, `@regressao`, `@api`, `@ui`, `@automatizado` e `@P1` a `@P3`.
- **Execução:** manual guiada pelos cenários, 2 sessões exploratórias de 30 minutos e testes de API com `curl`, com poucas requisições.
- **Automação:** 3 cenários de maior valor para o negócio, escolhidos por cobrirem o coração da entrega: **CT-01** (aplicar cupom válido, UI), **CT-08** (limite do frete grátis, UI, 3 valores) e **CT-18** (cálculo da API com cupom e frete). Bugs conhecidos ficam como `test.fail` com o ID do bug.

## Como rodar a automação

**Pré-requisitos**

- Node.js 18 ou superior e npm
- Acesso à internet (os testes rodam contra a loja pública)

**Instalação e execução** (a partir da raiz do repositório)

```bash
cd automacao
npm install
npx playwright install chromium
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
| CT-01 aplicar BEMVINDO10 dá 10% sobre o subtotal | CT-01 | UI | Passa |
| CT-08 frete abaixo do limite (R$ 199,90) | CT-08 | UI | Passa |
| CT-08 frete exatamente no limite (R$ 200,00) | CT-08 | UI | **Marcado `test.fail` (BUG-001)** |
| CT-08 frete acima do limite (R$ 229,90) | CT-08 | UI | Passa |
| CT-18 calcular carrinho com BEMVINDO10 | CT-18 | API | Passa |

A suíte fica **verde** (`5 passed`). O teste do limite de R$ 200,00 falha de propósito por causa do [BUG-001](bugs/BUG-001.md). Quando o bug for corrigido, o Playwright vai acusar esse teste como "esperava falhar, mas passou", sinal para remover o `test.fail`.

**Como a automação é organizada** (em [`automacao/`](automacao/))

- `pages/`: Page Objects enxutos (`ProductsPage`, `CartPage`).
- `tests/`: `*.ui.spec.ts` (projeto `ui`, Chromium) e `*.api.spec.ts` (projeto `api`, `request` do Playwright).
- `support/money.ts`: formatação de valores em reais para as asserções.
- Seletores: `getByRole`, `getByTestId` (a loja expõe `data-valor` nos valores do resumo, configurado como `testIdAttribute`) e `getByText`. Sem `sleep` fixo, só asserções com espera automática.
- Independência: cada teste roda em um contexto novo, com carrinho próprio. Nos testes de frete, o carrinho é preparado no `sessionStorage` antes de a página carregar, para montar o subtotal rápido. O CT-01 usa o fluxo completo (vitrine, adicionar, carrinho, cupom).
- Ambiente compartilhado: 1 worker, sem repetições e sem loops de requisições.
- Relatório HTML em `automacao/playwright-report/`, com trace e screenshot em caso de falha.

**Cuidados com o ambiente compartilhado:** a suíte roda com 1 worker, sem loops de requisições, e cada teste usa um contexto de navegador novo, então tem carrinho próprio e não interfere em outras pessoas.

## Premissas e interpretações

- O que a seção "Sobre este ambiente" descreve como simplificação de propósito **não é reportado como bug**: carrinho só na aba, pedidos fictícios sem consulta, sem e-mail, cobrança ou estoque, e API sem estado.
- Testes de carga, estresse e segurança estão fora do escopo, assim como login, cadastro, pagamento online e consulta de pedidos.
- Onde a documentação é ambígua, a interpretação adotada está registrada em [`docs/ambiguidades.md`](docs/ambiguidades.md).

## Limitações

- O trabalho é uma amostra priorizada, não uma cobertura exaustiva. Navegadores e dispositivos são testados de forma pontual.
- Acessibilidade e responsividade têm checagem básica, sem ferramentas automatizadas completas.
- Os testes dependem da disponibilidade da loja pública e de comportamento estável dela.
- As 2 sessões exploratórias foram mais curtas que os 30 minutos planejados e não foram cronometradas. A UI foi testada no Chromium embutido do app, com evidências em texto (DOM) e poucos prints, sem gravação de vídeo.
- Não foram feitos testes de carga, estresse ou segurança, por determinação do desafio.

## Fluxo de trabalho (Git)

- `main`: somente versões estáveis e publicadas, com tags `vX.Y.Z`.
- `develop`: integração do trabalho.
- `feature/*`: uma branch por fase, com merge na `develop`.
- Commits no padrão Conventional Commits (`docs:`, `test:`, `feat:`, `chore:`).
- Versionamento no [CHANGELOG](CHANGELOG.md).

