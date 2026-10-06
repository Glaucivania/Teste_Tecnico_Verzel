# Resultados da execução

**Ambiente:** https://verzel-store.qa-test-verzel-store.workers.dev (v2.3.0)
**Data:** 2026-10-06 | **Executor:** QA
**Método:** execução manual guiada pelos cenários em [`../cenarios/`](../cenarios/). A interface foi exercitada no Google Chrome 153 (Windows 11), pela extensão Claude in Chrome e por um script de captura em Playwright, e a API pelo Postman, com poucas requisições. Uma rodada inicial no Chromium embutido do app Claude teve os mesmos resultados.

## Resumo

| Resultado | Quantidade |
|---|---|
| Passou | 16 |
| Falhou | 4 (CT-06, CT-07, CT-16 e CT-17) |
| Bloqueado | 0 |
| Total | 20 |

Bugs encontrados: [BUG-001](../bugs/BUG-001.md) (frete cobrado no subtotal de R$ 200,00) e [BUG-002](../bugs/BUG-002.md) (API aceita mais de 5 unidades por produto).

## Execução por cenário

| ID | Título | Resultado | Data | Navegador ou cliente | Evidência | Bug |
|---|---|---|---|---|---|---|
| CT-01 | BEMVINDO10 dá 10% sobre o subtotal e não incide no frete | Passou | 2026-10-06 | Google Chrome 153 e Postman | [CT-01_aplicar-bemvindo10-ui.png](../evidencias/CT-01_aplicar-bemvindo10-ui.png) |  |
| CT-02 | Cupom sem diferenciar caixa e com espaços | Passou | 2026-10-06 | Google Chrome 153 | [CT-02_caixa-e-espacos-ui.png](../evidencias/CT-02_caixa-e-espacos-ui.png) |  |
| CT-03 | Cupom inexistente ou expirado: mensagens e sem desconto | Passou | 2026-10-06 | Google Chrome 153 | [CT-03_cupom-invalido-expirado-ui.png](../evidencias/CT-03_cupom-invalido-expirado-ui.png) |  |
| CT-04 | Um cupom por vez, sem acúmulo, e casos de borda do campo | Passou | 2026-10-06 | Google Chrome 153 | [CT-04_cupom-unico-e-casos-de-borda-ui.png](../evidencias/CT-04_cupom-unico-e-casos-de-borda-ui.png) |  |
| CT-05 | Remover item ou cupom recalcula valores, com 2 casas decimais | Passou | 2026-10-06 | Google Chrome 153 e Postman | [CT-05_remover-item-e-cupom-ui.png](../evidencias/CT-05_remover-item-e-cupom-ui.png) |  |
| CT-06 | Limite do frete grátis (199,90, 200,00 e 229,90) | Falhou | 2026-10-06 | Google Chrome 153 e Postman | [CT-06_frete-limite-ui-vs-api.png](../evidencias/CT-06_frete-limite-ui-vs-api.png) | BUG-001 |
| CT-07 | Frete usa o subtotal antes do cupom | Falhou | 2026-10-06 | Google Chrome 153 e Postman | [CT-07_cupom-e-frete-ui-vs-api.png](../evidencias/CT-07_cupom-e-frete-ui-vs-api.png) | BUG-001 |
| CT-08 | Limite de 5 unidades na UI | Passou | 2026-10-06 | Google Chrome 153 | [CT-08_limite-5-unidades-ui.png](../evidencias/CT-08_limite-5-unidades-ui.png) |  |
| CT-09 | Carrinho persiste ao recarregar a aba | Passou | 2026-10-06 | Google Chrome 153 | [CT-09_persistencia-ui.png](../evidencias/CT-09_persistencia-ui.png) |  |
| CT-10 | Checkout válido | Passou | 2026-10-06 | Google Chrome 153 | [CT-10_checkout-ui.png](../evidencias/CT-10_checkout-ui.png) |  |
| CT-11 | Validação de nome, e-mail e CEP | Passou | 2026-10-06 | Google Chrome 153 | [CT-11_validacao-checkout-ui.png](../evidencias/CT-11_validacao-checkout-ui.png) |  |
| CT-12 | Responsividade e acessibilidade básica | Passou | 2026-10-06 | Google Chrome 153 (desktop e viewport de 375 px) | [CT-12_responsividade-e-acessibilidade.png](../evidencias/CT-12_responsividade-e-acessibilidade.png) |  |
| CT-13 | API: produtos | Passou | 2026-10-06 | Postman | [CT-13_produtos-lista.jpeg](../evidencias/CT-13_produtos-lista.jpeg) |  |
| CT-14 | API: calcular com BEMVINDO10 | Passou | 2026-10-06 | Postman | [CT-14_calcular-bemvindo10.jpeg](../evidencias/CT-14_calcular-bemvindo10.jpeg) |  |
| CT-15 | API: calcular com cupom inválido ou expirado | Passou | 2026-10-06 | Postman | [CT-15_calcular-cupom-expirado.jpeg](../evidencias/CT-15_calcular-cupom-expirado.jpeg) |  |
| CT-16 | API: limite do frete | Falhou | 2026-10-06 | Postman | [CT-16_calcular-200-00.jpeg](../evidencias/CT-16_calcular-200-00.jpeg) | BUG-001 |
| CT-17 | API: erros 4xx | Falhou | 2026-10-06 | Postman | [CT-17_quantidade-6.jpeg](../evidencias/CT-17_quantidade-6.jpeg) | BUG-002 |
| CT-18 | API: pedidos | Passou | 2026-10-06 | Postman | [CT-18_pedido-bemvindo10.jpeg](../evidencias/CT-18_pedido-bemvindo10.jpeg) |  |
| CT-19 | API: pedidos com cliente inválido | Passou | 2026-10-06 | Postman | [CT-19_nome-sem-sobrenome.jpeg](../evidencias/CT-19_nome-sem-sobrenome.jpeg) |  |
| CT-20 | Consistência UI x API | Passou | 2026-10-06 | Google Chrome 153 e Postman | [CT-20_consistencia-ui-vs-api.png](../evidencias/CT-20_consistencia-ui-vs-api.png) |  |

