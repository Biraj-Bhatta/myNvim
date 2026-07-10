require("mini.ai").setup({
    custom_textobjects = {
        f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
        t = {
            "<([%p%w]-)%f[^<%w][^<>]->.-</%1>",
            "^<.->().*()</[^/]->$",
        },

        d = { "%f[%d]%d+" },

        e = {
            {
                "%u[%l%d]+%f[^%l%d]",
                "%f[%S][%l%d]+%f[^%l%d]",
                "%f[%P][%l%d]+%f[^%l%d]",
                "^[%l%d]+%f[^%l%d]",
            },
            "^().*()$",
        },

        u = require("mini.ai").gen_spec.function_call(),

        U = require("mini.ai").gen_spec.function_call({
            name_pattern = "[%w_]",
        }),
    },

    mappings = {
        around = "a",
        inside = "i",
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",
    },
    n_lines = 50,
    search_method = "cover_or_nearest",
    silent = true,
})

require("mini.pairs").setup({
    modes = { insert = true, command = true, terminal = false },
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    skip_ts = { "string" },
    skip_unbalanced = true,
    markdown = true,
})

require("mini.jump").setup({
    silent = true,
    delay = {
        highlight = 50,
        idle_stop = 100,
    },
})

require("mini.surround").setup({
    silent = true,
    search_method = "cover_or_nearest",
})

local hipatterns = require('mini.hipatterns')
hipatterns.setup({
    highlighters = {
        fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})

require("mini.trailspace").setup({})
