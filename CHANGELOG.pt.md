# Changelog

O que mudou no kit, do mais recente ao mais antigo. A versão é a linha
`Version:` do `SETUP.md`, o mesmo valor que um repositório plantado traz
no `metadata.version` dos seus quatro `SKILL.md`. Para levar um
repositório à versão mais recente, rode o `SETUP.md` de novo e aplique as
migrações dos documentos do projeto que o relatório identificar.

In English: [CHANGELOG.md](CHANGELOG.md).

## 2026.10.18

- A base da revisão de um milestone é o commit da revisão do milestone
  anterior, ou o primeiro commit num primeiro milestone. O intervalo
  passa a conter as correções dos achados da revisão anterior, que não
  têm segunda revisão. No repositório do livro, a primeira linha do
  milestone seguinte começou antes de fecharem os achados do anterior, e
  a sua base não era nenhum dos dois commits que o docs/05 §8 nomeava.
- Os três rótulos do verificador têm cada um a sua explicação: visto é
  verdadeiro no arquivo hoje. O docs/05 §8 explicava só latente e fraco.
- Uma linha espera em quatro casos: o quarto é a leitura do código de uma
  revisão de milestone que deixou de fora parte do intervalo, e o motivo
  diz o que foi lido. O docs/05 §4 contava três casos enquanto o §8
  acrescentava este.
- Um slot Delivery review que lê `git diff` também lê os arquivos que a
  entrega criou, que nenhum diff mostra antes de irem para o stage. Um
  script novo no repositório do livro estava fora do controle do git
  quando a revisão da sua entrega rodou.
- O `/apply` corrige o que quebra a página, o docs/04 ou o texto que a
  entrega escreveu: "as suas próprias linhas" se lia como linhas da fila.
  A pergunta do `/analyze` sobre a revisão de milestone aponta para o
  docs/05 §5, onde o slot está, e não para o §8.
- Uma nova execução relata essas mudanças como migrações do docs/05
  §§4, 5 e 8.

## 2026.10.17

- O `/apply` faz as mudanças da própria entrega serem revisadas antes de
  terminar, por um contexto que não as escreveu, como diz o novo slot
  Delivery review do docs/05 §5: a revisão do próprio host, como uma
  skill que o agente invoca ou um comando que ele roda, limitada aos
  caminhos da entrega, ou então um agente somente leitura lendo o diff
  deles. Ele corrige o que quebra a página, o docs/04 ou as suas próprias
  linhas e roda a verificação de novo; o resto vira uma linha `[ ]`. No
  repositório do livro, a revisão do milestone acrescentou 21 linhas de
  retrabalho, dez delas uma falha dentro de um arquivo do build, como um
  nome de arquivo que todas as verificações pulavam e um hook que deixava
  passar parte de uma mensagem de commit, cada uma esperando o fim do
  milestone em vez de ser corrigida na entrega que a escreveu. Nenhum
  host documenta uma revisão só das mudanças em stage, então o slot diz
  como a revisão do host fica nos caminhos da entrega enquanto outra
  sessão trabalha na mesma pasta.
- A leitura do código de um milestone é do próprio kit, em qualquer host
  que rode agentes, e não um comando de um host, e procura o que a
  revisão de nenhuma entrega podia ver: uma entrega contra outra, um
  documento contra outro. O docs/05 §8 lê
  `git diff <base>..HEAD` a partir do commit que fechou o milestone
  anterior, dividido nas áreas que o slot Milestone review nomeia, um
  agente somente leitura em cada uma, em paralelo onde o host roda
  agentes e uma sessão nova por área onde não roda. Cada leitor lista os
  caminhos que leu; quando eles deixam de fora parte do intervalo, a
  linha da revisão espera como `[?]`. Um verificador marca cada candidato
  como visto, latente ou fraco contra o seu arquivo antes de a pessoa
  vê-lo. No repositório do livro, o `/code-review ultra` do slot foi
  cancelado por custo e demora, uma revisão disparada com um commit solto
  leu só aquele commit e não o milestone, os agentes que os substituíram
  leram parte dos capítulos e ninguém viu até a revisão seguinte, e um
  candidato que não se sustentava só foi barrado porque cada um foi
  conferido no seu arquivo. A revisão na nuvem também recusa uma mudança
  maior que os seus limites de arquivos e linhas, e roda em um host só.
- O slot Milestone review nomeia as áreas e o modelo em que rodam os
  leitores e o verificador, ou o da sessão; `/analyze` e `/brainstorm`
  propõem os módulos do docs/01, e perguntam pela Delivery review. Uma
  nova execução propõe as áreas para
  um slot que nomeia um comando, e a pessoa diz se esse comando continua
  rodando.
