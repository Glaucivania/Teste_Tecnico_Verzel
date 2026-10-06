# Resultados da execução

**Ambiente:** https://verzel-store.qa-test-verzel-store.workers.dev (v2.3.0)
**Data:** 2026-10-06 | **Executor:** QA
**Método:** execução manual guiada pelos cenários em [`../cenarios/`](../cenarios/). A interface foi exercitada no navegador embutido do app Claude (Chromium), e a API por `curl`, com poucas requisições.

## Resumo

| Resultado | Quantidade |
|---|---|
| Passou | 20 |
| Falhou | 4 (CT-08, CT-09, CT-20 e CT-21) |
| Bloqueado | 0 |
| Total | 24 |

Bugs encontrados: [BUG-001](../bugs/BUG-001.md) (frete cobrado no subtotal de R$ 200,00) e [BUG-002](../bugs/BUG-002.md) (API aceita mais de 5 unidades por produto).

## Execução por cenário

| ID | Título | Resultado | Data | Navegador ou cliente | Evidência | Bug |
|---|---|---|---|---|---|---|
| CT-01 | Aplicar BEMVINDO10 (10% sobre o subtotal) | Passou | 2026-10-06 | Chromium embutido (desktop) | [CT-01_aplicar-bemvindo10-ui.txt](../evidencias/CT-01_aplicar-bemvindo10-ui.txt) |  |
| CT-02 | Cupom sem diferenciar caixa e com espaços | Passou | 2026-10-06 | Chromium embutido (desktop) | [CT-02_caixa-e-espacos-ui.txt](../evidencias/CT-02_caixa-e-espacos-ui.txt) |  |
| CT-03 | Cupom inexistente: "Cupom inválido." | Passou | 2026-10-06 | Chromium embutido (desktop) | [CT-03-04-05_cupom-invalido-expirado-vazio-ui.txt](../evidencias/CT-03-04-05_cupom-invalido-expirado-vazio-ui.txt) |  |
| CT-04 | Cupom expirado: "Cupom expirado." | Passou | 2026-10-06 | Chromium embutido (desktop) | [CT-03-04-05_cupom-invalido-expirado-vazio-ui.txt](../evidencias/CT-03-04-05_cupom-invalido-expirado-vazio-ui.txt) |  |
| CT-05 | Cupom vazio ou carrinho vazio com cupom | Passou | 2026-10-06 | Chromium embutido (desktop) | [CT-03-04-05_cupom-invalido-expirado-vazio-ui.txt](../evidencias/CT-03-04-05_cupom-invalido-expirado-vazio-ui.txt) |  |
| CT-06 | Um cupom por vez e sem acúmulo ao reaplicar | Passou | 2026-10-06 | Chromium embutido (desktop) | [CT-06_um-cupom-por-vez-ui.txt](../evidencias/CT-06_um-cupom-por-vez-ui.txt) |  |
| CT-07 | Remover item ou cupom recalcula desconto e frete | Passou | 2026-10-06 | Chromium embutido (desktop) | [CT-07_remover-item-e-cupom-ui.txt](../evidencias/CT-07_remover-item-e-cupom-ui.txt) |  |
| CT-08 | Limite do frete grátis (199,90, 200,00 e 229,90) | Falhou | 2026-10-06 | Chromium embutido (desktop) | [CT-08_frete-limite-200-ui.jpg](../evidencias/CT-08_frete-limite-200-ui.jpg) | BUG-001 |
| CT-09 | Cupom não altera a regra do frete | Falhou | 2026-10-06 | Chromium embutido (desktop) | [CT-08_09_10_11_24_ui-vs-api.txt](../evidencias/CT-08_09_10_11_24_ui-vs-api.txt) | BUG-001 |
| CT-10 | Desconto não incide sobre o frete | Passou | 2026-10-06 | Chromium embutido (desktop) | [CT-08_09_10_11_24_ui-vs-api.txt](../evidencias/CT-08_09_10_11_24_ui-vs-api.txt) |  |
| CT-11 | Arredondamento em 2 casas | Passou | 2026-10-06 | Chromium embutido e curl | [CT-08_09_10_11_24_ui-vs-api.txt](../evidencias/CT-08_09_10_11_24_ui-vs-api.txt) |  |
| CT-12 | Quantidade 0, 1, 5 e 6 na UI | Passou | 2026-10-06 | Chromium embutido (desktop) | [CT-12_limite-5-unidades-ui.txt](../evidencias/CT-12_limite-5-unidades-ui.txt) |  |
| CT-13 | Carrinho persiste ao recarregar a aba | Passou | 2026-10-06 | Chromium embutido (desktop) | [CT-13_persistencia-ui.txt](../evidencias/CT-13_persistencia-ui.txt) |  |
| CT-14 | Checkout válido | Passou | 2026-10-06 | Chromium embutido (desktop) | [CT-14_15_checkout-ui.txt](../evidencias/CT-14_15_checkout-ui.txt) |  |
| CT-15 | Validação de nome, e-mail e CEP | Passou | 2026-10-06 | Chromium embutido (desktop) | [CT-14_15_checkout-ui.txt](../evidencias/CT-14_15_checkout-ui.txt) |  |
| CT-16 | Responsividade e acessibilidade básica | Passou | 2026-10-06 | Chromium embutido (mobile 375 px e desktop) | [CT-16_carrinho-mobile-375.jpg](../evidencias/CT-16_carrinho-mobile-375.jpg) |  |
| CT-17 | API: produtos | Passou | 2026-10-06 | curl (HTTP) | [CT-17_produtos-lista.txt](../evidencias/CT-17_produtos-lista.txt) |  |
| CT-18 | API: calcular com BEMVINDO10 | Passou | 2026-10-06 | curl (HTTP) | [CT-18_calcular-bemvindo10.txt](../evidencias/CT-18_calcular-bemvindo10.txt) |  |
| CT-19 | API: calcular com cupom inválido ou expirado | Passou | 2026-10-06 | curl (HTTP) | [CT-19_calcular-cupom-expirado.txt](../evidencias/CT-19_calcular-cupom-expirado.txt) |  |
| CT-20 | API: limite do frete | Falhou | 2026-10-06 | curl (HTTP) | [CT-20_calcular-200-00.txt](../evidencias/CT-20_calcular-200-00.txt) | BUG-001 |
| CT-21 | API: erros 4xx | Falhou | 2026-10-06 | curl (HTTP) | [CT-21_quantidade-6.txt](../evidencias/CT-21_quantidade-6.txt) | BUG-002 |
| CT-22 | API: pedidos | Passou | 2026-10-06 | curl (HTTP) | [CT-22_pedido-bemvindo10.txt](../evidencias/CT-22_pedido-bemvindo10.txt) |  |
| CT-23 | API: pedidos com cliente inválido | Passou | 2026-10-06 | curl (HTTP) | [CT-23_nome-sem-sobrenome.txt](../evidencias/CT-23_nome-sem-sobrenome.txt) |  |
| CT-24 | Consistência UI x API | Passou | 2026-10-06 | Chromium embutido e curl | [CT-08_09_10_11_24_ui-vs-api.txt](../evidencias/CT-08_09_10_11_24_ui-vs-api.txt) |  |

