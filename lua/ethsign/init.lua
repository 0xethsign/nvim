require("ethsign.remap")
require("ethsign.set")


vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.sol",
    command = "silent !forge fmt %"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.rs",
    callback = function()
        vim.lsp.buf.format()
    end,
})

require('mini.cursorword').setup({
    delay = 100, -- Delay in milliseconds before highlighting
})

vim.opt.cursorline = true
vim.api.nvim_command('highlight CursorLine guibg=#2b2b2b')
