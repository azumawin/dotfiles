-- Highlight yanked text
local post_yank_grp = vim.api.nvim_create_augroup("post_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = post_yank_grp,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
    end,
})

-- temporary autocmd to compile resume, realistically it should compile any just written latex file and not be hardcoded to resume.
local tex_post_write_grp = vim.api.nvim_create_augroup("tex_post_write", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    group = tex_post_write_grp,
    pattern = "*.tex",
    callback = function()
        vim.cmd("silent !latexmk -C")
        -- xelatex, lualatex, pdflatex
        vim.cmd("!latexmk -pdflatex ~/Desktop/resume/resume.tex")
    end,
})
