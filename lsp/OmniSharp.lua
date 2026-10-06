return {
    cmd = {
        "dotnet",
        vim.fn.stdpath("data")
            .. "/mason/packages/omnisharp/libexec/OmniSharp.dll",
        "--languageserver",
        "--hostPID",
        tostring(vim.fn.getpid()),
    },

    filetypes = { "cs","vb" },

    root_markers = {
        ".sln",
        ".csproj",
        ".git",
    },
}
