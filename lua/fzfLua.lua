-- Fzf Lua Configuration
require("fzf-lua").setup({
    winopts = {
        height = 0.8,
        width = 0.8,
        row = 0,
        preview = {
            layout = "flex",
            scrollbar = "float",
        },
    },
    fzf_opts = {
        ["--layout"] = "reverse",
    },
})

local fzf = require("fzf-lua")

local function findRepo()
    fzf.files({ cwd = vim.fn.expand("~/repo/") })
end

local function getNotes()
    fzf.files({ cwd = vim.fn.expand("~/Data/TODO/") })
end

local function editNvim()
    fzf.files({ cwd = vim.fn.stdpath("config") })
end

local function findBins()
    fzf.files({ cwd = "~/.local/bin" })
end

local function openConfigs()
    fzf.fzf_exec("fd --max-depth 1 . ~/.config", {
        prompt = "Config> ",
        actions = {
            ["default"] = function(selected)
                local path = selected[1]
                local stat = vim.loop.fs_stat(path)
                if stat and stat.type == "directory" then
                    vim.cmd("cd " .. path)
                    print("Changed directory to " .. path)
                else
                    vim.cmd("edit " .. path)
                end
            end,
        },
    })
end

vim.keymap.set("n", "<leader>fe", "<CMD>FzfLua files<CR>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fp", findRepo, { desc = "Find Repo Files" })
vim.keymap.set("n", "<leader>fv", editNvim, { desc = "Find Neovim config Files" })
vim.keymap.set("n", "<leader>fn", getNotes, { desc = "Get me to my notes" })
vim.keymap.set("n", "<leader>fg", "<CMD>FzfLua live_grep<CR>", { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", "<CMD>FzfLua buffers<CR>", { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fs", findBins, { desc = "Find Shell scripts" })
vim.keymap.set("n", "<leader>fz", "<CMD>FzfLua builtin<CR>", { desc = "Find Builtin Stuff" })
vim.keymap.set("n", "<leader>fcc", openConfigs, { desc = "Find Builtin Stuff" })
