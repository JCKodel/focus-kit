# Changelog

O que mudou no kit, do mais recente ao mais antigo. A versão é a linha
`Version:` do `SETUP.md`, o mesmo valor que um repositório plantado traz
no `metadata.version` dos seus quatro `SKILL.md`. Para levar um
repositório à versão mais recente, rode o `SETUP.md` de novo.

In English: [CHANGELOG.md](CHANGELOG.md).

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
