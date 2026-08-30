local M = {}
--- Expects current latex buffer to belong to a latex project which has a main.tex
function M.compile_latex_project_current_buffer_belongs_to()
    local root_markers = { ".git", "main.tex" }
    -- not escaped root
    local raw_project_root = vim.fs.root(0, root_markers)
    if not raw_project_root then
        vim.notify(
            "Failed to find root using root_markers: "
                .. table.concat(root_markers, ", ")
                .. ". Root markers weren't found or the buffer you're in is not saved to disk and thus has no path.",
            vim.log.levels.WARN
        )
        return
    end

    local path_to_main = vim.fs.joinpath(raw_project_root, "main.tex")
    local escaped_path_to_main = vim.fn.shellescape(path_to_main, 1)

    -- clear previous build artifacts for fresh rebuild
    vim.cmd("silent !latexmk -C")
    -- alternative latex engines: xelatex, lualatex, pdflatex
    local command = "silent !latexmk -pdflatex " .. escaped_path_to_main
    vim.notify("running: " .. command)
    vim.cmd(command)
end
return M
