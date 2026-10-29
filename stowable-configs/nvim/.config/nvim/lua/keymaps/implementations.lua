local M = {}

-- get the string currently selected in visual mode
-- NOTE: only works for single line strings
function M.get_selection_under_cursor()
    local s = vim.fn.getpos("v") -- where the cursor was at the start of selection
    local e = vim.fn.getpos(".") -- where the cursor is at the end of selection
    local scol, ecol = s[3], e[3]
    -- selection can go right-to-left, so normalize it
    if scol > ecol then
        scol, ecol = ecol, scol
    end
    return vim.fn.getline(s[2]):sub(scol, ecol)
end

-- requires grep engine to be set to ripgrep in vim.opts
function M.project_wide_ripgrep_to_quickfix()
    local root_markers = { ".git" }
    local project_root = vim.fs.root(0, root_markers)
    if not project_root then
        vim.notify(
            "Failed to find .git root marker. .git/ doesn't exist or the buffer you're in is not saved to disk thus has no path.",
            vim.log.levels.WARN
        )
        return
    end

    local selection = M.get_selection_under_cursor()

    local selection_escaped = vim.fn.shellescape(selection, 1)
    local root = vim.fn.shellescape(project_root, 1)

    -- only the NEXT grep (the one we're about to prefill) opens the window
    vim.api.nvim_create_autocmd("QuickFixCmdPost", {
        once = true,
        pattern = { "grep", "grepadd" },
        command = "cwindow",
    })

    -- prefix command with <Esc> to execute from normal mode
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    local left = vim.api.nvim_replace_termcodes("<Left>", true, false, true)
    local cmd = ":silent grep! -F -- " .. selection_escaped .. " " .. root

    local back = string.rep(left, vim.fn.strchars(" " .. root) + 1)
    vim.api.nvim_feedkeys(esc .. cmd .. back, "n", false)
end

-- expects quickfix to be open and contain grep results which it will try and replace across all files in the project
function M.trigger_replace_on_quickfix()
    -- parse search from the title of ripgrep quickfix populated by M.project_wide_ripgrep_to_quickfix
    local title = vim.fn.getqflist({ title = 0 }).title
    local search = title:match("%-%- '([^']*)'")

    -- prefix command with <Esc> to execute from normal mode
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    local left = vim.api.nvim_replace_termcodes("<Left>", true, false, true)
    local cmd = ":cdo s/" .. search .. "/" .. search .. "/gc"
    local back = string.rep(left, vim.fn.strchars("/gc"))
    vim.api.nvim_feedkeys(esc .. cmd .. back, "n", false)
end

function M.diff_original()
    print("diff?", vim.inspect(vim.wo.diff))
    if vim.wo.diff then
        vim.cmd("diffoff | only")
    else
        vim.cmd("vert new | set bt=nofile | r ++edit # | 0d_ | diffthis")
        vim.cmd("wincmd p | diffthis")
    end
end

function M.toggle_quickfix()
    local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
    if qf_winid > 0 then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end
return M
