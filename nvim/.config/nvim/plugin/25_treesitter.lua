local ensure_installed = {
  "bash",
  "fish",
  "nu",
  "c",
  "cpp",
  "css",
  "query",
  "diff",
  "editorconfig",
  "ini",
  "luadoc",
  "luap",
  "git_config",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "gitattributes",
  "go",
  "html",
  "javascript",
  "json",
  "jsonc",
  "lua",
  "markdown",
  "markdown_inline",
  "nix",
  "ron",
  "just",
  "slint",
  "python",
  "regex",
  "rust",
  "toml",
  "typescript",
  "tsx",
  "vim",
  "yaml",
  "zig",
  "odin",
  "typst",
  "elixir",
  "heex",
  "eex",
  "vimdoc",
  "xml",
}

require("nvim-treesitter").install(ensure_installed)

-- auto-start highlights & optional indentexpr
vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable treesitter highlighting and indent",
  callback = function(ctx)
    local ok = pcall(vim.treesitter.start)
    if not ok then
      return
    end

    local noIndent = {
      -- add filetypes
    }
    if not vim.list_contains(noIndent, ctx.match) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- register filetypes
local register = vim.treesitter.language.register

register("bash", "kitty")
register("ini", "ghostty")
register("markdown", "livebook")

-- Autotag
require("nvim-ts-autotag").setup({})
