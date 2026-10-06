# Evidências da execução

Execução de 06/10/2026 na v2.3.0 da Verzel Store. Resultado detalhado por cenário em [`../execucao/resultados.md`](../execucao/resultados.md).

## Resumo

| Métrica | Valor |
|---|---|
| Cenários planejados | 24 |
| Passou | 20 |
| Falhou | 4 (CT-08, CT-09, CT-20 e CT-21) |
| Bloqueado | 0 |
| Bugs | 2 (1 alta: BUG-001, 1 média: BUG-002) |
| Sessões exploratórias | 2 (SE-01 e SE-02) |

## Como as evidências foram coletadas

- **API:** requisições `curl` com data, método, corpo, resposta e status HTTP gravados em `.txt`.
- **Interface:** texto do DOM da região principal (resumo de valores, mensagens) gravado em `.txt`, mais prints (`.jpg`) dos casos visuais.
- **Nomes:** `CT-NN_descricao.ext`, conforme o ID do cenário. `SE-NN` para sessões exploratórias.

## Anexos

Todos em [`../evidencias/`](../evidencias/).

| Cenário | Evidência | Resultado |
|---|---|---|
| CT-01 | [CT-01_aplicar-bemvindo10-ui.txt](../evidencias/CT-01_aplicar-bemvindo10-ui.txt) | Passou |
| CT-02 | [CT-02_caixa-e-espacos-ui.txt](../evidencias/CT-02_caixa-e-espacos-ui.txt) | Passou |
| CT-03, CT-04 e CT-05 | [CT-03-04-05_cupom-invalido-expirado-vazio-ui.txt](../evidencias/CT-03-04-05_cupom-invalido-expirado-vazio-ui.txt) | Passou |
| CT-06 | [CT-06_um-cupom-por-vez-ui.txt](../evidencias/CT-06_um-cupom-por-vez-ui.txt) | Passou |
| CT-07 | [CT-07_remover-item-e-cupom-ui.txt](../evidencias/CT-07_remover-item-e-cupom-ui.txt) | Passou |
| CT-08 | [CT-08_frete-limite-200-ui.jpg](../evidencias/CT-08_frete-limite-200-ui.jpg) | **Falhou** (BUG-001) |
| CT-08 a CT-11 e CT-24 | [CT-08_09_10_11_24_ui-vs-api.txt](../evidencias/CT-08_09_10_11_24_ui-vs-api.txt) | CT-08 e CT-09 falharam, CT-10, CT-11 e CT-24 passaram |
| CT-12 | [CT-12_limite-5-unidades-ui.txt](../evidencias/CT-12_limite-5-unidades-ui.txt) | Passou |
| CT-13 | [CT-13_persistencia-ui.txt](../evidencias/CT-13_persistencia-ui.txt) | Passou |
| CT-14 e CT-15 | [CT-14_15_checkout-ui.txt](../evidencias/CT-14_15_checkout-ui.txt) | Passou |
| CT-16 | [CT-16_responsividade-e-acessibilidade.txt](../evidencias/CT-16_responsividade-e-acessibilidade.txt) e [print](../evidencias/CT-16_carrinho-mobile-375.jpg) | Passou |
| CT-17 | `CT-17_*.txt` | Passou |
| CT-18 | [CT-18_calcular-bemvindo10.txt](../evidencias/CT-18_calcular-bemvindo10.txt) | Passou |
| CT-19 | `CT-19_*.txt` | Passou |
| CT-20 | `CT-20_*.txt` | **Falhou** (BUG-001) |
| CT-21 | `CT-21_*.txt` | **Falhou** (BUG-002) |
| CT-22 | `CT-22_*.txt` | Passou |
| CT-23 | `CT-23_*.txt` | Passou |
| AUTO | [AUTO_execucao-playwright.txt](../evidencias/AUTO_execucao-playwright.txt) | 5 testes passando, 1 deles `test.fail` do BUG-001 |
| SE-01 | [SE-01_exploratorio-cupom-e-frete.txt](../evidencias/SE-01_exploratorio-cupom-e-frete.txt) | BUG-001 |
| SE-02 | [SE-02_api-exploratorio.txt](../evidencias/SE-02_api-exploratorio.txt) | BUG-002 |

## Limitações das evidências

- Os testes de UI foram feitos no navegador embutido do app (Chromium), com preparo de estado via `sessionStorage` para montar carrinhos rapidamente. O cupom, os botões e o checkout foram acionados pela interface.
- Poucos prints, e sem gravação de vídeo.