- A revisão começa com a palavra da pessoa, porque custa; a sessão diz
  quando é a hora. O "no specialized subagent" do docs/05 §7 abre a sua
  única exceção para esses leitores e o seu verificador, que no
  repositório do livro acharam um nome de arquivo que todas as
  verificações, a de divulgação incluída, pulavam sem aviso.
- O Windsurf agora é o Devin Desktop, cujo único agente, o Devin Local,
  substituiu o Cascade em setembro de 2026. Ele lê o `AGENTS.md` e as
  skills em `.agents/skills/`, e as invoca como `/<name>`; `@<name>` era
  do Cascade. O `SETUP.md` não escreve mais `.windsurf/skills/`, de que
  nenhum host precisa, e uma nova execução remove as cópias do próprio
  kit ali, para que o Devin Desktop, que ainda lê essa pasta, não ache
  uma cópia antiga de um comando ao lado da atual. Qualquer outro
  arquivo ali é reportado e fica. A tabela do `SETUP.md` §1 cita a
  documentação do Codex no seu novo endereço, sem outra mudança.

## 2026.10.16.2

- O kit não nomeia nenhuma ferramenta que o planta. A migração de uma
  nova execução para um slot Git de worktree que não nomeia pasta, num
  contêiner cuja pasta oculta já tem `repo.git/`, escreve o nome dessa
  pasta e o prefixo que as branches das entregas já usam, para nada mudar
  de lugar; sem contêiner, o slot continua valendo `.focus-kit/` e
  `focus-kit/`. A 2026.10.16.1 mandava o agente escrever no docs/05 de um
  projeto o nome da pasta de uma ferramenta que a pessoa não usava, e
  quem achava essa pasta não sabia de onde ela vinha. As entradas
  2026.10.15 e 2026.10.16.1 abaixo não a nomeiam mais.
- A 2026.10.16.1 saiu duas vezes, com `SETUP.md` diferente, então um
  repositório que diz 2026.10.16.1 não diz qual das duas tem. Rode o
  `SETUP.md` de novo; um número de versão não é reaproveitado.

## 2026.10.16.1

- A revisão de um marco volta a ler o código: a página dela nomeia o
  commit que fechou o marco anterior, e a pessoa dispara a revisão
  profunda que o novo slot Milestone review do docs/05 §5 nomeia, como o
  `/code-review ultra <base>` do Claude Code. Cada achado confirmado vira
  uma linha abaixo da revisão, sem segunda revisão. No Ninjobs uma
  revisão de todo o código achou uma chamada de 620 ms, uma página que podia ser
  enquadrada, o endereço do visitante enviado a terceiros e uma função
  alcançando a rede interna; testar cláusulas à mão não acha nenhum deles.
- A última coisa que o `/apply` diz é qual ambiente está em qual versão e
  o comando que atualiza os outros, e a Publish policy do docs/05 diz o
  mesmo. No Ninjobs uma pessoa abriu duas vezes um site publicado achando
  que estava em dia, depois de uma sessão que terminou sem dizer que não
  estava.
- O `/apply` volta a ler a fila inteira. Com a 2026.10.16 ele lia só as
  próprias linhas, então não via se as linhas que o seu `after` nomeia
  estavam prontas, nem conseguia nomear a próxima linha. As linhas da
  fila continuam com uma frase, e é isso que mantém a leitura pequena.
- Uma mudança pedida fora do `/apply` vira uma linha `[ ]`, com um
  rascunho `work/<slug>.md` para o que a linha não comporta, e a resposta
  termina nomeando `/propose <slug>` para uma sessão nova. Isso substitui
  o "continuar como `/propose` na mesma sessão" da 2026.10.16: aquela
  sessão rodava sem a skill propose, que nenhum host deixa o agente
  invocar sozinho, e um pedido não definido agora não tinha onde guardar
  o detalhe. A regra do `AGENTS.md`, que ainda dizia que a resposta para
  na linha, agora diz o mesmo.
- A seção Contract da página volta a dizer por que precisa ser exata:
  uma tela errada se corrige numa sessão, uma coluna errada é uma
  migration, e uma regra de acesso errada já vazou. O processo do Ninjobs
  dizia isso, e o kit guardou a regra sem o motivo que faz um agente
  levá-la a sério.
