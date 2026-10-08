# Changelog

O que mudou no kit, do mais recente ao mais antigo. A versão é a linha
`Version:` do `SETUP.md`, o mesmo valor que um repositório plantado traz
no `metadata.version` dos seus quatro `SKILL.md`. Para levar um
repositório à versão mais recente, rode o `SETUP.md` de novo e aplique as
migrações dos documentos do projeto que o relatório identificar.

In English: [CHANGELOG.md](CHANGELOG.md).

## 2026.10.08

- Os cenários de Behaviour da página dizem uma entrada concreta e o
  resultado que o usuário vê, e incluem os casos que devem falhar e as
  bordas que os documentos implicam. O `/propose` os rascunha a partir dos
  documentos; a pessoa corrige em vez de escrever. Antes, uma pessoa que
  não conhecia a ferramenta sendo construída deixou o resultado esperado
  com o agente, que entregou uma solução só com o caminho feliz, e o
  cliente a recusou.
- A §3 do docs/05 pertence ao projeto, então rodar o `SETUP.md` de novo
  reporta o novo texto de Behaviour como migração em vez de escrevê-lo.

## 2026.10.07

- Linhas bloqueadas lembram se retomam o `/propose` ou o `/apply`;
  rascunhos salvos precisam estar definidos por completo antes da
  implementação. Branches paralelas conciliam a fila sem perder achados
  ou dependências.
- O `/apply` faz stage só da sua entrega e preserva mudanças alheias.
  Trabalho bloqueado mantém uma mensagem parcial na página; na trunk,
  fica sem commit. A §6 do docs/05 é dona do formato de commit.
- O setup preserva comandos próprios, evita ponteiros duplicados no Gemini
  e corrige a ativação no Antigravity, a invocação no Claude Code e as
  entradas no Copilot. `/propose` e `/apply` apontam para as regras comuns
  do processo.
- Projetos existentes recebem um relatório de migração para docs/04,
  docs/05 e `AGENTS.md`, com caminhos e texto proposto; o setup preserva
  esses arquivos.

## 2026.10.06.1

- Código só muda dentro do `/apply`. Uma mudança pedida em qualquer outro
  lugar, por menor que seja, vira uma linha `[ ]` no docs/06 e a resposta
  para aí. Antes, a regra só existia dentro do `/apply`, para uma correção
  achada no meio dele: pedida uma correção numa sessão comum, um agente
  editou o código direto, sem linha na fila, sem página e sem verify.
- A regra está na §2 do docs/05 e nos Non-negotiables do `AGENTS.md`, como
  o `/brainstorm` e o `/analyze` os escrevem. Os dois arquivos são do
  projeto, então rodar o `SETUP.md` de novo não mexe neles: num
  repositório já plantado, acrescente a frase em cada um à mão.

## 2026.10.06

- O `/apply` termina a página com a mensagem de commit que sugere, num
  bloco cercado cuja info string é `commit`, no caminho feito e no
  bloqueado. Antes, a mensagem só existia no chat: um agente respondeu com
  linhas `git commit -m`, e quem commitava depois, noutra janela ou noutra
  sessão, não tinha de onde partir.
- A §3 do docs/05 diz que a página feita termina nesse bloco.

## 2026.10.05

- A fila mostra o trabalho enquanto ele acontece. Duas marcas se juntam a
  `[ ]`, `[>]` e `[x]`: `[~]` enquanto o `/propose` conversa, `[*]`
  enquanto o `/apply` constrói.
- `[?]` marca uma linha que espera: pela pessoa, por uma resposta ainda
  não dada ou por outras linhas. O motivo vai no fim da linha, como
  `· blocked: <reason>` ou `· blocked: after <slug>, <slug>`.
- O `/apply` para quando o trabalho não pode seguir, escreve na página o
  que foi construído e pelo que ela espera, e marca a linha `[?]`. Quando
  marca `[x]` a última linha que um `after` cita, a linha que esperava
  volta para `[>]`, ou para `[ ]` quando não tem página.
- O docs/05 §4 ganha a tabela de marcas: o que cada uma significa e quem
  a coloca.

## 2026.10.04.1

- `context/` guarda o que as pessoas disseram: propostas, e-mails,
  transcrições. Cada item é o original, inteiro, ao lado de um
  `<name>.md` que diz o que ele é; nunca um resumo.
- O `/brainstorm` e o `/analyze` leem `context/` inteiro quando ele
  existe.
- O docs/05 §5 ganha o campo Context: `context/` vai para o commit ou
  para o `.gitignore`.

## 2026.10.04

- O kit diz a sua versão: a linha `Version:` do `SETUP.md` e o
  `metadata.version` nos quatro `SKILL.md`.

## Antes das versões, de 2026-09-19 a 2026-09-30

O kit como ele é hoje, antes de ter versão. Um repositório plantado neste
período não tem `metadata.version` nas skills; rodar o `SETUP.md` de novo
o leva à versão mais recente.

- O kit volta a ser um arquivo só: o `SETUP.md` contém o que o agente
  faz, a tabela de hosts, os quatro comandos e a referência deles. O
  `/brainstorm` e o `/analyze` iniciam um projeto; o `/propose` e o
  `/apply` entregam. A fila é editada por conversa.
- Todo host recebe seus arquivos em toda execução: as skills vão para
  `.claude/skills/`, `.agents/skills/` e `.windsurf/skills/`, com arquivos
  de apontamento para Copilot, Cursor, Gemini CLI e Antigravity.
- A página e a sua construção são uma mudança só: um commit no trunk, um
  merge com branch ou worktree. O `/propose` cria a branch ou a worktree
  antes de escrever a página e termina pedindo que a pessoa a leia.
- Todo marco termina com a sua revisão, executada como qualquer entrega.
  Ela percorre o parágrafo do marco cláusula por cláusula e diz como
  testar cada uma; a pessoa testa. Um achado é uma linha no mesmo marco,
  e as linhas que uma revisão acrescenta não são revisadas de novo.

Versões anteriores do kit, com instalador e CLI, foram substituídas em
2026-09-19; o `README.pt.md` §Por que este formato diz por quê.
