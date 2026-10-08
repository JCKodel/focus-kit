# focus-kit

In English: [README.md](README.md).

Um processo de entrega para repositórios trabalhados com um agente de
código. É um arquivo só, `SETUP.md`, que qualquer agente lê e transforma
em quatro comandos no seu repositório. Funciona com Claude Code, Codex,
GitHub Copilot, Cursor, Google Antigravity, Gemini CLI, Windsurf e qualquer
outro host que leia `AGENTS.md`, em qualquer língua.

```
/brainstorm  ou  /analyze     uma vez: os documentos do projeto, por conversa ou lendo o código
/propose <slug>               define a próxima entrega em uma página, por conversa
/apply <slug>                 constrói a página, prova, atualiza os docs, faz o stage; nunca commita
```

A `/` é como o Claude Code e a maioria dos hosts os invocam; o Codex e o
Windsurf usam outro prefixo, que a tabela do `SETUP.md` §1 traz. Todo
comando escreve o próximo na forma que o seu host espera.

## Instalar

Abra o seu agente no repositório e diga:

```
Read https://raw.githubusercontent.com/JCKodel/focus-kit/main/SETUP.md and do what it says.
```

Ou baixe o `SETUP.md` ao lado do repositório e aponte o agente para o
arquivo. O agente escreve os quatro comandos para todos os hosts que o kit
conhece (`.claude/skills/`, `.agents/skills/`, `.windsurf/skills/` e os
arquivos-ponteiro de Copilot, Cursor, Gemini CLI e Antigravity) e nada
mais, e o repositório abre pronto em qualquer um deles. Não há nada a
instalar na máquina: nenhum CLI, nenhum runtime, nenhuma dependência. Para
atualizar, diga a mesma frase de novo.

O setup confere os destinos existentes antes de escrever: um comando
próprio ou uma edição não reconhecida é reportado com um diff para você
resolver. Atualizações substituem arquivos reconhecidos do kit e mantêm
um único ponteiro no `GEMINI.md`, preservando o conteúdo do projeto. Seus
documentos ficam intactos; regras que ainda precisam de migração são
reportadas com os caminhos e o texto proposto. A versão das skills indica
os comandos instalados, não a conclusão dessas migrações.

### Hosts que ninguém da equipe usa

Os arquivos deles podem sair, mas cada atualização os escreve de novo, e
quem abrir o repositório nesse host depois não encontra os comandos nem
aviso algum. Nunca remova `AGENTS.md`, `docs/`, `work/` ou
`.agents/skills/`: apesar do nome, `.agents/` não é a pasta de um host, e
sim a cópia dos comandos que Codex, Copilot, Cursor, Gemini CLI,
Antigravity, OpenCode e Zed leem. O que pertence a um host só:

| Host | Seus arquivos | Antes de remover |
|---|---|---|
| Gemini CLI | `.gemini/commands/` e `GEMINI.md` | `GEMINI.md` pode ter conteúdo do projeto; remova só a linha-ponteiro |
| Cursor | `.cursor/commands/` | |
| GitHub Copilot | os quatro `.github/prompts/<name>.prompt.md` | o resto de `.github/` não é do kit |
| Antigravity | `.agents/rules/focus-kit.md` | só esse arquivo, não `.agents/` |
| Windsurf | `.windsurf/skills/` | |
| Claude Code | `.claude/skills/` e `CLAUDE.md` | `CLAUDE.md` pode ter notas além de `@AGENTS.md` |
| Codex | os quatro `.agents/skills/<name>/agents/openai.yaml` | eles impedem o Codex de rodar o `apply` só porque uma mensagem contém a palavra |

## Usar

1. **Uma vez.** Num repositório vazio, `/brainstorm`: uma conversa sobre o
   que o produto é, para quem, como é construído e como é entregue. Num
   repositório com código, `/analyze`: o agente lê o código e pergunta só o
   que o código não responde. Os dois terminam escrevendo `docs/00` a `06`,
   `docs/adr/` e `AGENTS.md`, na língua que você escolher para os
   documentos, seja qual for a língua em que você conversa.
