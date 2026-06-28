-- nvim-treesitter `main` branch (built for Neovim 0.11+).
-- No more require('nvim-treesitter.configs').setup{} — install parsers, then
-- start highlighting natively via vim.treesitter.start().
local ensure_installed = {
    "rust", "python", "c", "lua", "vim", "vimdoc", "query",
    "solidity", "json", "javascript", "typescript",
    "markdown", "markdown_inline",
}

require('nvim-treesitter').install(ensure_installed)

vim.api.nvim_create_autocmd('FileType', {
    callback = function(event)
        -- Only languages with an installed parser; pcall swallows the rest.
        pcall(vim.treesitter.start, event.buf)
    end,
})
