# My Neovim Config

Config pessoal de Neovim em Lua, modularizada em `lua/ramon`, com foco em produtividade, LSP, busca rápida, Git e suporte multi-linguagem.

Esta documentação foi atualizada com base no comportamento real da configuração.

## Visão geral

Hoje sua config entrega:

- gerenciamento de plugins com `lazy.nvim`
- dashboard inicial com `alpha-nvim`
- tema `ayu` (variante `mirage`)
- statusline com `lualine`
- tabs com `bufferline`
- explorer com `nvim-tree`
- busca e navegação com `telescope`
- LSP com `nvim-lspconfig` + `mason.nvim`
- autocompletion com `nvim-cmp` + `LuaSnip`
- syntax highlighting e textobjects via `nvim-treesitter`
- formatação com `conform.nvim`
- lint com `nvim-lint`
- terminal embutido com `toggleterm`
- Git com `gitsigns` e `lazygit.nvim`
- sessões com `auto-session`
- comentários, surround, substitute, autopairs, which-key, todo-comments, dressing e Copilot

## Estrutura

```text
init.lua
lua/ramon/core/
  init.lua
  keymaps.lua
  options.lua
lua/ramon/plugins/
  init.lua
  alpha.lua
  autopairs.lua
  auto-session.lua
  bufferline.lua
  colorscheme.lua
  comment.lua
  dressing.lua
  formatting.lua
  gitsigns.lua
  indent-blankline.lua
  java.lua
  java.lu          # arquivo legado/comentado
  lazygit.lua
  linting.lua
  lualine.lua
  nvim-cmp.lua
  nvim-tree.lua
  substitute.lua
  surround.lua
  telescope.lua
  todo-comments.lua
  toggleterm.lua
  treesitter.lua
  trouble.lua
  which-key.lua
lua/ramon/plugins/lsp/
  lspconfig.lua
  mason.lua
```

## Dependências do sistema

Base recomendada para Linux:

```bash
neovim git ripgrep xclip lazygit gcc g++ make node npm python go
```

Para Java:

```bash
java 21+
```

Observações:

- `ripgrep` é obrigatório para o `Telescope live_grep`.
- `xclip` ou equivalente é necessário para clipboard do sistema.
- `node` e `npm` são usados por vários servidores e ferramentas JS/TS.
- `go` é usado pelo `gofmt` e por alguns pacotes instalados pelo Mason.
- Java no momento depende de `Java 21+` para o `jdtls` funcionar.

## Plugins e funcionalidades

### Core

- `vim-tmux-navigator`: navegação entre splits do Neovim e panes do tmux com `Ctrl + h/j/k/l`
- `copilot.vim`: sugestões de IA inline

### UI

- `alpha-nvim`: dashboard inicial com atalhos para novo arquivo, explorer, Telescope e restore de sessão
- `neovim-ayu`: tema principal
- `lualine.nvim`: statusline customizada
- `bufferline.nvim`: tabs em modo "tabs"
- `which-key.nvim`: popup de atalhos
- `dressing.nvim`: melhora `vim.ui.select` e `vim.ui.input`
- `indent-blankline.nvim`: guias de indentação

### Navegação e arquivos

- `nvim-tree.lua`: explorer lateral
- `telescope.nvim`: busca de arquivos, grep, arquivos recentes e referências LSP
- `auto-session`: salvar/restaurar sessão por diretório
- `toggleterm.nvim`: terminal embutido

### Edição

- `nvim-autopairs`: fechamento automático de pares
- `Comment.nvim`: comentários inteligentes, incluindo JSX/TSX/Svelte/HTML via Treesitter
- `nvim-surround`: manipulação de pares e delimitadores
- `substitute.nvim`: substituição com motion/linha/visual

### Código

- `nvim-lspconfig`: LSP
- `mason.nvim`: instalação de servidores e ferramentas
- `nvim-cmp`: autocomplete
- `LuaSnip` + `friendly-snippets`: snippets
- `nvim-treesitter`: parser e highlighting por árvore sintática
- `conform.nvim`: formatação
- `nvim-lint`: lint
- `trouble.nvim`: diagnósticos, quickfix, location list e TODOs
- `todo-comments.nvim`: destaque de `TODO`, `FIX`, `HACK`, etc.

### Git

- `gitsigns.nvim`: hunk signs, stage/reset/preview/blame/diff
- `lazygit.nvim`: interface do LazyGit dentro do Neovim

## Keymaps

Leader: `Space`

### Gerais

| Atalho | Ação |
| --- | --- |
| `<leader>nh` | limpar highlights da busca |
| `<C-a>` | selecionar tudo |
| `<C-y>` | copiar seleção para clipboard |

### Splits e tabs

| Atalho | Ação |
| --- | --- |
| `<leader>sv` | split vertical |
| `<leader>sh` | split horizontal |
| `<leader>se` | equalizar splits |
| `<leader>sx` | fechar split atual |
| `<leader>to` | abrir nova tab |
| `<leader>tx` | fechar tab atual |
| `<leader>tn` | próxima tab |
| `<leader>tp` | tab anterior |
| `<leader>tf` | abrir buffer atual em nova tab |

