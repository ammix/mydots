local map = vim.keymap.set

-- Basic
map({ "n", "v" }, "j", "gj")
map({ "n", "v" }, "k", "gk")
map({ "n", "v" }, "gy", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "gp", '"+p', { desc = "Paste from system clipboard" })
map("n", "gV", "`[v`]", { desc = "Select last changed text" })

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Focus left" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus below" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus above" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right" })

map("n", "<C-Left>", "<C-w><", { desc = "Resize Left" })
map("n", "<C-Down>", "<C-w>-", { desc = "Resize Down" })
map("n", "<C-Up>", "<C-w>+", { desc = "Resize Up" })
map("n", "<C-Right>", "<C-w>>", { desc = "Resize Right" })

-- Move with Alt
map("i", "<M-h>", "<Left>", { desc = "Move Left" })
map("i", "<M-j>", "<Down>", { desc = "Move Down" })
map("i", "<M-k>", "<Up>", { desc = "Move Up" })
map("i", "<M-l>", "<Right>", { desc = "Move Right" })
map("c", "<M-h>", "<Left>", { desc = "Move Left" })
map("c", "<M-l>", "<Right>", { desc = "Move Right" })
map("t", "<M-h>", "<Left>", { desc = "Move Left" })
map("t", "<M-j>", "<Down>", { desc = "Move Down" })
map("t", "<M-k>", "<Up>", { desc = "Move Up" })
map("t", "<M-l>", "<Right>", { desc = "Move Right" })

-- General utilities
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>fs", "<CMD>w<CR>", { desc = "Save file" })
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Plugin management
map("n", "<leader>L", function()
  vim.pack.update()
end, { desc = "Update plugins" })

-- Quit
map("n", "<leader>qq", "<CMD>q<CR>", { desc = "Quit" })

-- Buffer management
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bq", "<cmd>bd<cr>", { desc = "Delete Buffer and Window" })
map("n", "<leader>bo", "<cmd>BdelOther<cr>", { desc = "Delete other buffers" })

-- LSP
map("n", "<leader>lr", "<CMD>LspRestart<CR>", { desc = "Restart LSP Server" })
map("n", "<leader>li", "<CMD>LspInfo<CR>", { desc = "LSP Info" })

-- Build and compile
map("n", "<leader>cr", "<CMD>make run<CR>", { desc = "Compile and run" })
map("n", "<leader>cc", "<CMD>make<CR>", { desc = "Compile" })
