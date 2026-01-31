-- Diagnostics
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
})

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "[G]oto [D]efinition" })
    vim.keymap.set("n", "grd", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "[G]oto [D]eclaration" })

    vim.keymap.set("n", "grr", function()
      require("mini.extra").pickers.lsp({ scope = "references" })
    end, { buffer = ev.buf, desc = "[G]oto [R]eferences" })

    vim.keymap.set("n", "gri", function()
      require("mini.extra").pickers.lsp({ scope = "implementation" })
    end, { buffer = ev.buf, desc = "[G]oto [I]mplementation" })

    vim.keymap.set("n", "grt", function()
      require("mini.extra").pickers.lsp({ scope = "type_definition" })
    end, { buffer = ev.buf, desc = "[G]oto [T]ype Definition" })
  end,
})

-- Custom LSP configurations
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})

vim.lsp.config("tinymist", {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  settings = {
    formatterMode = "typstyle",
    exportPdf = "onType",
    semanticTokens = "disable",
  },
})

vim.lsp.config("harper_ls", {
  filetypes = { "markdown", "typst", "gitcommit", "html" },
})

-- Enable servers
vim.lsp.enable({
  "lua_ls",
  "yamlls",
  "basedpyright",
  "bashls",
  "nil_ls",
  "elixirls",
  "ols",
  "tinymist",
  "gopls",
  "rust_analyzer",
  "zls",
  "jsonls",
  "slint_lsp",
  "clangd",
  "harper_ls",
})
