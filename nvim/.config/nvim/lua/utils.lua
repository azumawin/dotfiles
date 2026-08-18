local M = {}

function M.get_help_for_string(str)
    if not str then
        vim.notify("String selected is nil.", vim.log.levels.WARN)
        return nil
    end

    local ok, err = pcall(vim.cmd, { cmd = "help", args = { str } })
    if not ok then
        vim.notify(("No help for %q"):format(str), vim.log.levels.WARN)
    end
end

function M.diff_original()
    print("diff?", vim.inspect(vim.wo.diff))
    if vim.wo.diff then
        vim.cmd("diffoff | only")
    else
        vim.cmd("DiffOrig")
    end
end

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
return M
