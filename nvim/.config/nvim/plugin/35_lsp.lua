-- LSP Config
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
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
    vim.keymap.set("n", "grd", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })

    vim.keymap.set("n", "grr", function()
      require("mini.extra").pickers.lsp({ scope = "references" })
    end, { desc = "[G]oto [R]eferences" })

    vim.keymap.set("n", "gri", function()
      require("mini.extra").pickers.lsp({ scope = "implementation" })
    end, { desc = "[G]oto [I]mplementation" })

    vim.keymap.set("n", "grt", function()
      require("mini.extra").pickers.lsp({ scope = "type_definition" })
    end, { desc = "[G]oto [T]ype Definition" })
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
  "harper_ls"
})

-- Conform
require("conform").setup({
  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua" },
    fish = { "fish_indent" },
    sh = { "shfmt" },
    python = { "ruff_fix", "ruff_format" },
    rust = { "rustfmt" },
    odin = { "odinfmt" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    vue = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    less = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    ["markdown.mdx"] = { "prettier" },
    graphql = { "prettier" },
    handlebars = { "prettier" },
  },
  formatters = {
    injected = { options = { ignore_errors = true } },
    prettier = {
      condition = function(_, ctx)
        return vim.fs.find(
          { ".prettierrc", ".prettierrc.json", ".prettierrc.js", "prettier.config.js", "package.json" },
          { path = ctx.filename, upward = true }
        )[1] ~= nil
      end,
    },
  },
})

-- Lint
local lint = require("lint")
lint.linters_by_ft = lint.linters_by_ft or {}
lint.linters_by_ft["markdown"] = nil
lint.linters_by_ft["text"] = nil

-- Create autocommand which carries out the actual linting
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    if vim.bo.modifiable then
      lint.try_lint()
    end
  end,
})

-- Lazydev
require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

-- Blink
require("blink.cmp").setup({
  keymap = { preset = "default" },
  signature = { enabled = true },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
})

-- Crates
require("crates").setup({
  completion = {
    crates = {
      enabled = true,
    },
  },
  lsp = {
    enabled = true,
    actions = true,
    completion = true,
    hover = true,
  },
})

-- Trouble
require("trouble").setup({})
