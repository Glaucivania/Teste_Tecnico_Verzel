# Changelog

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/) e versionamento [SemVer](https://semver.org/lang/pt-BR/).

Plano de versões: cada fase concluída gera uma versão e `1.0.0` marca o envio.

## [0.7.0] - 2026-10-06

### Adicionado
- Workspace do Postman versionado em `postman/` e `.postman/`.
- Coleção do Postman dos testes de API (CT-13 a CT-19), com 26 requisições e testes. Executada com o Newman: 57 asserções, 6 falhas, todas do BUG-001 e do BUG-002.
- Pasta CT-20 na coleção do Postman, com 4 requisições que comparam a API com o resumo da tela (12 asserções, nenhuma falha).
- Cenários Gherkin organizados em um arquivo por cenário (CT-01 a CT-20), em subpastas numeradas por tema, com o passo a passo manual de cada teste e índice em `cenarios/README.md`.
- Evidências em imagem, uma por cenário, sem texto sobreposto.

### Alterado
- Fusão de cenários redundantes, de 24 para 20. Resultado da execução: 16 passaram e 4 falharam (CT-06, CT-07, CT-16 e CT-17), por 2 bugs.
- Automação Playwright passa a rodar a UI no Google Chrome instalado (canal `chrome`), com `PW_BROWSER=chromium` como alternativa. Configuração reescrita (o `testIdAttribute` estava duplicado no projeto `ui`).
- Ferramenta dos cenários de API registrada como Postman.

### Removido
- Enunciado em PDF (`docs/enunciado-teste-tecnico-qa-junior.pdf`).

## [0.6.0] - 2026-10-06

### Adicionado
- Fase 5: seção "Resultado da validação" e "Onde encontrar cada entrega" no README, com recomendação e principais interpretações de ambiguidades.
- Evidência da automação em `evidencias/AUTO_execucao-playwright.png` e entrada correspondente em `docs/evidencias.md`.

### Alterado
- README com resumo no topo, limitações revisadas e premissas detalhadas.

## [0.5.0] - 2026-10-06

### Adicionado
- Fase 4: automação Playwright com TypeScript em `automacao/` para 3 cenários: CT-01 (cupom válido, UI), CT-08 (limite do frete, UI, 3 valores) e CT-18 (cálculo da API).
- Page Objects `ProductsPage` e `CartPage`, helper de valores em reais e relatório HTML com trace e screenshot em falha.
- O caso de R$ 200,00 do CT-08 está marcado com `test.fail` e referência ao BUG-001. Suíte verde: 5 testes passando.

### Alterado
- `@automatizado` agora marca apenas CT-01, CT-08 e CT-18 (antes eram 6 candidatos).

## [0.4.0] - 2026-10-06

### Adicionado
- Fase 2: execução dos 24 cenários (20 passaram, 4 falharam), com evidências em `evidencias/` e resultados em `execucao/resultados.md`.
- 2 sessões exploratórias (SE-01 e SE-02).
- Report de bugs: BUG-001 (frete cobrado com subtotal de R$ 200,00, alta) e BUG-002 (API aceita mais de 5 unidades, média), com resumo executivo em `bugs/README.md`.
- `docs/evidencias.md` com o resumo da execução e a lista de anexos.

### Alterado
- Ambiguidades AMB-03 a AMB-11 verificadas na loja.

## [0.3.2] - 2026-10-06

### Alterado
- Cenários Gherkin voltaram para o português (`# language: pt`, `Funcionalidade`, `Cenário`, `Esquema do Cenário`, `Dado`, `Quando`, `Então`).
- Tags voltaram a `@regressao` e `@automatizado`, e as de contexto a `@cupom`, `@frete`, `@carrinho`, `@consistencia`.

## [0.3.1] - 2026-10-06

### Alterado
- Cenários Gherkin reescritos em inglês (`Feature`, `Scenario Outline`, `Given`, `When`, `Then`). Textos da loja continuam em português entre aspas.
- Tags renomeadas: `@regressao` para `@regression` e `@automatizado` para `@automated`. Tags de contexto em inglês (`@coupon`, `@shipping`, `@cart`, `@consistency`).
- Removido o cabeçalho `# language: pt`.

## [0.3.0] - 2026-10-06

### Adicionado
- Fase 1: 24 cenários em Gherkin (português) em `cenarios/`, em 5 arquivos `.feature`, com tags de tipo, suíte, prioridade, automação e ID (`@CT-NN`).
- Matriz de rastreabilidade completa e tabela de cobertura por critério.
- Nota sobre valores limite em `docs/estrategia-de-testes.md`.

### Alterado
- Valores limite do frete passaram de 199,99 e 200,01 para 199,90, 200,00 e 229,90, pois o catálogo não permite os originais.

## [0.2.0] - 2026-10-06

### Adicionado
- Fase 0: resumo das regras de negócio, 11 ambiguidades com interpretação e seção de exploração inicial em `docs/ambiguidades.md`.
- Mapa de seletores e comportamento da loja para a automação (sem `data-testid`, uso de `getByRole`).
- Dois achados preliminares (F-01 frete no limite de R$ 200,00 e F-02 quantidade 6 aceita na API de cálculo), a confirmar na Fase 2.

### Alterado
- AMB-01, AMB-02 e AMB-10 verificadas na loja.

## [0.1.0] - 2026-10-06

### Adicionado
- Estrutura inicial do repositório: `docs/`, `cenarios/`, `execucao/`, `bugs/`, `evidencias/` e `automacao/`.
- `README.md` com visão geral, estrutura, estratégia, instruções de automação, premissas e limitações.
- Esqueleto da automação Playwright com TypeScript (`package.json`, `playwright.config.ts`, `tsconfig.json`).
- Documentos de apoio com cabeçalho e plano: `docs/ambiguidades.md`, `docs/estrategia-de-testes.md`, `docs/matriz-rastreabilidade.md`, `docs/evidencias.md` e `execucao/resultados.md`.
- Enunciado do desafio em `docs/enunciado-teste-tecnico-qa-junior.pdf`.

[0.7.0]: ../../releases/tag/v0.7.0
[0.6.0]: ../../releases/tag/v0.6.0
[0.5.0]: ../../releases/tag/v0.5.0
[0.4.0]: ../../releases/tag/v0.4.0
[0.3.2]: ../../releases/tag/v0.3.2
[0.3.1]: ../../releases/tag/v0.3.1
[0.3.0]: ../../releases/tag/v0.3.0
[0.2.0]: ../../releases/tag/v0.2.0
[0.1.0]: ../../releases/tag/v0.1.0
