# AGENTS.md

Guia para agentes de IA (Claude Code, Codex, etc.) trabalharem neste repositório: uma configuração pessoal do Neovim em Lua.

> Este arquivo é a fonte única de contexto para IAs. `CLAUDE.md` apenas importa este arquivo — não duplique conteúdo nele. Para documentação voltada ao usuário final (tabelas completas de plugins, keymaps e troubleshooting), veja [README.md](README.md).

## O que é este repositório

Config pessoal de Neovim (`~/.config/nvim`), gerenciada com `lazy.nvim`, modularizada em `lua/ramon/`. Não é uma biblioteca nem uma aplicação — não há build, testes automatizados nem pipeline de CI. "Rodar" o projeto é abrir o Neovim.

## Arquitetura (big picture)

Ordem de carregamento a partir de `init.lua`:

1. `init.lua` → `require("ramon.core")` → `require("ramon.core.options")` (opções globais do Vim) + `require("ramon.core.keymaps")` (keymaps que não pertencem a nenhum plugin específico)
2. `init.lua` → `require("ramon.lazy")` → faz bootstrap do `lazy.nvim` e chama `require("lazy").setup(...)` importando duas pastas inteiras:
   - `{ import = "ramon.plugins" }`
   - `{ import = "ramon.plugins.lsp" }`

Isso significa que **qualquer arquivo `.lua` novo dentro de `lua/ramon/plugins/` ou `lua/ramon/plugins/lsp/` é carregado automaticamente pelo lazy.nvim** — não é preciso registrar o arquivo em nenhum lugar central, basta ele existir e retornar uma spec válida.

Convenção: 1 arquivo = 1 plugin (ou um pequeno grupo de plugins relacionados, ex: `lsp/mason.lua` + `lsp/lspconfig.lua` formam juntos o "stack" de LSP). Quando uma linguagem tem particularidades grandes (ex: Java), ela ganha um arquivo dedicado em vez de inflar `lspconfig.lua`.

### Onde mexer para cada tipo de mudança

| Quero... | Edito |
| --- | --- |
| Opção global do Vim (`opt.*`) | `lua/ramon/core/options.lua` |
| Keymap genérico (não de plugin) | `lua/ramon/core/keymaps.lua` |
| Adicionar/configurar um plugin | novo arquivo em `lua/ramon/plugins/<nome>.lua` |
| Servidor de LSP | `lua/ramon/plugins/lsp/lspconfig.lua` (setup) + `lua/ramon/plugins/lsp/mason.lua` (instalação do binário) |
| Parser de syntax highlighting | `lua/ramon/plugins/treesitter.lua` |
| Formatter | `lua/ramon/plugins/formatting.lua` (conform.nvim) |
| Linter | `lua/ramon/plugins/linting.lua` (nvim-lint) |

### Fluxo para adicionar suporte a uma nova linguagem

Sempre nesta ordem (também documentado no README.md):

1. Parser em `treesitter.lua` (`ensure_installed`)
2. Servidor LSP em `lsp/lspconfig.lua`: adicionar à lista `ensure_installed` do `mason_lspconfig.setup`, ao loop de `setup_server(...)` e, se precisar de opções específicas, uma chamada dedicada `setup_server("nome", { ... })`
3. Pacote do Mason em `lsp/mason.lua` (`mason_tool_installer.ensure_installed`) se houver ferramenta externa (linter/formatter) a instalar
4. Formatter em `formatting.lua` (`formatters_by_ft`)
5. Linter em `linting.lua` (`linters_by_ft`)
6. Se a linguagem tiver particularidades grandes (setup de DAP, autocmds próprios etc.), criar `lua/ramon/plugins/<linguagem>.lua` dedicado — veja o padrão em `java.lua`

## Comandos úteis (dentro do Neovim)

Não há build/lint/test tradicionais — não é um projeto de software, é uma config. A validação é feita interativamente dentro do próprio Neovim:

- `:Lazy` — UI do gerenciador de plugins (sync, update, clean, árvore de dependências, profile de startup)
- `:Lazy sync` — instala/atualiza/remove plugins conforme a spec atual do código
- `:Mason` — instala/gerencia LSP servers, formatters e linters
- `:LspInfo` / `<leader>rs` (`:LspRestart`) — inspecionar/reiniciar o LSP do buffer atual
- `:checkhealth` — diagnóstico geral (providers, clipboard, treesitter etc.)
- `:TSUpdate` — atualiza os parsers do treesitter

Para validar uma mudança sem depender de UI interativa, dá para rodar o Neovim em modo headless (ex.: abrir um arquivo do filetype alterado com `nvim --headless` e checar mensagens/`:LspInfo`).

## Convenções e cuidados

- **Indentação não é uniforme entre arquivos**: alguns usam tab (`core/keymaps.lua`, `lazy.lua`, `plugins/init.lua`, `lsp/mason.lua`, `linting.lua`, `alpha.lua`, `colorscheme.lua`), outros usam 2 espaços (`treesitter.lua`, `formatting.lua`, `csvview.lua`). Ao editar um arquivo existente, siga a indentação já usada nele — não reformate o arquivo inteiro de passagem.
- **`lazy-lock.json` está no `.gitignore`** — de propósito: as versões dos plugins não são fixadas/versionadas neste repositório.
- **`lua/ramon/plugins/java.lu`** (sem "a" no final) é um arquivo morto: cópia antiga/comentada da config de Java, mantida só como referência. O lazy.nvim só importa `*.lua`, então esse arquivo nunca é carregado — não confundir com `java.lua`, que é o ativo.
- **`init.vim.backup`** na raiz é a config legada em Vimscript, anterior à migração para Lua. Não é carregada por `init.lua`. Histórico, não ativo.
- **`char-imgs-for-dashboard/imgs.txt`** guarda variações de header ASCII art para o dashboard do `alpha-nvim`, como referência pessoal — não é lido pelo Neovim em nenhum ponto do código.
- Java requer runtime **Java 21+** para o `jdtls` subir (ver `README.md` → "Java: o que falta para funcionar" para o workaround via `JDTLS_JAVA_HOME`).

## Manter esta documentação atualizada

Sempre que você (IA) fizer uma alteração real neste repositório — adicionar/remover plugin, adicionar linguagem, mudar keymap, mudar estrutura de pastas — **atualize antes de encerrar a tarefa**:

1. Este arquivo (`AGENTS.md`), se a mudança afetar arquitetura, convenções ou o fluxo de "onde mexer".
2. `README.md`, se a mudança afetar algo que o usuário final vê (novo plugin, novo atalho, nova linguagem suportada, novo requisito de sistema).

Não é necessário editar `CLAUDE.md` — ele só importa este arquivo (`@AGENTS.md`), então qualquer atualização aqui já se reflete lá automaticamente.
