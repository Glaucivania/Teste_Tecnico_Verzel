# Bugs

## Resumo executivo

Execução de 06/10/2026 na v2.3.0: 24 cenários, 20 passaram e 4 falharam. As 4 falhas vêm de **2 bugs**, ambos em regras de negócio da entrega. Cupom, caixa e espaços, mensagens, remoção de itens, checkout e API de erros se comportam como a documentação.

| ID | Título | Severidade | Prioridade | Camada | Cenários |
|---|---|---|---|---|---|
| [BUG-001](BUG-001.md) | Frete é cobrado quando o subtotal é exatamente R$ 200,00 | Alta | P1 | UI e API | CT-08, CT-09, CT-20 |
| [BUG-002](BUG-002.md) | A API aceita mais de 5 unidades por produto | Média | P2 | API | CT-21 |

Por severidade: 1 alta e 1 média. Nenhuma crítica ou baixa.

Recomendação: corrigir o BUG-001 antes de liberar a entrega, porque afeta o valor mais divulgado da promoção. O BUG-002 pode ir no mesmo ciclo.

## Modelo

Cada `BUG-NNN.md` segue o [modelo](_modelo.md).
