local M = {}
--- Expects current latex buffer to belong to a latex project which has a main.tex
function M.compile_latex_project_current_buffer_belongs_to(root_markers)
    -- not escaped root
    local project_root = vim.fs.root(0, root_markers)
    if not project_root then
        vim.notify(
            "Failed to find root using root_markers: "
                .. table.concat(root_markers, ", ")
                .. ". Root markers weren't found or the buffer you're in is not saved to disk and thus has no path.",
            vim.log.levels.WARN
        )
        return
    end

    local path_to_main = vim.fs.joinpath(project_root, "main.tex")

    -- clear previous build artifacts for fresh rebuild
    vim.system({ "latexmk", "-C" }, { cwd = project_root }, function(obj)
        if obj.code ~= 0 then
            vim.schedule(function()
                vim.notify(obj.stderr, vim.log.levels.ERROR)
            end)
        end
    end)

    -- build latex project
    vim.system(
        -- alternative latex engines: xelatex, lualatex, pdflatex
        { "latexmk", "-pdf", "-emulate-aux-dir", "-auxdir=out", "-outdir=.", path_to_main },
        { cwd = project_root },
        -- vim.system runs async so this needs to be scheduled and thus wrapped in a function
        function(obj)
            if obj.code ~= 0 then
                vim.schedule(function()
                    vim.notify(obj.stderr, vim.log.levels.ERROR)
                end)
            end
        end
    )
end
return M
