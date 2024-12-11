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
    autocmd BufWritePre *.js lua vim.lsp.buf.format({ async = false })
    autocmd BufWritePre *.ts lua vim.lsp.buf.format({ async = false })
  augroup END
]])

for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

-- LSP setup for TypeScript and JavaScript (ts_ls)
require('lspconfig').ts_ls.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true

        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    end,
    settings = {
        javascript = {
            format = {
                enable = true, -- Enable formatting
            },
        },
        typescript = {
            format = {
                enable = true, -- Enable formatting
            },
        },
    },
})