2. **A cada entrega.** Escolha uma linha da fila (`docs/06`) e rode
   `/propose <slug>`: uma conversa que termina em `work/<slug>.md`, uma
   página. Leia e peça cada correção nessa mesma conversa; depois abra uma
   sessão nova e rode `/apply <slug>`: ele constrói a
   página, roda o comando de verificação, prova o resultado, atualiza os
   documentos, move a página para `work/done/`, termina a página com a
   mensagem de commit que sugere, faz o stage e mostra essa mensagem
   também na conversa, no mesmo bloco `commit`.
   Termina com os seus próximos passos, com os comandos por extenso:
   revisar, commitar e então a próxima linha da fila. Você revisa e
   commita.
   A fila mostra isso enquanto acontece: a linha fica `[~]` enquanto o
   `/propose` conversa, `[>]` quando a página está completamente definida,
   `[*]` enquanto o `/apply` constrói e `[x]` quando termina. Só as mudanças
   da entrega entram no stage; edições alheias e entradas já existentes no
   índice são preservadas e reportadas. Uma construção bloqueada na trunk
   fica sem commit até a entrega inteira estar pronta; sua página guarda
   um rascunho de mensagem apontando para o caminho atual.
3. **Repita** até a fila acabar. Perdido? Pergunte ao agente em que ponto
   está, em qualquer sessão: ele responde a partir do `docs/06` e do
   `work/`, com o próximo comando. Ideias novas viram linhas novas na fila,
   por conversa, em qualquer sessão. Uma linha que espera uma resposta,
   outra linha ou qualquer motivo que você diga vira `[?]`, com o motivo no
   fim, até ele se resolver. Ela também registra se deve retomar o
   `/propose` ou o `/apply`: uma proposta parcial precisa terminar a
   definição antes de ser construída.
4. **Todo milestone** é planejado com uma revisão como última linha,
   rodada como qualquer entrega. Ela percorre o parágrafo do milestone
   cláusula por cláusula e diz qual entrega responde a cada uma e como
   você testa. Você testa; o que falta ou falha nas suas mãos vira uma
   linha no mesmo milestone, abaixo da revisão, pronta para `/propose` e
   `/apply`. Essas linhas não passam por segunda revisão: o seu commit é a
   revisão.

Os documentos carregam o peso; os comandos só apontam para eles. O que
cada documento guarda, o formato da página e a fila estão no `SETUP.md`
§3.5, que é também o que o agente instala como referência dos comandos.

## Documentação

Esta página é a versão curta. A longa é um livro gratuito, em português e
inglês: **Uma Página de Cada Vez: entregando software e projetos com
agentes de IA**, de J.C. Ködel. Ele leva quem nunca seguiu processo algum
a conduzir projetos inteiros com agentes de IA: Spec-Driven Development
como ideia, focus-kit como método e ferramenta, FOCUS como arquitetura
opcional e o git necessário para trabalhar com agentes em paralelo e com
equipes.

* Site: https://jckodel.github.io/focus-kit-book/pt/
* PDF e EPUB: https://github.com/JCKodel/focus-kit-book/releases
* Fonte: https://github.com/JCKodel/focus-kit-book, um livro escrito com
  o kit, como o seu exemplo de projeto que não é software

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
em qualquer host que leia `AGENTS.md` e em qualquer língua.

## FOCUS e git, oferecidos e não impostos

`/brainstorm` e `/analyze` explicam duas coisas em um parágrafo cada, com
uma recomendação para a sua stack, e registram o que você escolher:

* **FOCUS**, a arquitetura que dá nome ao kit: quatro peças com fluxo em
  uma direção só (View, Orchestrator, Use Case, Repository), erros como
  valores, código organizado por feature. Você pode adotar inteira, adotar
  só os dois princípios (vertical slices e erros como valores) com a
  estrutura que a sua stack favorece, ou manter as suas convenções. O
  Ninjobs adotou os dois princípios. O FOCUS é o capítulo 7 do livro
  (https://jckodel.github.io/focus-kit-book/pt/07-four-pieces/).
* **Git**: tudo na trunk com uma entrega por vez, para uma pessoa
  trabalhando sozinha; uma branch por entrega, para trabalho sequencial
  revisado por pull request; ou uma worktree por entrega, para que vários
  agentes construam entregas diferentes em paralelo, depois de decidir
  quais podem rodar juntas. Em todos os casos a página e a construção de
  uma entrega são uma mudança só, revertida em um passo (um commit na
  trunk, um merge nas outras), e o agente nunca commita nem faz merge.
  Worktrees em paralelo mostram o estado da sua própria fila; ao integrar
  suas branches, concilie o `docs/06` por slug, preservando cada entrega e
  seu estado mais recente. A fila é um arquivo compartilhado mesmo quando
  as entregas mudam códigos diferentes.

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
CHANGELOG.md   o que mudou em cada versão (CHANGELOG.pt.md em português)
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
