# Ambiguidades e interpretações

Fonte: [documentação da entrega VZS-142](https://verzel-store.qa-test-verzel-store.workers.dev/documentacao).

## Resumo das regras

| Tema | Regra |
|---|---|
| Cupom | `BEMVINDO10` dá 10% sobre o subtotal. `VERAO2026` expirou em 31/03/2026. |
| Código | Não diferencia maiúsculas e ignora espaços nas pontas (CA02). |
| Mensagens | "Cupom inválido." e "Cupom expirado.", sem desconto (CA03 e CA04). |
| Limite de cupons | Um por vez. Para trocar, remover o atual (CA05). |
| Frete | R$ 19,90 abaixo de R$ 200,00. Grátis a partir de R$ 200,00, inclusive (CA06 e CA07). |
| Base do frete | Subtotal antes do desconto (CA08). O desconto não incide sobre o frete (CA09). |
| Quantidade | Máximo de 5 por produto, na UI e na API (CA10). |
| Arredondamento | 2 casas decimais (CA11). |
| Total | `total = subtotal - desconto + frete`. |

## Fora do escopo por simplificação do ambiente (não é bug)

- Carrinho guardado só na aba do navegador.
- Pedidos não armazenados, número fictício, sem consulta de pedidos.
- Sem e-mail, cobrança ou controle de estoque.
- Produtos, preços e cupons fixos. API sem estado.
- Fora do escopo: login, cadastro, pagamento online e consulta de pedidos.

## Ambiguidades

| ID | Ambiguidade | Interpretação adotada | Verificado |
|---|---|---|---|
| AMB-01 | O carrinho persiste ao recarregar a mesma aba? | Sim, o carrinho e o cupom devem ser mantidos. | Confirmado na UI: itens e cupom persistem ao recarregar (guardados em `sessionStorage`). |
| AMB-02 | O que a UI faz ao tentar mais de 5 unidades? | Qualquer feedback claro é aceito, desde que a quantidade nunca passe de 5. | Confirmado na UI: o botão + fica desabilitado em 5 e aparece "Limite de 5 unidades por produto." |
| AMB-03 | Qual o critério de arredondamento? | Arredondamento comercial (meio para cima) em 2 casas. | Confirmado: valores com 2 casas, sem erro de ponto flutuante (CT-05). Com 10% o arredondamento nunca é exercido. |
| AMB-04 | Itens removidos com cupom aplicado: o desconto é recalculado? | Sim, sobre o novo subtotal, e o frete é reavaliado. | Confirmado: desconto recalculado sobre o novo subtotal e frete reavaliado (CT-05). |
| AMB-05 | Cupom com carrinho vazio? | Não aplica desconto e sinaliza de forma clara. | Confirmado: carrinho vazio mostra a tela "Seu carrinho está vazio", sem campo de cupom (CT-04). |
| AMB-06 | Reaplicar o mesmo cupom? | Não acumula, o desconto continua em 10%. | Confirmado: depois de aplicar, o campo some e não acumula (CT-04). |
| AMB-07 | Aplicar um segundo cupom com um já ativo? | A UI bloqueia ou avisa que é preciso remover o atual (CA05). | Confirmado: um segundo cupom só entra após "Remover cupom" (CT-04). |
| AMB-08 | Cupom vazio ou só com espaços? | Não aplica nada e dá feedback claro. | Confirmado: aparece "Informe um cupom." e nada é aplicado (CT-04). |
| AMB-09 | Textos de erro de nome, e-mail e CEP não estão definidos. | Valido as regras listadas e registro o texto observado. | Confirmado: "Informe nome e sobrenome.", "Informe um e-mail válido." e "Informe um CEP com 8 dígitos." (CT-11 e CT-19). |
| AMB-10 | `calcular` com quantidade maior que 5? | Responde 422 `QUANTIDADE_MAXIMA_EXCEDIDA`, como a tabela de erros. | **Divergente**: a API respondeu 200 com quantidade 6 (ver BUG-002). |
| AMB-11 | O "faltante para frete grátis" usa o subtotal ou o subtotal menos o desconto? | Subtotal, coerente com o CA08. | Confirmado: o faltante usa o subtotal (ex.: subtotal 179,70 com cupom mostra "Faltam R$ 20,30"). |

## Exploração inicial (Fase 0)

Sessão curta de reconhecimento em 06/10/2026, Chromium embutido e `curl`, com poucas requisições.

**Como a loja funciona**

- Páginas: lista de produtos (`/`), carrinho (`/carrinho`) e documentação (`/documentacao`).
- O carrinho e o cupom ficam em `sessionStorage` (`verzel-store:itens` e `verzel-store:cupom`).
- No carrinho há campo de cupom, botão "Aplicar cupom", "Remover cupom", botões de quantidade (-, +), "Remover", "Esvaziar carrinho" e "Finalizar compra".
- Não há `data-testid` na interface. Para a automação, usar `getByRole`, `getByLabel` e `getByText`. Exemplos: `getByRole('textbox', { name: 'Cupom de desconto' })` e `getByRole('button', { name: 'Aplicar cupom' })`.
- A mensagem da UI ao aplicar é "Cupom BEMVINDO10 aplicado." e a da API é "Cupom aplicado: 10% de desconto nos produtos.".
- A atualização do resumo após aplicar o cupom tem pequena latência. Na automação, usar espera por asserção, sem sleep fixo.

**Achados preliminares (confirmados na Fase 2 e reportados como BUG-001 e BUG-002)**

| ID | Observação | Esperado (documentação) |
|---|---|---|
| F-01 (BUG-001) | `POST /api/carrinho/calcular` com subtotal exato de R$ 200,00 (2 x P005) devolveu `frete: 19.9`, `freteGratis: false` e `valorFaltanteFreteGratis: 0`, com ou sem cupom. A resposta é incoerente: o faltante é 0, mas o frete é cobrado. Na UI, 4 x P001 (R$ 239,60) deu frete grátis. | CA06: frete grátis a partir de R$ 200,00, inclusive. |
| F-02 (BUG-002) | `POST /api/carrinho/calcular` com 6 unidades de P001 devolveu 200 e calculou o total, sem erro. | CA10 e tabela de erros: 422 `QUANTIDADE_MAXIMA_EXCEDIDA` (vale também para a API). Obs.: a documentação diz que um erro de quantidade é 422, mas só cita explicitamente o pedido. Confirmar também em `POST /api/pedidos` na Fase 2. |

**Conferido e sem divergência**

- Cupom `  bemvindo10  ` (minúsculas e espaços) aplicado, com 10% de desconto (R$ 5,99 sobre R$ 59,90, total R$ 73,81).
- Cupom `VERAO2026` via API: 200, sem desconto, "Cupom expirado.".
- Cálculos de subtotal, desconto e total corretos para 1 a 5 unidades de P001, com o frete trocando de R$ 19,90 para grátis ao passar de R$ 200,00.
