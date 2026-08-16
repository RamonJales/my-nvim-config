return {
  "hat0uma/csvview.nvim",
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    parser = { comments = { "#", "//" } },
    keymaps = {
      -- Text objects para selecionar campos
      textobject_field_inner = { "if", mode = { "o", "x" } },
      textobject_field_outer = { "af", mode = { "o", "x" } },
      
      -- Navegação estilo Excel:
      -- Usa <Tab> e <S-Tab> para mover horizontalmente entre os campos.
      -- Usa <Enter> e <S-Enter> para mover verticalmente entre as linhas.
      jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
      jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
      jump_next_row = { "<Enter>", mode = { "n", "v" } },
      jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
    },
  },
  -- O plugin só será carregado (lazy load) quando você usar um desses comandos
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },

  keys = {
    { "<leader>cv", "<cmd>CsvViewToggle<CR>", desc = "Toggle CSV View" },
  },
}