local M = {}

local palette = {
    base      = "#1A1A1A",
    surface   = "#2c2c2c",
    overlay   = "#333333",
    muted     = "#6A9955",
    subtle    = "#D1CFCB",
    text      = "#D1CFCB",
    love      = "#E6676F",
    gold      = "#F5A94D",
    rose      = "#F5E48F",
    pine      = "#52B7F2",
    foam      = "#8FDCC5",
    iris      = "#FFD37A",
    highlight = "#3c3c3c",
    cursor_fg = "#1E2311",
    cursor_bg = "#FFCC66",
}

function M.setup()
    vim.cmd("highlight clear")
    if vim.fn.exists("syntax_on") == 1 then
        vim.cmd("syntax reset")
    end

    vim.o.termguicolors = true
    vim.g.colors_name = "myColors"

    local function hi(group, opts)
        vim.api.nvim_set_hl(0, group, opts)
    end

    -- Core UI
    hi("Normal",       { fg = palette.text, bg = palette.base })
    hi("NormalFloat",  { fg = palette.text, bg = palette.surface })
    hi("FloatBorder",  { fg = palette.muted, bg = palette.surface })
    hi("ColorColumn",  { bg = palette.overlay })
    hi("CursorLine",   { bg = palette.overlay })
    hi("CursorLineNr", { fg = palette.iris, bold = true })
    hi("LineNr",       { fg = palette.muted })
    hi("VertSplit",    { fg = palette.overlay })
    hi("Visual",       { bg = palette.highlight })
    hi("Search",       { fg = palette.base, bg = palette.gold, bold = true })
    hi("IncSearch",    { fg = palette.base, bg = palette.love, bold = true })
    hi("Pmenu",        { fg = palette.text, bg = palette.surface })
    hi("PmenuSel",     { bg = palette.gold, fg = palette.base, bold = true })
    hi("PmenuThumb",   { bg = palette.muted })
    hi("PmenuSbar",    { bg = palette.overlay })
    hi("StatusLine",   { fg = palette.muted, bg = palette.surface })
    hi("Title",        { fg = palette.rose, bold = true })
    hi("NormalNC",     { fg = palette.text, bg = palette.base })

    -- Cursor (makes cursor standout nicely)
    hi("Cursor",       { fg = palette.cursor_fg, bg = palette.cursor_bg })

    -- Syntax
    hi("Comment",    { fg = palette.muted })
    hi("Identifier", { fg = palette.foam })
    hi("Function",   { fg = palette.pine })
    hi("Statement",  { fg = palette.rose })
    hi("Keyword",    { fg = palette.rose })
    hi("Type",       { fg = palette.gold })
    hi("Constant",   { fg = palette.love })
    hi("String",     { fg = palette.gold })
    hi("Number",     { fg = palette.love })
    hi("Boolean",    { fg = palette.love })
    hi("Operator",   { fg = palette.subtle })
    hi("PreProc",    { fg = palette.iris })

    -- Treesitter (links)
    hi("@comment",   { link = "Comment" })
    hi("@function",  { link = "Function" })
    hi("@keyword",   { link = "Keyword" })
    hi("@type",      { link = "Type" })
    hi("@string",    { link = "String" })
    hi("@number",    { link = "Number" })
    hi("@boolean",   { link = "Boolean" })
    hi("@operator",  { link = "Operator" })
    hi("@constant",  { link = "Constant" })
    hi("@variable",  { fg = palette.text })
    hi("@field",     { fg = palette.foam })
    hi("@property",  { fg = palette.foam })
    hi("@parameter", { fg = palette.text })

    -- Diagnostics
    hi("DiagnosticError",          { fg = palette.love })
    hi("DiagnosticWarn",           { fg = palette.gold })
    hi("DiagnosticInfo",           { fg = palette.foam })
    hi("DiagnosticHint",           { fg = palette.iris })
    hi("DiagnosticUnderlineError", { undercurl = true, sp = palette.love })
    hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = palette.gold })
    hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = palette.foam })
    hi("DiagnosticUnderlineHint",  { undercurl = true, sp = palette.iris })
end

return M
