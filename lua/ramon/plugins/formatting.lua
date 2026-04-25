return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        bash = { "shfmt" },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        java = { "google-java-format" },
        go = { "gofmt" },
      },
      formatters = {
        clang_format = {
          append_args = {
            "--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, ContinuationIndentWidth: 4, UseTab: Never}",
          },
        },
        prettier = {
          append_args = { "--tab-width", "4" },
        },
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
