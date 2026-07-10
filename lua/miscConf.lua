-- Open Tmux inside of the current directory
local function openTmuxWin()
    local cwd = vim.fn.expand("%:p:h")
    if cwd == "" then
        print("No file path found")
        return
    end
    local cmd = string.format("tmux new-window -c %q", cwd)
    vim.fn.system(cmd)
    print("Opened tmux window in: " .. cwd)
end

-- Zen mode toggle
local zen_mode = false

function ToggleZenMode()
    zen_mode = not zen_mode

    if zen_mode then
        vim.o.laststatus = 0
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.signcolumn = "no"
    else
        vim.o.laststatus = 2
        vim.wo.number = true
        vim.wo.relativenumber = true
        vim.wo.signcolumn = "yes"
    end
end

-- Helper Floating window function
local function OpenFloatingWindow(bufnr, opts)
    local ui = vim.api.nvim_list_uis()[1]

    local width = math.floor(ui.width * (opts.width or 0.9))
    local height = math.floor(ui.height * (opts.height or 0.9))
    local col = math.floor((ui.width - width) / 2)
    local row = math.floor(ui.height * (opts.top_offset or 0))

    return vim.api.nvim_open_win(bufnr, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = col,
        row = row,
        border = opts.border or 'rounded',
        style = 'minimal',
        title = opts.title or "",
        title_pos = opts.title_pos or 'center',
    })
end

-- Toggle term
local term_bufnr = nil
local term_winid = nil

function ToggleTerm()
    if term_winid and vim.api.nvim_win_is_valid(term_winid) then
        vim.api.nvim_win_close(term_winid, true)
        term_winid = nil
        return
    end

    if not (term_bufnr and vim.api.nvim_buf_is_valid(term_bufnr)) then
        term_bufnr = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(term_bufnr, 'bufhidden', 'hide')
    end

    term_winid = OpenFloatingWindow(term_bufnr, {
        width = 0.8,
        height = 0.8,
        top_offset = 0.02,
        title = " Terminal ",
    })

    if vim.api.nvim_buf_get_option(term_bufnr, "buftype") ~= "terminal" then
        vim.fn.termopen(vim.o.shell)
    end

    vim.cmd("startinsert")
end

-- Scratch Notes thing
local scratch_win = nil
local scratch_buf = nil

function ToggleScratch()
    if scratch_win and vim.api.nvim_win_is_valid(scratch_win) then
        vim.api.nvim_win_close(scratch_win, true)
        scratch_win = nil
        return
    end

    local filepath = vim.fn.expand("~/Data/TODO/ScratchNotes.md")
    local bufnr = vim.fn.bufadd(filepath)
    vim.fn.bufload(bufnr)
    scratch_buf = bufnr

    scratch_win = OpenFloatingWindow(scratch_buf, {
        width = 0.8,
        height = 0.6,
        top_offset = 0.1,
        title = " Note "
    })

    vim.bo[scratch_buf].filetype = "markdown"
    vim.wo[scratch_win].wrap = true
    vim.wo[scratch_win].number = false
    vim.wo[scratch_win].relativenumber = false
end

-- Function to open HTML, XML file in default web browser
function OpenInBrowser()
    local filetype = vim.bo.filetype

    if filetype == "html" or "xml" then
        local file_path = vim.fn.expand("%:p")
        local command = "xdg-open " .. file_path
        vim.fn.system(command)
        print("Opening in browser: " .. file_path)
    else
        print("This is not an HTML file.")
    end
end

vim.keymap.set('n', '<leader>oz', ToggleZenMode, { desc = "Toggle Zen Mode" })
vim.keymap.set("n", "<leader>to", openTmuxWin, { desc = "Open new tmux window here" })
vim.keymap.set("n", "<leader>tt", ToggleTerm, { desc = "Toggle Term here" })
vim.keymap.set("n", "<leader>nn", ToggleScratch, { desc = "Toggle Scratchpad" })
vim.keymap.set("n", "<leader>lp", OpenInBrowser, { desc = "Toggle Scratchpad" })
