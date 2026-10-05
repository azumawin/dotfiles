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
    callback = function()
        -- root markers used to find the root of the project current latex buffer belongs to by searching upwards
        -- assumes that main.tex lives at the root, if i wanted to have src/main.tex then i'd have to set a different root marker and update compile_latex_project_current_buffer_belongs_to
        local root_markers = { "main.tex" }
        impl.compile_latex_project_current_buffer_belongs_to(root_markers)
    end,
})
