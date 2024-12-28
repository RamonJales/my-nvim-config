return {
	{
		"Mofiqul/dracula.nvim", -- Nome do plugin Dracula
		priority = 1000, -- Certifique-se de carregar antes dos outros plugins
		config = function()
			require("dracula").setup({
				colors = {
					bg = "#282a36", -- Cor de fundo
					fg = "#f8f8f2", -- Cor do texto
					selection = "#44475a",
					comment = "#6272a4",
					red = "#ff5555",
					orange = "#ffb86c",
					yellow = "#f1fa8c",
					green = "#50fa7b",
					purple = "#bd93f9",
					cyan = "#8be9fd",
					pink = "#ff79c6",
					bright_red = "#ff6e6e",
					bright_green = "#69ff94",
					bright_yellow = "#ffffa5",
					bright_blue = "#d6acff",
					bright_magenta = "#ff92df",
					bright_cyan = "#a4ffff",
					bright_white = "#ffffff",
					menu = "#21222c",
					visual = "#3e4452",
					gutter_fg = "#4b5263",
					nontext = "#3b4048",
				},
				show_end_of_buffer = true, -- Mostrar "~" no final do buffer
				transparent_bg = false, -- Fundo transparente
				italic_comment = true, -- Comentários em itálico
			})
			-- Carrega o esquema de cores
			vim.cmd([[colorscheme dracula]])
		end,
	},
}
