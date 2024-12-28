return {
	{
		"akinsho/toggleterm.nvim", -- Repositório do ToggleTerm
		config = function()
			require("toggleterm").setup({
				size = 20, -- Tamanho do terminal, pode ajustar conforme necessário
				open_mapping = [[<C-j>]], -- Atalho para abrir o terminal (Ctrl + j)
				direction = "horizontal", -- Pode ser 'horizontal', 'vertical' ou 'float'
				shade_filetypes = {},
				shade_terminals = true, -- Ativa a sombra no terminal
				shading_factor = 2, -- Ajusta a intensidade da sombra
				persist_size = true, -- Mantém o tamanho do terminal entre sessões
				start_in_insert = true, -- Começa no modo de inserção quando o terminal é aberto
				insert_mappings = true, -- Ativa mapeamentos personalizados no modo de inserção
				terminal_mappings = true, -- Ativa mapeamentos personalizados no terminal
				shell = vim.o.shell, -- Usa o shell configurado no Neovim
			})

			-- Exemplo de mapeamento de teclas dentro do terminal (opcional)

			-- Mapeamento para terminal geral
			vim.api.nvim_set_keymap("t", "<C-t>", [[<C-\><C-n>]], { noremap = true, silent = true })
		end,
	},
}
