vim.filetype.add({
  filename = {
    ["vifmrc"] = "vim",
  },
  pattern = {
    [".*/ghostty/config"] = "ghostty",
    [".*/hypr/.+%.conf"] = "hyprlang",
    ["%.env%.[%w_.-]+"] = "sh",
  },
})
