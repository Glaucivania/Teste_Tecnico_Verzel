# Ambiguidades e interpretações

Fonte: [documentação da entrega VZS-142](https://verzel-store.qa-test-verzel-store.workers.dev/documentacao). Onde o texto não define o comportamento, registro a interpretação adotada e sigo em frente. Cada item será confirmado na loja durante a execução.

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
| AMB-01 | O carrinho persiste ao recarregar a mesma aba? | Sim, o carrinho e o cupom devem ser mantidos. | A fazer |
| AMB-02 | O que a UI faz ao tentar mais de 5 unidades? | Qualquer feedback claro é aceito, desde que a quantidade nunca passe de 5. | A fazer |
| AMB-03 | Qual o critério de arredondamento? | Arredondamento comercial (meio para cima) em 2 casas. | A fazer |
| AMB-04 | Itens removidos com cupom aplicado: o desconto é recalculado? | Sim, sobre o novo subtotal, e o frete é reavaliado. | A fazer |
| AMB-05 | Cupom com carrinho vazio? | Não aplica desconto e sinaliza de forma clara. | A fazer |
| AMB-06 | Reaplicar o mesmo cupom? | Não acumula, o desconto continua em 10%. | A fazer |
| AMB-07 | Aplicar um segundo cupom com um já ativo? | A UI bloqueia ou avisa que é preciso remover o atual (CA05). | A fazer |
| AMB-08 | Cupom vazio ou só com espaços? | Não aplica nada e dá feedback claro. | A fazer |
| AMB-09 | Textos de erro de nome, e-mail e CEP não estão definidos. | Valido as regras listadas e registro o texto observado. | A fazer |
| AMB-10 | `calcular` com quantidade maior que 5? | Responde 422 `QUANTIDADE_MAXIMA_EXCEDIDA`, como a tabela de erros. | A fazer |
| AMB-11 | O "faltante para frete grátis" usa o subtotal ou o subtotal menos o desconto? | Subtotal, coerente com o CA08. | A fazer |
