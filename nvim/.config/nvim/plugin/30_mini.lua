require("mini.extra").setup()
require("mini.ai").setup()
require("mini.align").setup()
require("mini.icons").setup()
require("mini.comment").setup()
require("mini.move").setup()
require("mini.cursorword").setup()
require("mini.trailspace").setup()
require("mini.cmdline").setup()
require("mini.pick").setup()

require('mini.notify').setup({
  window = {
    winblend = 100,
  }
})

require("mini.sessions").setup()

local starter = require("mini.starter")
starter.setup({
  header = "Welcome back",
  footer = "",
  items = {
    starter.sections.sessions(),
    -- starter.sections.recent_files(5, true, false),
    starter.sections.recent_files(5, false, false),
    starter.sections.builtin_actions(),
  },
})

require("mini.indentscope").setup({
  symbol = "│",
  options = { try_as_border = true },
})

require("mini.files").setup({
  mappings = {
    synchronize = "w",
    go_in_plus = "<CR>",
  },
})

require("mini.diff").setup({
  view = {
    style = "sign",
    signs = { add = "▎", change = "▎", delete = "" },
  },
})

require("mini.pairs").setup({
  modes = { insert = true, command = true, terminal = true },
  -- skip autopair when next character is one of these
  skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
  -- skip autopair when the cursor is inside these treesitter nodes
  skip_ts = { "string" },
  -- skip autopair when next character is closing pair
  -- and there are more closing pairs than opening pairs
  skip_unbalanced = true,
  -- better deal with markdown code blocks
  markdown = true,
})

require("mini.splitjoin").setup({
  mappings = {
    toggle = "",
    split = "gS",
    join = "gJ",
  },
})

-- mini.surround - Surround functionality
require("mini.surround").setup({
  mappings = {
    add = "gsa", -- Add surrounding in Normal and Visual modes
    delete = "gsd", -- Delete surrounding
    find = "gsf", -- Find surrounding (to the right)
    find_left = "gsF", -- Find surrounding (to the left)
    highlight = "gsh", -- Highlight surrounding
    replace = "gsr", -- Replace surrounding
    update_n_lines = "gsn", -- Update `n_lines`
  },
})

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
    hack = { pattern = "HACK", group = "MiniHipatternsHack" },
    todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
    note = { pattern = "NOTE", group = "MiniHipatternsNote" },

    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

local statusline = require("mini.statusline")
statusline.setup({
  use_icons = true,
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
      local filename = statusline.section_filename({ trunc_width = 140 })
      local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
      local location = statusline.section_location({ trunc_width = 75 })
      local search = statusline.section_searchcount({ trunc_width = 75 })

      return statusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- Right align from here
        { hl = "MiniStatuslineFilename", strings = { "%S" } },
        { hl = "MiniStatuslineDevinfo", strings = { diagnostics } },
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl, strings = { search, location } },
      })
    end,
  },
})

---@diagnostic disable: duplicate-set-field
statusline.section_location = function()
  return "%2l:%-2v"
end

statusline.section_filename = function()
  local filename = vim.fn.expand("%:t")
  local parent = vim.fn.expand("%:h:t")
  local modified = vim.bo.modified and " [+]" or ""

  if filename == "" then
    return "[No Name]" .. modified
  end
  if parent == "." or parent == "" then
    return filename .. modified
  end

  return parent .. "/" .. filename .. modified
end

statusline.section_fileinfo = function(args)
  local filetype = vim.bo.filetype

  -- Get icon using mini.icons instead of nvim-web-devicons
  if filetype ~= "" then
    local has_icons, icons = pcall(require, "mini.icons")
    if has_icons then
      local icon = icons.get("filetype", filetype) or ""
      if icon ~= "" then
        filetype = icon .. " " .. filetype
      end
    end
  end

  if statusline.is_truncated(args.trunc_width) or vim.bo.buftype ~= "" then
    return filetype
  end

  return string.format("%s%s", filetype, filetype == "" and "" or " ")
end
