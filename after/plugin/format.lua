local conform = require('conform')

conform.setup({
    formatters_by_ft = {
        python = { 'isort', 'black' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        json = { 'prettier' },
        lua = { 'stylua' },
        rust = { 'rustfmt' },
        solidity = { 'forge_fmt' },
    },
    formatters = {
        forge_fmt = {
            command = 'forge',
            args = { 'fmt', '$FILENAME' },
            stdin = false,
        },
    },
    format_on_save = {
        timeout_ms = 3000,
        lsp_format = 'fallback',
    },
})

vim.keymap.set('n', '<leader>f', function()
    conform.format({ async = true, lsp_format = 'fallback' })
end)
