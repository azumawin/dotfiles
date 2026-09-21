return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            -- lua = { "luacheck" },
            python = { "ruff" },
            -- cs = { },
            tex = { "vale" },
        }

        local grp = vim.api.nvim_create_augroup("Linting", { clear = true })
        vim.api.nvim_create_autocmd(
            { "BufReadPost", "BufNewFile", "BufWritePost", "TextChanged", "TextChangedI" },
            {
                group = grp,
                callback = function()
                    lint.try_lint()
                end,
            }
        )
    end,
}