## Observações

- **CT-06:** a UI esconde o campo de cupom depois de aplicar um, então só se troca de cupom removendo o atual (CA05). A reaplicação do mesmo cupom não é possível pela interface. Interpretação AMB-06 e AMB-07 atendida.
- **CT-08:** o subtotal de R$ 199,90 e de R$ 229,90 passam, e o de R$ 200,00 falha. Os valores de R$ 199,99 e R$ 200,01 não podem ser montados com o catálogo (veja a [estratégia](../docs/estrategia-de-testes.md)).
- **CT-09 e CT-20:** falham pela mesma causa do BUG-001.
- **CT-12:** a UI não permite chegar a 6 unidades, então o valor 6 foi coberto pela API no CT-21 (BUG-002).
- **CT-24:** a UI e a API estão consistentes entre si em todos os carrinhos testados, inclusive no erro do limite de R$ 200,00.
- **CT-22 e CT-23:** a evidência cita um arquivo por cenário. Os demais arquivos do mesmo prefixo (`CT-22_*`, `CT-23_*`, `CT-21_*`, `CT-20_*`) ficam em [`../evidencias/`](../evidencias/).

## Sessões exploratórias

| Sessão | Charter | Duração real | Achados |
|---|---|---|---|
| SE-01 | Cupom e frete grátis: combinações de itens, cupom e remoção | curta, não cronometrada | BUG-001 confirmado também no pedido confirmado. Sem outras divergências. Evidência: [SE-01](../evidencias/SE-01_exploratorio-cupom-e-frete.txt) |
| SE-02 | API: robustez de entrada (cupom, quantidade, tipos) e checkout | curta, não cronometrada | BUG-002 confirmado em `/api/pedidos` e com quantidade 1.000.000. Cupom em minúsculas com espaços funciona na API, cupom vazio e null são ignorados, quantidade em texto e negativa dão 422. Evidência: [SE-02](../evidencias/SE-02_api-exploratorio.txt) |

As sessões não foram cronometradas e foram mais curtas que os 30 minutos planejados, porque o escopo é pequeno e o ambiente é compartilhado. Isso está registrado como limitação no README.
