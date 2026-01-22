local map = vim.keymap.set

-- Basic
map({'n', 'v'}, 'j', 'gj')
map({'n', 'v'}, 'k', 'gk')
map({'n', 'v'}, 'gy', '"+y', { desc = "Yank to system clipboard" })
map({'n', 'v'}, 'gp', '"+p', { desc = "Paste from system clipboard" })
map('n', 'gV', '`[v`]', { desc = "Select last changed text" })

-- Windows
map('n', '<C-h>', '<C-w>h', { desc = "Focus left" })
map('n', '<C-j>', '<C-w>j', { desc = "Focus below" })
map('n', '<C-k>', '<C-w>k', { desc = "Focus above" })
map('n', '<C-l>', '<C-w>l', { desc = "Focus right" })

map('n', '<C-Left>', '<C-w><', { desc = "Resize Left" })
map('n', '<C-Down>', '<C-w>-', { desc = "Resize Down" })
map('n', '<C-Up>', '<C-w>+', { desc = "Resize Up" })
map('n', '<C-Right>', '<C-w>>', { desc = "Resize Right" })

-- Move with Alt
map('i', '<M-h>', '<Left>', { desc = "Move Left" })
map('i', '<M-j>', '<Down>', { desc = "Move Down" })
map('i', '<M-k>', '<Up>', { desc = "Move Up" })
map('i', '<M-l>', '<Right>', { desc = "Move Right" })
map('c', '<M-h>', '<Left>', { desc = "Move Left" })
map('c', '<M-l>', '<Right>', { desc = "Move Right" })
map('t', '<M-h>', '<Left>', { desc = "Move Left" })
map('t', '<M-j>', '<Down>', { desc = "Move Down" })
map('t', '<M-k>', '<Up>', { desc = "Move Up" })
map('t', '<M-l>', '<Right>', { desc = "Move Right" })

-- General utilities
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>fs", "<CMD>w<CR>", { desc = "Save file" })
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Plugin management
map("n", "<leader>L", function() vim.pack.update() end, { desc = "Update plugins" })

-- Session management
map("n", "<leader>qq", "<CMD>q<CR>", { desc = "Quit" })

map("n", "<leader>qs", function()
  local session_name = vim.fn.input("Session name: ")
  if session_name and session_name ~= "" then
    require("mini.sessions").write(session_name)
  end
end, { desc = "Save session" })

map("n", "<leader>qd", function()
  require("mini.sessions").select("delete")
end, { desc = "Delete session" })

map("n", "<leader>ql", function()
  require("mini.sessions").write("Session.vim")
end, { desc = "Save local session" })

-- Buffer management
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bq", "<cmd>bd<cr>", { desc = "Delete Buffer and Window" })
map("n", "<leader>bo", "<cmd>BdelOther<cr>", { desc = "Delete other buffers" })

-- File management
map("n", "-", function()
  require("mini.files").open((vim.api.nvim_buf_get_name(0)))
end)

map("n", "<leader>e", function()
  require("mini.files").open()
end, { desc = "Open files" })

-- Search and pick
map("n", "<leader>,", function()
  require("mini.pick").builtin.buffers()
end, { desc = "Buffers" })

map("n", "<leader>/", function()
  require("mini.pick").builtin.grep_live()
end, { desc = "Grep" })

map("n", "<leader><space>", function()
  require("mini.pick").builtin.files()
end, { desc = "Find Files" })

map("n", "<leader>ff", function()
  require("mini.pick").builtin.cli({
    command = { "fd", "--type=f", "--hidden", "--no-ignore", "--no-follow", "--color=never" },
  })
end, { desc = "Find Files (all)" })

map("n", "<leader>fr", function()
  require("mini.extra").pickers.oldfiles()
end, { desc = "Recent Files" })

map("n", "<leader>fg", function()
  require("mini.extra").pickers.git_files()
end, { desc = "Git Files" })

map("n", "<leader>sd", function()
  require("mini.extra").pickers.diagnostic()
end, { desc = "Search Diagnostics" })

map("n", "<leader>sm", function()
  require("mini.extra").pickers.manpages()
end, { desc = "Search man pages" })

map("n", "<leader>ss", function()
  require("mini.extra").pickers.lsp({ scope = "document_symbol" })
end, { desc = "Document LSP Symbols" })

map("n", "<leader>sS", function()
  require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
end, { desc = "Workspace LSP Symbols" })

map("n", "<leader>sc", function()
  require("mini.extra").pickers.history()
end, { desc = "Command History" })

map("n", "<leader>sD", function()
  require("mini.extra").pickers.spellsuggest()
end, { desc = "Suggest Spelling" })

map("n", "<leader>se", function()
  require("mini.extra").pickers.explorer()
end, { desc = "File Explorer" })

map("n", "<leader>sw", function()
  require("mini.pick").builtin.grep({ pattern = vim.fn.expand("<cword>") })
end, { desc = "Grep Word" })

map("n", "<leader>sg", function()
  require("mini.pick").builtin.grep()
end, { desc = "Grep Word" })

map("n", "<leader>st", function()
  require("mini.pick").builtin.grep({ pattern = "TODO|Todo" })
end, { desc = "Grep Word" })

map("n", "<leader>sT", function()
  require("mini.pick").builtin.grep({ pattern = "TODO|FIXME|FIX|Todo|Fix|Fixme" })
end, { desc = "Grep Word" })

map("n", "<leader>sh", function()
  require("mini.pick").builtin.help()
end, { desc = "Search Help" })

map("n", "<leader>sk", function()
  require("mini.extra").pickers.keymaps()
end, { desc = "Search Keymaps" })

-- Code actions
map("n", "<C-c>", function()
  local op = require("mini.comment").operator()
  return op .. "_"
end, { expr = true, desc = "Comment current line" })

map("x", "<C-c>", function()
  return require("mini.comment").operator()
end, { expr = true, desc = "Comment selection" })

map("n", "<leader>lr", "<CMD>LspRestart<CR>", { desc = "Restart LSP Server" })
map("n", "<leader>li", "<CMD>LspInfo<CR>", { desc = "LSP Info" })

-- Build and compile
map("n", "<leader>cr", "<CMD>make run<CR>", { desc = "Compile and run" })
map("n", "<leader>cc", "<CMD>make<CR>", { desc = "Compile" })

-- Trailspace
map("n", "<leader>cf", function()
  require("mini.trailspace").trim()
end, { desc = "Trim Trailspaces" })

map("n", "<leader>cl", function()
  require("mini.trailspace").trim_last_lines()
end, { desc = "Trim last lines" })

-- Diff
map("n", "<leader>go", function()
  require("mini.diff").toggle_overlay(0)
end, { desc = "Toggle Diff Overlay" })

-- Formatting (conform.nvim)
map("n", "<leader>lf", function()
  require("conform").format()
end, { desc = "Format Buffer" })

map({ "n", "v" }, "<leader>lF", function()
  require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
end, { desc = "Format Injected Langs" })

-- Leap
map({ "n", "x", "o" }, "s", "<Plug>(leap)", { desc = "Leap" })
map("n", "S", "<Plug>(leap-from-window)", { desc = "Leap from window" })

map({'o'}, 'gr', function ()
  require('leap.remote').action {
    -- Automatically enter Visual mode when coming from Normal.
    input = vim.fn.mode(true):match('o') and '' or 'v'
  }
end)

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
