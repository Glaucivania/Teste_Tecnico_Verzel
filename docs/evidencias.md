# Evidências da execução

Execução de 06/10/2026 na v2.3.0 da Verzel Store. Resultado detalhado por cenário em [`../execucao/resultados.md`](../execucao/resultados.md).

## Resumo

| Métrica | Valor |
|---|---|
| Cenários planejados | 20 |
| Passou | 16 |
| Falhou | 4 (CT-06, CT-07, CT-16 e CT-17) |
| Bloqueado | 0 |
| Bugs | 2 (1 alta: BUG-001, 1 média: BUG-002) |
| Sessões exploratórias | 2 (SE-01 e SE-02) |

## Como as evidências foram coletadas

Cada cenário tem **uma única imagem** de evidência, sem texto adicional, nomeada `CT-NN_descricao.png`.

- **Interface:** capturas de tela do Google Chrome 153. Nos cenários com vários casos, a imagem reúne as capturas lado a lado, sem legenda.
- **API:** capturas de tela do Postman, com a requisição (método e URL), a resposta com o status HTTP e a aba Test Results (a contagem de testes que passaram). No CT-20, a captura do Postman fica ao lado do resumo da loja.

## Anexos

Todos em [`../evidencias/`](../evidencias/).

| Cenário | Evidência | Resultado |
|---|---|---|
| CT-01 | [CT-01_aplicar-bemvindo10-ui.png](../evidencias/CT-01_aplicar-bemvindo10-ui.png) | Passou |
| CT-02 | [CT-02_caixa-e-espacos-ui.png](../evidencias/CT-02_caixa-e-espacos-ui.png) | Passou |
| CT-03 | [CT-03_cupom-invalido-expirado-ui.png](../evidencias/CT-03_cupom-invalido-expirado-ui.png) | Passou |
| CT-04 | [CT-04_cupom-unico-e-casos-de-borda-ui.png](../evidencias/CT-04_cupom-unico-e-casos-de-borda-ui.png) | Passou |
| CT-05 | [CT-05_remover-item-e-cupom-ui.png](../evidencias/CT-05_remover-item-e-cupom-ui.png) | Passou |
| CT-06 | [CT-06_frete-limite-ui-vs-api.png](../evidencias/CT-06_frete-limite-ui-vs-api.png) | **Falhou** (BUG-001) |
| CT-07 | [CT-07_cupom-e-frete-ui-vs-api.png](../evidencias/CT-07_cupom-e-frete-ui-vs-api.png) | **Falhou** (BUG-001) |
| CT-08 | [CT-08_limite-5-unidades-ui.png](../evidencias/CT-08_limite-5-unidades-ui.png) | Passou |
| CT-09 | [CT-09_persistencia-ui.png](../evidencias/CT-09_persistencia-ui.png) | Passou |
| CT-10 | [CT-10_checkout-ui.png](../evidencias/CT-10_checkout-ui.png) | Passou |
| CT-11 | [CT-11_validacao-checkout-ui.png](../evidencias/CT-11_validacao-checkout-ui.png) | Passou |
| CT-12 | [CT-12_responsividade-e-acessibilidade.png](../evidencias/CT-12_responsividade-e-acessibilidade.png) | Passou |
| CT-13 | [CT-13_produtos-lista.jpeg](../evidencias/CT-13_produtos-lista.jpeg) | Passou |
| CT-14 | [CT-14_calcular-bemvindo10.jpeg](../evidencias/CT-14_calcular-bemvindo10.jpeg) | Passou |
| CT-15 | [CT-15_calcular-cupom-expirado.jpeg](../evidencias/CT-15_calcular-cupom-expirado.jpeg) | Passou |
| CT-16 | [CT-16_calcular-200-00.jpeg](../evidencias/CT-16_calcular-200-00.jpeg) | **Falhou** (BUG-001) |
| CT-17 | [CT-17_quantidade-6.jpeg](../evidencias/CT-17_quantidade-6.jpeg) | **Falhou** (BUG-002) |
| CT-18 | [CT-18_pedido-bemvindo10.jpeg](../evidencias/CT-18_pedido-bemvindo10.jpeg) | Passou |
| CT-19 | [CT-19_nome-sem-sobrenome.jpeg](../evidencias/CT-19_nome-sem-sobrenome.jpeg) | Passou |
| CT-20 | [CT-20_consistencia-ui-vs-api.png](../evidencias/CT-20_consistencia-ui-vs-api.png) | Passou |

## Limitações das evidências

- Os testes de UI foram feitos no Google Chrome 153. Uma rodada inicial no Chromium embutido do app teve os mesmos resultados.
- Os números de pedido (VZ-...) mudam a cada execução, pois são gerados pela loja.
- Poucos prints, e sem gravação de vídeo.