## Observações

- **Fusão de cenários:** a versão inicial tinha 24 cenários. Por sobreposição, quatro foram incorporados a outros: o desconto sem incidir no frete entrou no CT-01, inválido e expirado viraram o CT-03, o cupom vazio entrou no CT-04 e as casas decimais entraram no CT-05.
- **CT-04:** a UI esconde o campo de cupom depois de aplicar um, então só se troca de cupom removendo o atual (CA05). A reaplicação do mesmo cupom não é possível pela interface.
- **CT-06:** os subtotais de R$ 199,90 e de R$ 229,90 passam, e o de R$ 200,00 falha. Os valores de R$ 199,99 e R$ 200,01 não podem ser montados com o catálogo (veja a [estratégia](../docs/estrategia-de-testes.md)).
- **CT-07 e CT-16:** falham pela mesma causa do BUG-001.
- **CT-08:** a UI não permite chegar a 6 unidades, então o valor 6 foi coberto pela API no CT-17 (BUG-002).
- **CT-20:** a UI e a API estão consistentes entre si em todos os carrinhos testados, inclusive no erro do limite de R$ 200,00.
- **Evidências de API:** a coluna cita um arquivo por cenário. Cada cenário tem uma única imagem de evidência, em [`../evidencias/`](../evidencias/).

## Rodadas no Google Chrome

Em 2026-10-06, os cenários de UI (CT-01 a CT-12 e CT-20) foram reexecutados no **Google Chrome 153** e os resultados foram os mesmos da rodada inicial no Chromium embutido do app Claude: 16 passaram e 4 falharam, e o BUG-001 foi reproduzido na UI e na API.

Cada cenário tem **uma imagem** de evidência: capturas do Google Chrome 153 para a UI e capturas do Postman para a API (com a aba Test Results).

A suíte Playwright (CT-01, CT-06 e CT-14) foi executada no **Google Chrome 153.0.8010.54** (canal `chrome`), com 1 worker: 5 testes, `5 passed`, sendo o caso de R$ 200,00 do CT-06 um `test.fail` do BUG-001.

## Sessões exploratórias

| Sessão | Charter | Duração real | Achados |
|---|---|---|---|
| SE-01 | Cupom e frete grátis: combinações de itens, cupom e remoção | curta, não cronometrada | BUG-001 confirmado também no pedido confirmado. Sem outras divergências. |
| SE-02 | API: robustez de entrada (cupom, quantidade, tipos) e checkout | curta, não cronometrada | BUG-002 confirmado em `/api/pedidos` e com quantidade 1.000.000. Cupom em minúsculas com espaços funciona na API, cupom vazio e null são ignorados, quantidade em texto e negativa dão 422. |

As sessões não foram cronometradas e foram mais curtas que os 30 minutos planejados, porque o escopo é pequeno e o ambiente é compartilhado. Isso está registrado como limitação no README.
