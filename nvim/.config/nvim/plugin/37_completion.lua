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
