# language: pt
@carrinho
Funcionalidade: Carrinho, checkout e qualidade da interface
  Como cliente da Verzel Store
  Quero montar o carrinho e finalizar a compra
  Para receber meus produtos

  Contexto:
    Dado que o carrinho está vazio

  @CT-12 @regressao @ui @P1
  Esquema do Cenário: CT-12 Limite de 5 unidades por produto na interface (CA10, AMB-02)
    Dado que adicionei "Camiseta Essencial" ao carrinho
    Quando ajusto a quantidade para <alvo>
    Então a quantidade exibida é <exibida>
    E <comportamento>

    Exemplos:
      | alvo | exibida | comportamento                                          |
      | 1    | 1       | o botão de diminuir não deixa a quantidade abaixo de 1 |
      | 5    | 5       | o botão de aumentar fica desabilitado                  |
      | 6    | 5       | vejo "Limite de 5 unidades por produto."               |

  @CT-13 @regressao @ui @P2
  Cenário: CT-13 O carrinho e o cupom persistem ao recarregar a aba (AMB-01)
    Dado que adicionei "Camiseta Essencial" ao carrinho
    E que apliquei o cupom "BEMVINDO10"
    Quando recarrego a página
    Então o carrinho continua com "Camiseta Essencial"
    E o cupom "BEMVINDO10" continua aplicado

  @CT-14 @smoke @regressao @ui @P1
  Cenário: CT-14 Finalizar compra com dados válidos confirma o pedido
    Dado que adicionei "Mochila Urbana 20L" ao carrinho
    Quando finalizo a compra com nome "Maria Silva", e-mail "maria@exemplo.com" e CEP "01310-100"
    Então vejo a confirmação com um número de pedido no formato "VZ-000000"
    E o total confirmado é "R$ 119,90"

  @CT-15 @regressao @ui @P2
  Esquema do Cenário: CT-15 Validação de nome, e-mail e CEP no checkout
    Dado que adicionei "Mochila Urbana 20L" ao carrinho
    Quando finalizo a compra com nome "<nome>", e-mail "<email>" e CEP "<cep>"
    Então o resultado é "<resultado>"

    Exemplos:
      | nome         | email             | cep        | resultado                       |
      | Maria        | maria@exemplo.com | 01310100   | recusado: nome sem sobrenome    |
      | Maria Silva  | maria@exemplo     | 01310100   | recusado: e-mail inválido       |
      | Maria Silva  | maria@exemplo.com | 0131010    | recusado: CEP com 7 dígitos     |
      | Maria Silva  | maria@exemplo.com | 013101000  | recusado: CEP com 9 dígitos     |
      | Maria Silva  | maria@exemplo.com | 01310-100  | aceito: CEP com hífen           |
      | Maria Silva  | maria@exemplo.com | 01310100   | aceito: CEP sem hífen           |

  @CT-16 @regressao @ui @P3
  Cenário: CT-16 Responsividade e acessibilidade básicas
    Quando abro o carrinho em 375 px de largura
    Então não há rolagem horizontal e os botões continuam acessíveis
    E todos os campos e botões têm nome acessível
    E consigo aplicar um cupom usando apenas o teclado
    E o foco fica visível durante a navegação
