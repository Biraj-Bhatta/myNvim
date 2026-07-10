local opt = vim.opt

--opt.guicursor = ""
-- vim.opt.shortmess:append("I")
opt.showcmd = true
opt.laststatus = 2
opt.autowrite = true
opt.cursorline = true
opt.autoread = true
opt.smarttab = true
opt.smartindent = true
opt.title = true

--opt.clipboard = 'unnamedplus'
opt.mouse = "a"
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.nu = true
opt.rnu = true
opt.enc = "utf-8"
opt.ignorecase = true
opt.smartcase = true
opt.breakindent = true
opt.splitright = true
opt.splitbelow = true
opt.conceallevel = 0
opt.completeopt = { "menuone", "noselect" }
opt.numberwidth = 1
opt.signcolumn = "yes"
opt.wrap = true
opt.backspace = "indent,eol,start"
opt.iskeyword:append("_", "-")
opt.path:append("**")
opt.selection = "inclusive"
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.expandtab = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true
opt.scrolloff = 8
opt.updatetime = 50

opt.winborder = "rounded"

opt.colorcolumn = "100"

opt.undodir = os.getenv("HOME") .. "/.cache/undodir"

opt.confirm = true

vim.cmd([[autocmd FileType * set formatoptions-=ro]])

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- AutoCmd
vim.opt.spelllang = { "en_gb" }
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    desc = "Restore last cursor position",
    callback = function()
        if vim.o.diff then
            return
        end
        local last_pos = vim.api.nvim_buf_get_mark(0, '"')
        local last_line = vim.api.nvim_buf_line_count(0)
        local row = last_pos[1]
        if row < 1 or row > last_line then
            return
        end
        pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
    end,
})