- Menores: o `/analyze` cria `work/done/.gitkeep` como o `/brainstorm`; o
  `/brainstorm` pergunta pelos manuais e pela revisão do marco junto com
  os outros slots, e o `/analyze` pergunta pela revisão do marco; "no gate before implementation" passa a dizer "beyond
  a complete page", que o kit de fato exige; a estratégia trunk não diz
  mais que o Ninjobs fazia stage por sessão, o que ele nunca fez.
  Encontrados por uma revisão do kit inteiro em 2026-10-16.
- Uma marca muda na hora: `[~]` é a primeira coisa que o `/propose`
  escreve, `[*]` a primeira que o `/apply` escreve e `[x]` a última,
  depois do stage. Num projeto a fila alimentava um board no Azure DevOps
  ou no GitHub Projects de onde as pessoas puxavam trabalho, e escolher o
  que puxar exige que o board mostre na hora o que já foi pego. Sem board, as
  marcas não custam nada.
- As regras de retomada do docs/05 §4 e de commit do §6 ficaram mais
  curtas: `resume:` é uma frase, a recuperação de linhas bloqueadas
  antigas e a mudança de uma entrega bloqueada na trunk para branch
  própria saíram, a reconciliação de worktrees é uma frase e a posse vira
  "o que esta entrega não mudou não é dela". A regra das duas sessões e o
  "nunca `git add -A`" ficam inteiros. A 2026.10.16 cortou uma leitura de
  180KB antes da primeira edição; o documento de processo faz parte dela.
- Uma worktree por entrega, quando escolhida, usa por padrão a pasta
  oculta `.focus-kit/` e o prefixo de branch `focus-kit/`, que dizem o que
  os criou; o padrão anterior não dizia nada a quem o encontrava.
- Migração: o relatório de uma nova execução confere o docs/05 §§2, 3, 4,
  6, 7 e 8, o slot Milestone review, a última frase da Publish policy e a
  linha do `AGENTS.md` sobre uma mudança pedida fora do `/apply`. Um slot
  Git de worktree que não nomeia pasta, num repositório cujo container já
  usa o padrão anterior, recebe esse padrão por escrito, para nada mudar
  de lugar.

## 2026.10.16

- `/apply` lê no docs/06 só as linhas que nomeiam seu slug e o cabeçalho
  do marco delas, não a fila inteira. Uma linha da fila é a marca, o
  slug, uma frase e os sufixos; o que aconteceu vai para a página. Um
  slot do docs/05 §5 diz o quê e o comando em poucas linhas; os passos
  vão para um manual e o que um comando imprime fica no help dele. Num
  projeto, cada `/apply` lia uns 180KB de documentos antes da primeira
  edição: uma fila de 80KB com linhas de até 4,7KB, e um documento de
  processo cujo slot de ambientes tinha umas 120 linhas.
- Uma mudança pedida fora do `/propose` continua virando uma linha
  `[ ]`, mas quando a pessoa quer defini-la agora a conversa segue como
  `/propose <slug>` na mesma sessão e o que foi dito vira a página. As
  linhas de pedido daquele projeto chegaram a 4,7KB porque o detalhe de
  um pedido não tinha outro lugar além da linha.
- Um manual em docs/manuals/ também guarda uma prova que o `/apply` roda
  em outra máquina, não só o que uma pessoa faz à mão: os passos de prova
  daquele projeto não tinham outro lugar além do slot.
- Migração: o relatório de uma nova rodada lista as linhas da fila que
  carregam histórico e os slots que narram passos ou saída, com a
  redação mais curta.

## 2026.10.15

- A worktree por entrega passa a ter uma forma só, a mesma para toda
  ferramenta e toda pessoa: o checkout é o `main/` de uma pasta contêiner,
  o repositório bare mora numa pasta oculta dela, e a worktree de cada
  entrega mora em `<oculta>/worktrees/<slug>/`, na branch
  `<prefixo>/<slug>`. O slot Git do docs/05 pode nomear a pasta oculta e o
  prefixo; um slot que não nomeia nenhum dos dois vale um padrão do kit.
  O `/propose` cria a worktree ali, ou reaproveita a que existe, e uma
  branch `<slug>` sem o prefixo não é a da entrega. Um `/propose` rodando
  em segundo plano entrou numa worktree que o host dele criou por conta
  própria, na pasta do host, e a pessoa copiou a página para a branch
  principal à mão: nada dizia onde fica a worktree de uma entrega.
- Sem migração: um docs/05 cujo slot Git não nomeia pasta oculta nem
  prefixo já vale o padrão.

## 2026.10.13

