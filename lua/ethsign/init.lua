require("ethsign.remap")
require("ethsign.set")
require("ethsign.lazy")

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

require('mini.cursorword').setup({
    delay = 100, -- Delay in milliseconds before highlighting
})

vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2b2b2b" })
