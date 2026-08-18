-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic stuff - doesn't need LspAttach (could come from linter or smth)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

local utils = require("utils")

local grp = vim.api.nvim_create_augroup("LSPstuff", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = grp,
    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    end,
})

-- get help for selection under cursor
vim.keymap.set("x", "<leader>z", function()
    utils.get_help_for_string(utils.get_selection_under_cursor())
end, { desc = "Call :h <selection> for identifier under cursor, uses treesitter to parse" })

-- trigger find and replace for words under cursor
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]])
vim.keymap.set("n", "<leader>rW", [[:%s/\<<C-r><C-W>\>/<C-r><C-W>/gc<Left><Left><Left>]])

-- find and replace for one-line string selected in visual mode.
vim.keymap.set("x", "<leader>r", function()
    local region =
        vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
    vim.g._rsel = table.concat(region, "\n")

    local keys =
        [[<Esc>:%s/\V<C-r>=escape(g:_rsel,'/\')<CR>/<C-r>=escape(g:_rsel,'/\&~')<CR>/gc<Left><Left><Left>]]
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", false)
end, { desc = "Find/replace visual selection." })

-- project-wide ripgrep, add results to quickfix
-- currently only for one-line selections
-- todo: maybe make it multiline
vim.keymap.set({ "x", "n" }, "<leader>rg", function()
    local root_markers = { ".git" }
    local project_root = vim.fs.root(0, root_markers)
    if not project_root then
        vim.notify(
            "Failed to find .git root marker. .git doesn't exist or the buffer you're is not saved to disk thus has no path.",
            vim.log.levels.WARN
        )
        return
    end

    local selection = utils.get_selection_under_cursor()

    -- prefix command with <Esc> to execute from normal mode
    local selection_escaped = vim.fn.shellescape(selection, 1)
    local root = vim.fn.shellescape(project_root, 1)

    -- only the NEXT grep (the one we're about to prefill) opens the window
    vim.api.nvim_create_autocmd("QuickFixCmdPost", {
        once = true,
        pattern = { "grep", "grepadd" },
        command = "cwindow",
    })

    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    local left = vim.api.nvim_replace_termcodes("<Left>", true, false, true)
    local cmd = ":silent grep! -F -- " .. selection_escaped .. " " .. root

    local back = string.rep(left, vim.fn.strchars(" " .. root) + 1)
    vim.api.nvim_feedkeys(esc .. cmd .. back, "n", false)
end)
-- quickfix toggle
vim.keymap.set("n", "<leader>.", function()
    local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
    if qf_winid > 0 then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end, { desc = "Toggle quickfix window" })

vim.keymap.set("n", "<leader>cn", ":cnext<CR>")
vim.keymap.set("n", "<leader>cp", ":cprev<CR>")
-- diff toggle
vim.keymap.set("n", "\\", utils.diff_original, { desc = "Diff with last write." })

-- g< or :messages to see last console log
