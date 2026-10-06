local ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "javascript",
    "tsx",
    "go",
    "html",
    "rust",
    "python",
    "typescript",
    "lua",
    "markdown",
    "markdown_inline",
    "zig",
    "sql",
    "json"
}

require("nvim-treesitter").setup {
    install_dir = vim.fn.stdpath('data') .. '/site'
}
require("nvim-treesitter").install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
    callback = function(details)
        local bufnr = details.buf
        if not pcall(vim.treesitter.start, bufnr) then
            return
        end
        vim.bo[bufnr].syntax = "on"
        vim.wo.foldlevel = 99
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

            -- Disable treesitter indentation for C#
        if vim.bo[bufnr].filetype ~= "cs" then
            vim.bo[bufnr].indentexpr =
                "v:lua.require'nvim-treesitter'.indentexpr()"
        end

    end,
})
