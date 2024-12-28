return {
	{
		"Shatur/neovim-ayu", -- Nome do plugin Ayu
		priority = 1000, -- Certifique-se de carregar antes de outros plugins
		config = function()
			require("ayu").setup({
				mirage = true, -- Habilita o estilo "mirage" (mais suave)
				overrides = {
					Normal = { bg = "#0F1419", fg = "#B3B1AD" }, -- Exemplo de customização
					Comment = { fg = "#5C6773", italic = true }, -- Comentários em itálico
				},
			})
			-- Escolha o estilo do tema: 'dark', 'light' ou 'mirage'
			vim.o.background = "dark"
			vim.cmd("colorscheme ayu")
		end,
	},
}