- O que uma pessoa faz à mão fora de uma entrega (publicar o site, voltar
  uma versão, trocar um segredo, configurar um serviço) ganha um manual em
  `docs/manuals/`, um arquivo para cada coisa, com o nome do que ele faz e
  legível sozinho: o que faz e quando, o que precisa estar pronto antes,
  os comandos em ordem, como saber que deu certo, como desfazer. O
  docs/05 §5 ganha o slot Manuals, que diz isso e os lista, e um slot que
  cita um comando desses aponta para o manual em vez de guardar os passos.
  O `/analyze` escreve os manuais do que o repositório já roda à mão; o
  `/apply` escreve ou atualiza um quando uma entrega cria ou muda isso; o
  `AGENTS.md` aponta para a pasta. Uma pessoa foi republicar o site de um
  projeto e não achou instruções: os passos existiam, mas como subitem do
  slot Environments do docs/05 §5, escritos para o agente, onde quem
  procura como publicar não olha.
- Migração: o slot Manuals no docs/05 §5; cada procedimento escrito só
  dentro de um slot ou de outro documento vira um manual em
  `docs/manuals/`, e o slot fica com o comando e aponta para ele; a linha
  de `docs/manuals/` no Read before acting do AGENTS.md.

## 2026.10.08.3

- Duas sessões na mesma pasta de trabalho, em linhas livres que tocam
  arquivos diferentes, passam a ser o caso normal de trabalho paralelo na
  trunk, no docs/05 §§4 e 6 e na escolha de git. Outra linha mudando de
  marca, arquivos de outra entrega na pasta e entradas de outra sessão no
  índice são trabalho daquela sessão, não conflito; conflito é o mesmo
  trecho editado pelas duas, ou um arquivo de que a página precisa e que
  a outra entrega está mudando. Um usuário rodou duas sessões do Codex no
  mesmo repositório, em módulos diferentes; a segunda parou porque a
  primeira tinha mudado o docs/06, quando tinha tudo o que precisava para
  seguir.
- As linhas da fila registram ordem e dependências: a ordem é a
  prioridade, a próxima entrega é a primeira linha livre, e uma linha que
  precisa de outra pronta antes termina com `· after <slug>`, uma ordem e
  não um bloqueio, livre quando aquela está `[x]`. Perguntada o que pode
  rodar ao mesmo tempo, uma sessão responde a partir da fila: as linhas
  livres que tocam arquivos diferentes, a julgar pelas suas páginas e pelo
  docs/01. A regra de que a ordem é a prioridade sempre valeu e não
  estava escrita em lugar nenhum, então um usuário pediu uma forma de
  ranquear entregas; e nada dizia quais linhas podiam rodar juntas, então
  a pessoa tinha que descobrir sozinha antes de abrir duas sessões. A
  mesma regra, uma linha num template que o agente preenche, é tudo o que
  o Spec Kit do GitHub tem para o seu marcador `[P]`.
- O `/propose` decide o que os documentos já respondem, escreve na página
  nomeando a fonte e pergunta só o que eles não respondem, a regra que o
  `/analyze` já tinha para o código. Um usuário mediu o kit contra o
  trabalho manual numa cópia do mesmo projeto e o achou bem mais lento, em
  parte porque o `/propose` perguntava o que o docs/00 a 05 já tinham
  decidido.
- Migração: docs/05 §4 e §6 e o slot de git do §5, num projeto que roda
  várias sessões; `· after <slug>` nas linhas da fila que dependem de
  outra, a critério da pessoa.

## 2026.10.08.2

- O `/apply` mostra a mensagem de commit sugerida também na conversa, no
  mesmo bloco `commit` que fecha a página, tanto quando a entrega fica
  pronta quanto quando para bloqueada com uma mensagem parcial. Desde
  2026.10.06 a mensagem mora na página, e o agente passou a sugeri-la na
  conversa como texto puro; num terminal ela perdeu o destaque que um
  bloco cercado dava e se misturou com o resto da resposta.

## 2026.10.08.1

- Todo comando escreve o próximo como o host o invoca. Antes, um usuário
  do Codex era orientado a rodar `/propose`, que o Codex não reconhece; o
  Codex invoca skills com `$`.
- O `/apply` termina com os próximos passos da pessoa, com os comandos por
  extenso: revisar o diff no stage, commitar (e fazer o merge, num branch
  de entrega) e então a próxima linha da fila. Antes, uma pessoa usando o
  kit pela primeira vez sabia que devia commitar, mas teve de procurar na
  documentação o que vinha depois. O `/propose` também mostra a linha da
  página na fila.
- O `AGENTS.md` responde "em que ponto estamos?" a partir do docs/06 e do
  `work/`, com o próximo comando. Não há comando de status: a fila já é o
  status. O `AGENTS.md` pertence ao projeto, então rodar o `SETUP.md` de
  novo reporta essa linha como migração.

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