### Tmux

| Atalho | Ação |
| --- | --- |
| `<C-h>` | navegar para a janela/pane à esquerda |
| `<C-j>` | navegar para baixo |
| `<C-k>` | navegar para cima |
| `<C-l>` | navegar para a direita |

### Explorer (`nvim-tree`)

| Atalho | Ação |
| --- | --- |
| `<leader>ee` | alternar explorer |
| `<leader>ef` | abrir explorer focado no arquivo atual |
| `<leader>ec` | colapsar árvore |
| `<leader>er` | atualizar explorer |

### Telescope

| Atalho | Ação |
| --- | --- |
| `<leader>ff` | buscar arquivos |
| `<leader>fr` | arquivos recentes |
| `<leader>fs` | live grep |
| `<leader>fc` | buscar string sob o cursor |
| `<C-j>` | próximo item no Telescope |
| `<C-k>` | item anterior no Telescope |
| `<C-q>` | enviar seleção para quickfix |

### Sessões

| Atalho | Ação |
| --- | --- |
| `<leader>ws` | salvar sessão do diretório atual |
| `<leader>wr` | restaurar sessão do diretório atual |

### Terminal

| Atalho | Ação |
| --- | --- |
| `<C-\>` | abrir/fechar terminal horizontal |
| `<C-t>` | sair do modo terminal para o normal |

### Formatação e lint

| Atalho | Ação |
| --- | --- |
| `<leader>mp` | formatar arquivo ou seleção |
| `<leader>l` | rodar lint manualmente |

### LSP

| Atalho | Ação |
| --- | --- |
| `gd` | ir para definições |
| `gD` | ir para declaração |
| `gR` | listar referências |
| `gi` | listar implementações |
| `gt` | listar definições de tipo |
| `K` | hover/documentação |
| `<leader>ca` | code actions |
| `<leader>rn` | renomear símbolo |
| `<leader>D` | diagnósticos do buffer |
| `<leader>d` | diagnóstico da linha |
| `[d` | diagnóstico anterior |
| `]d` | próximo diagnóstico |
| `<leader>rs` | reiniciar LSP |

### Trouble

| Atalho | Ação |
| --- | --- |
| `<leader>xw` | diagnósticos do workspace |
| `<leader>xd` | diagnósticos do documento |
| `<leader>xq` | quickfix |
| `<leader>xl` | location list |
| `<leader>xt` | TODOs/notes |

### Git

| Atalho | Ação |
| --- | --- |
| `<leader>lg` | abrir LazyGit |
| `]h` | próximo hunk |
| `[h` | hunk anterior |
| `<leader>hs` | stage hunk |
| `<leader>hr` | reset hunk |
| `<leader>hS` | stage buffer |
| `<leader>hR` | reset buffer |
| `<leader>hu` | undo stage hunk |
| `<leader>hp` | preview hunk |
| `<leader>hb` | blame da linha |
| `<leader>hB` | alternar blame inline |
| `<leader>hd` | diff atual |
| `<leader>hD` | diff contra `~` |
| `ih` | textobject do hunk |

### Substituição

| Atalho | Ação |
| --- | --- |
| `s` | substituir com motion |
| `ss` | substituir linha |
| `S` | substituir até o fim da linha |
| `s` em visual | substituir seleção |

### Comentários e surround

Esses plugins usam atalhos padrão:

- `Comment.nvim`: `gcc`, `gc`, textobjects visuais, etc.
- `nvim-surround`: `ys`, `cs`, `ds`, etc.

### Treesitter

| Atalho | Ação |
| --- | --- |
| `<C-Space>` | expandir seleção incremental |
| `<BS>` | reduzir seleção incremental |

## Linguagens suportadas

### Treesitter parsers configurados

- `json`
- `java`
- `javascript`
- `typescript`
- `tsx`
- `yaml`
- `python`
- `html`
- `css`
- `markdown`
- `markdown_inline`
- `svelte`
- `graphql`
- `bash`
- `lua`
- `vim`
- `dockerfile`
- `gitignore`
- `query`
- `vimdoc`
- `c`
- `cpp`
- `kotlin`
- `agda`
- `go`
- `haskell`
- `sql`

### LSP configurado

| Linguagem | Servidor |
| --- | --- |
| Bash / Shell | `bashls` |
| C / C++ | `clangd` |
| CSS | `cssls` |
| Dockerfile | `dockerls` |
| Go | `gopls` |
| GraphQL | `graphql` |
| Groovy | `groovyls` |
| HTML | `html` |
| JSON | `jsonls` |
| Kotlin | `kotlin_language_server` |
| Lua | `lua_ls` |
| Markdown / texto | `ltex` |
| Python | `pyright` |
| SQL | `sqls` |
| Svelte | `svelte` |
| TypeScript / JavaScript | `ts_ls` |
| Tailwind | `tailwindcss` |
| YAML | `yamlls` |
| Java | `nvim-jdtls` + `jdtls` |

