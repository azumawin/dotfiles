local impl = require("autocmds.implementations")

-- Highlight yanked text
local post_yank_grp = vim.api.nvim_create_augroup("post_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = post_yank_grp,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
    end,
})

-- Clean previous build artifacts and rebuild the project current latex buffer belongs to
-- Expects current latex buffer to belong to a latex that has a main.tex defined
local tex_post_write_grp = vim.api.nvim_create_augroup("tex_post_write", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    group = tex_post_write_grp,
    pattern = "*.tex",
    callback = impl.compile_latex_project_current_buffer_belongs_to,
})
