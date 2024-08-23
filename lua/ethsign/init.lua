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

-- LSP setup for Python using python-lsp-server
require('lspconfig').pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                black = { enabled = true },        -- Enable black formatter
                pyls_isort = { enabled = true },   -- Optionally enable isort for imports
                pycodestyle = { enabled = false }, -- Disable other formatters/linters if needed
            },
        },
    },
})

-- Auto format on save for Python files
vim.cmd([[
  augroup FormatOnSave
    autocmd!
    autocmd BufWritePre *.py lua vim.lsp.buf.format({ async = false })
  augroup END
]])
