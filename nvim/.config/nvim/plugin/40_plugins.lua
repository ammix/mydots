-- Leap
require("leap").opts.preview = function(ch0, ch1, ch2)
  return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
end
require("leap").opts.equivalence_classes = {
  " \t\r\n",
  "([{",
  ")]}",
  "'\"`",
}
require("leap.user").set_repeat_keys("<enter>", "<backspace>")

-- Typst
require("typst-preview").setup({})


