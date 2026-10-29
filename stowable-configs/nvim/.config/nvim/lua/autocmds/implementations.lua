local M = {}
--- Expects current latex buffer to belong to a latex project which has a main.tex
--- Expects to be called from inside a devshell that has ltx-rebuild defined, for an example flake look in dotfiles/templates/latex/flake.nix
-- runs asynchronously, which results in :wq not actually building because nvim doesn't wait for the
-- task to finish and kills it right after it triggers precisely because it is async. i could make it
-- sync by adding `:wait()` on the vim.system calls, but long build times on larger projects can get
-- very annoying, so i'd rather keep it async and know that :wq doesnt actually build the project and
-- on top of that provide a ltx-build command in the devshell.
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

    -- assumes we're inside a devshell that has ltx-rebuild command defined
    vim.system({ "ltx-rebuild" }, { cwd = project_root }, function(obj)
        if obj.code ~= 0 then
            vim.schedule(function()
                vim.notify(obj.stderr, vim.log.levels.ERROR)
            end)
        end
    end)
end
return M
