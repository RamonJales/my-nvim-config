return {
	--Mason.nvim is used to install and manage all of the language servers that you need for the languages you work for.

	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				"eslint_d", -- javascript/typescript linter
				"google-java-format", -- java formatter
				"checkstyle", -- java linter
				"clang-format", -- c/cpp formatter
				"shfmt", -- shell formatter
				"shellcheck", -- shell linter
				"java-debug-adapter", -- java debug support
				"java-test", -- java test support
			},
		})
	end,
}
