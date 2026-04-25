return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = {
			Error = " ",
			Warn = " ",
			Hint = "󰠠 ",
			Info = " ",
		}

		if vim.diagnostic.config ~= nil then
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = signs.Error,
						[vim.diagnostic.severity.WARN] = signs.Warn,
						[vim.diagnostic.severity.HINT] = signs.Hint,
						[vim.diagnostic.severity.INFO] = signs.Info,
					},
				},
			})
		else
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
		end

		local function setup_server(server_name, server_opts)
			local opts = vim.tbl_deep_extend("force", {
				capabilities = capabilities,
			}, server_opts or {})

			if vim.lsp.config and vim.lsp.enable then
				vim.lsp.config(server_name, opts)
				vim.lsp.enable(server_name)
				return
			end

			lspconfig[server_name].setup(opts)
		end

		local function get_gxx_fallback_flags()
			local flags = { "--driver-mode=g++" }

			if vim.fn.executable("g++") ~= 1 then
				return flags
			end

			local output = vim.fn.system("g++ -E -x c++ - -v < /dev/null 2>&1")
			local collect = false

			for line in output:gmatch("[^\r\n]+") do
				if line:find("#include <%.%.%.> search starts here:", 1, false) then
					collect = true
				elseif line:find("End of search list%.", 1, false) then
					break
				elseif collect then
					local path = line:match("^%s*(/.-)%s*$")
					if path and vim.fn.isdirectory(path) == 1 then
						table.insert(flags, "-isystem")
						table.insert(flags, path)
					end
				end
			end

			return flags
		end

		local ensure_installed = {
			"html",
			"cssls",
			"tailwindcss",
			"lua_ls",
			"pyright",
			"ts_ls",
			"svelte",
			"clangd",
			"bashls",
			"dockerls",
			"gopls",
			"jsonls",
			"yamlls",
			"graphql",
			"eslint",
			"groovyls",
			"kotlin_language_server",
			"ltex",
			"sqls",
		}

		mason_lspconfig.setup({
			ensure_installed = ensure_installed,
			automatic_enable = false,
		})

		for _, server_name in ipairs({
			"html",
			"cssls",
			"tailwindcss",
			"pyright",
			"ts_ls",
			"svelte",
			"bashls",
			"dockerls",
			"jsonls",
			"yamlls",
			"graphql",
			"eslint",
			"groovyls",
			"kotlin_language_server",
			"sqls",
		}) do
			setup_server(server_name)
		end

		setup_server("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--fallback-style=llvm",
				"--query-driver=/usr/bin/c++,/usr/bin/**/clang-*,/usr/bin/**/g++-*,/usr/bin/g++,/usr/bin/gcc,/usr/bin/**/gcc-*",
			},
			init_options = {
				fallbackFlags = get_gxx_fallback_flags(),
			},
		})

		setup_server("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		setup_server("ltex", {
			settings = {
				ltex = {
					language = { "en", "pt-BR" },
					diagnosticSeverity = "information",
				},
			},
		})

		setup_server("gopls", {
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
				},
			},
		})
	end,
}