### Formatadores configurados

| Linguagem | Ferramenta |
| --- | --- |
| Bash / Sh / Zsh | `shfmt` |
| C / C++ | `clang-format` |
| CSS / HTML / JSON / YAML / Markdown / GraphQL / Liquid | `prettier` |
| JavaScript / TypeScript / React / Svelte | `prettier` |
| Lua | `stylua` |
| Python | `isort` + `black` |
| Java | `google-java-format` |
| Go | `gofmt` |

### Linters configurados

| Linguagem | Ferramenta |
| --- | --- |
| Bash / Sh | `shellcheck` |
| JavaScript / TypeScript / React / Svelte | `eslint_d` |
| Python | `pylint` |
| Java | `checkstyle` |

## O que foi corrigido

Nesta revisão, foram feitos os seguintes ajustes:

- `conform.nvim` foi reativado e integrado à config
- `Treesitter` passou a usar `auto_install = true`
- LSP para `TypeScript/JavaScript` foi adicionado com `ts_ls`
- LSP para `Svelte`, `YAML`, `Kotlin` e `SQL` foi adicionado
- formatadores para `C/C++`, `Shell`, `Java` e `Go` foram adicionados
- linters para `Shell` e `Java` foram adicionados
- `mason-lspconfig` deixou de autoativar servidores por trás, evitando conflito com `jdtls`
- Java foi separado para uma configuração dedicada em `lua/ramon/plugins/java.lua`
- Java agora avisa explicitamente quando falta `Java 21+`
- o `README` foi atualizado para refletir a config real

## Estado atual das linguagens

Validado em modo headless:

- `C`: `clangd` sobe corretamente
- `TypeScript`: `ts_ls` sobe corretamente
- `YAML`: `yamlls` sobe corretamente
- `Java`: a configuração está pronta, mas o servidor não sobe no seu ambiente atual porque o runtime disponível é `Java 18`, e o `jdtls` atual exige `Java 21+`

## Java: o que falta para funcionar

Hoje o bloqueio do Java não está mais na config do Neovim. Está no runtime do sistema.

Seu ambiente atual:

- `java -version` retorna `Java 18`
- o `jdtls` instalado pelo Mason exige `Java 21+`

Para ativar Java, você precisa de uma destas opções:

1. Instalar Java 21 e deixar ele como padrão do sistema.
2. Instalar Java 21 e apontar só o `jdtls` para ele com `JDTLS_JAVA_HOME`.

Exemplo:

```bash
export JDTLS_JAVA_HOME=/caminho/do/java-21
```

ou

```bash
export JAVA_HOME=/caminho/do/java-21
```

Depois disso, abra um arquivo `.java` novamente.

## C/C++: observação importante

O `clangd` está funcionando, mas para projetos reais ele fica muito melhor quando você fornece dados de build.

Recomendado para C/C++:

- gerar `compile_commands.json`
- ou criar um `compile_flags.txt`
- garantir que `gcc/g++` ou `clang/clang++` estejam instalados

Se você usa CMake:

```bash
cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
ln -sf build/compile_commands.json ./compile_commands.json
```

Sem isso, o `clangd` até sobe, mas pode falhar em includes padrão, flags e análise mais precisa do projeto.

## Como adicionar uma nova linguagem

Sempre siga esta ordem:

1. Adicione o parser em `lua/ramon/plugins/treesitter.lua`.
2. Adicione o servidor LSP em `lua/ramon/plugins/lsp/lspconfig.lua`.
3. Adicione o pacote do Mason em `lua/ramon/plugins/lsp/mason.lua` se houver ferramenta externa.
4. Adicione o formatter em `lua/ramon/plugins/formatting.lua`.
5. Adicione o linter em `lua/ramon/plugins/linting.lua`.
6. Se a linguagem tiver particularidades grandes, crie um arquivo próprio em `lua/ramon/plugins/<linguagem>.lua`, como foi feito com Java.

Exemplo mental:

- syntax highlight: `treesitter.lua`
- inteligência de código: `lspconfig.lua`
- instalação de binários: `mason.lua`
- formatação: `formatting.lua`
- lint: `linting.lua`

## Troubleshooting rápido

### Telescope não acha texto

Instale `ripgrep`.

### Clipboard não funciona

Instale `xclip` ou outro provider equivalente.

### Java não sobe

Instale `Java 21+` e configure `JDTLS_JAVA_HOME` ou `JAVA_HOME`.

### C/C++ reconhece mal includes

Gere `compile_commands.json` ou `compile_flags.txt`.

### Algum servidor não sobe

Abra:

```vim
:Mason
:LspInfo
:checkhealth
```

## Instalação

```bash
git clone https://github.com/RamonJales/my-nvim-config.git ~/.config/nvim
nvim
```

## Desinstalação

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```
