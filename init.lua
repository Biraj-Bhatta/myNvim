-- vim.o.packlockfile = vim.fn.stdpath("config") .. "/nvim-pack-lock.json"
-- Adding my custom settings and files
require("theme").setup()
require("keymap")
require("settings")
require("statusLine")
require("peekErr").setup()
require("miscConf")

-- Installing Plugins
vim.pack.add({
    { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("*")
    },
    { src = "https://github.com/tiwari-krishna/nvHopper.nvim" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
})

-- Plugin Related Configs
require("nvHopper").setup()
require("lspConfig")
require("compl")
require("fzfLua")
require("miniNvim")
require("treesitter")

-- Oil Configuration
require("oil").setup({
    view_options = {
        show_hidden = true,
        -- is_always_hidden = function(name)
        --     local m = name:match("^%..")
        --     return m ~= nil
        -- end,
    },
})

vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

--Undotree
vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle)
