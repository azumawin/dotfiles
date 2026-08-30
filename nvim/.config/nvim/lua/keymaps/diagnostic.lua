-- Diagnostic stuff - doesn't need LspAttach (could come from linter)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>q", function()
    vim.diagnostic.setqflist({ open = true })
end, { desc = "Diagnostics to quickfix" })

-- belongs here and not in autocmds
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
