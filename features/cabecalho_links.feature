# language: pt

Funcionalidade: Operador acessa os links Manha, Tarde e Noite
  Como um usuário administrador ou monitor
  Com o objetivo de visualizar os relatorios
  Eu deveria poder via links Manha, Tarde e Noite acessar o relatorio

  Contexto: Dado os seguintes monitoramento
    | user     | visor  | cameras    | novidades
    | Operador | Mesa 1 | R1 x Duque | Teste

  Cenário: Acessar relatorios da manha
    Dado que eu estou na página home
    Quando eu clicar no link "Manha"
    Então eu devo estar na página Monitoramento