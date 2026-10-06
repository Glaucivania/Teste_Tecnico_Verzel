# Changelog

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/) e versionamento [SemVer](https://semver.org/lang/pt-BR/).

Plano de versões: cada fase concluída gera uma versão e `1.0.0` marca o envio.

## [Não lançado]

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

[Não lançado]: ../../compare/v0.2.0...develop
[0.2.0]: ../../releases/tag/v0.2.0
[0.1.0]: ../../releases/tag/v0.1.0
