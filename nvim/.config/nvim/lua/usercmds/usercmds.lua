-- realistically shouldnt be a command but rather just a function to call
vim.api.nvim_create_user_command("DiffOrig", function()
    vim.cmd("vert new | set bt=nofile | r ++edit # | 0d_ | diffthis")
    vim.cmd("wincmd p | diffthis")
end, {})

-- should be more generic imo. i should be able to just pass a command to run, which results in linter results saved somewhere and then just put those results in quickfix.
-- then once this command is more generic i can just make other user commands that call this with particular preset flags.
--
-- usage:
-- :Basedpyright
-- :Basedpyright --level error
-- :Basedpyright src/...
vim.api.nvim_create_user_command("Basedpyright", function(opts)
    -- opts.args = whatever flags the user passed, e.g. "--level error src/"
    local cmd = { "uv", "run", "basedpyright", "--outputjson" }
    -- append user args (split on whitespace)
    for _, a in ipairs(vim.split(opts.args, "%s+", { trimempty = true })) do
        table.insert(cmd, a)
    end

    -- find project root (dir containing pyproject.toml), fall back to cwd
    local root = vim.fs.root(0, { "pyproject.toml", "pyrightconfig.json", ".git" })
        or vim.fn.getcwd()

    vim.notify("running basedpyright...")
    vim.system(cmd, { cwd = root, text = true }, function(result)
        -- this runs in a fast event context — defer anything touching editor state
        vim.schedule(function()
            local ok, data = pcall(vim.json.decode, result.stdout)
            if not ok or not data then
                vim.notify(
                    "basedpyright: failed to parse output\n" .. (result.stderr or ""),
                    vim.log.levels.ERROR
                )
                return
            end

            local items = {}
            for _, d in ipairs(data.generalDiagnostics or {}) do
                table.insert(items, {
                    filename = d.file,
                    lnum = (d.range and d.range.start.line or 0) + 1, -- 0-indexed → 1
                    col = (d.range and d.range.start.character or 0) + 1,
                    text = (d.message or ""):gsub("\n", " "), -- flatten multiline
                    type = d.severity == "error" and "E" or d.severity == "warning" and "W" or "I",
                })
            end

            vim.fn.setqflist({}, "r", {
                title = "basedpyright",
                items = items,
            })
            vim.cmd("copen")

            local s = data.summary or {}
            vim.notify(
                string.format(
                    "basedpyright: %d errors, %d warnings",
                    s.errorCount or 0,
                    s.warningCount or 0
                )
            )
        end)
    end)
end, {
    nargs = "*", -- accept any number of flag args
    complete = "file", -- tab-completes file paths for the args
    desc = "Run basedpyright and load results into quickfix",
})
