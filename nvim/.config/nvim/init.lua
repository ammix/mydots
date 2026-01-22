local gh = function(x) return 'https://github.com/' .. x end
local cb = function(x) return 'https://codeberg.org/' .. x end

vim.pack.add({
  gh("catppuccin/nvim"),
  gh("nvim-mini/mini.nvim"),
  { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
  gh("rafamadriz/friendly-snippets"),
  { src = gh("saghen/blink.compat"), optional = true },
  gh("nvim-treesitter/nvim-treesitter"),
  gh("neovim/nvim-lspconfig"),
  gh("stevearc/conform.nvim"),
  gh("mfussenegger/nvim-lint"),
  gh("windwp/nvim-ts-autotag"),
  gh("folke/lazydev.nvim"),
  gh("Saecki/crates.nvim"),
  gh("folke/trouble.nvim"),
  gh("chomosuke/typst-preview.nvim"),
  cb("andyg/leap.nvim"),
})
