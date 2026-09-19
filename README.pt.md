# focus-kit

In English: [README.md](README.md).

Um processo de entrega para repositórios trabalhados com um agente de
código. É um arquivo só, `SETUP.md`, que qualquer agente lê e transforma
em quatro comandos no seu repositório. Funciona com Claude Code, Codex e
GitHub Copilot, em qualquer língua.

```
/brainstorm  ou  /analyze     uma vez: os documentos do projeto, por conversa ou lendo o código
/propose <slug>               define a próxima entrega em uma página, por conversa
/apply <slug>                 constrói a página, prova, atualiza os docs, faz o stage; nunca commita
```

## Instalar

Abra o seu agente no repositório e diga:

```
Read https://raw.githubusercontent.com/JCKodel/focus-kit/main/SETUP.md and do what it says.
```

Ou baixe o `SETUP.md` ao lado do repositório e aponte o agente para o
arquivo. O agente escreve os quatro comandos na pasta que o host dele lê
(`.claude/skills/`, `.agents/skills/` ou `.github/skills/`) e nada mais.
Não há nada a instalar na máquina: nenhum CLI, nenhum runtime, nenhuma
dependência. Para atualizar, diga a mesma frase de novo.

## Usar

1. **Uma vez.** Num repositório vazio, `/brainstorm`: uma conversa sobre o
   que o produto é, para quem, como é construído e como é entregue. Num
   repositório com código, `/analyze`: o agente lê o código e pergunta só o
   que o código não responde. Os dois terminam escrevendo `docs/00` a `06`,
   `docs/adr/` e `AGENTS.md`, na língua que você escolher para os
   documentos, seja qual for a língua em que você conversa.
2. **A cada entrega.** Escolha uma linha da fila (`docs/06`) e rode
   `/propose <slug>`: uma conversa que termina em `work/<slug>.md`, uma
   página. Abra uma sessão nova e rode `/apply <slug>`: ele constrói a
   página, roda o comando de verificação, prova o resultado, atualiza os
   documentos, move a página para `work/done/`, faz o stage e sugere a
   mensagem de commit. Você revisa e commita.
3. **Repita** até a fila acabar. Ideias novas viram linhas novas na fila,
   por conversa, em qualquer sessão.

Os documentos carregam o peso; os comandos só apontam para eles. O que
cada documento guarda, o formato da página e a fila estão no `SETUP.md`
§3.5, que é também o que o agente instala como referência dos comandos.

## Por que este formato

O processo nasceu no **Ninjobs** (https://www.ninjobs.app), uma plataforma
de vagas de TI com matching bilateral e disclosure progressivo, construída
por um desenvolvedor com o Claude Code de um recomeço em 2026-08-29 até um
beta público em 2026-09-10. Em meados de setembro de 2026: 91 entregas de
uma página, 46 migrations, cerca de 35 mil linhas de TypeScript, 830 testes
unitários e 200 testes de ponta a ponta, tudo pela fila, `/propose` e
`/apply`.

O que fez funcionar é pequeno, e o kit guarda exatamente isso:

* **Os documentos fizeram o trabalho, não os comandos.** O `/propose` do
  Ninjobs tinha onze linhas e o `/apply`, quarenta e oito. Os dois só
  diziam que documentos ler e o que nunca fazer. Todo fato específico do
  projeto (comando de verificação, ambientes, política de publicação,
  como uma tela é provada) morava no documento de processo do próprio
  projeto, escrito uma vez.
* **Uma página por entrega.** Não é meta de concisão: é o teste de que o
  escopo foi entendido. O que não cabia virava duas entregas.
* **Decidir e fazer em sessões separadas.** O `/propose` não escreve
  código; o `/apply` começa limpo, só com a página e os documentos. O
  escopo não cresce durante a implementação porque quem decidiu não está
  na sala.
* **O agente nunca commita.** Ele faz o stage e sugere a mensagem. Toda
  entrega passa por revisão humana porque o commit é a revisão.
* **Um freio contra cerimônia.** O documento de processo do Ninjobs termina
  com a lista do que ele não tem (spec formal, pastas de change, tarefas
  numeradas, portões, subagentes especializados) e uma pergunta para
  qualquer coisa que queira voltar: qual erro concreto isso teria pego? A
  resposta precisa citar um erro que de fato aconteceu.

Uma versão anterior deste kit esqueceu a última regra. Ganhou um
instalador, um grafo de conhecimento, um doctor, um selftest, manifests e
comandos dez vezes mais longos que os que tinham funcionado, fazendo
perguntas que o próprio autor não sabia responder. Esta versão é a volta ao
tamanho que funcionou, com uma adição de que o Ninjobs não precisava: roda
em três hosts e em qualquer língua.

## FOCUS e git, oferecidos e não impostos

`/brainstorm` e `/analyze` explicam duas coisas em um parágrafo cada, com
uma recomendação para a sua stack, e registram o que você escolher:

* **FOCUS**, a arquitetura que dá nome ao kit: quatro peças com fluxo em
  uma direção só (View, Orchestrator, Use Case, Repository), erros como
  valores, código organizado por feature. Você pode adotar inteira, adotar
  só os dois princípios (vertical slices e erros como valores) com a
  estrutura que a sua stack favorece, ou manter as suas convenções. O
  Ninjobs adotou os dois princípios. O livro é FOCUS, de J.C. Ködel
  (https://books.kodel.com.br).
* **Git**: tudo na trunk com uma entrega por vez; uma branch por entrega;
  ou uma worktree por entrega, para que vários agentes construam entregas
  diferentes em paralelo. Em todos os casos o agente nunca commita nem faz
  merge.

## Língua

O projeto escolhe a língua dos documentos uma vez, no `/brainstorm` ou no
`/analyze`. Tudo o que é escrito depois segue essa escolha: documentos,
páginas de entrega, ADRs, mensagens de commit. Os números dos documentos
são fixos (`docs/00`, `docs/05`); os nomes depois deles ficam naquela
língua. Você conversa com o agente na língua que quiser, em qualquer
sessão, e os documentos continuam saindo na língua que o projeto escolheu.

## Layout deste repositório

```
SETUP.md       o kit: o que o agente faz, e os quatro comandos com a referência deles
README.md      a documentação em inglês
README.pt.md   este arquivo
LICENSE        AGPL-3.0-only
```

## Licença

O focus-kit é licenciado sob a GNU Affero General Public License, versão 3
apenas (`LICENSE`).

**Permissão adicional sob a seção 7 da AGPL-3.0.** Os documentos que os
quatro comandos escrevem num repositório (`docs/`, `work/`, `AGENTS.md`,
`CLAUDE.md`) não são obras cobertas do focus-kit. Eles pertencem àquele
repositório, sob a licença que o dono escolher. Os arquivos de comando que
o agente instala a partir do `SETUP.md` continuam sob a AGPL, e mantê-los
num repositório é agregação, o que não estende a AGPL ao código daquele
repositório.

Termos fora da AGPL são concedidos apenas pelo autor, J.C. Ködel, a pedido,
pelas issues deste repositório no GitHub.
