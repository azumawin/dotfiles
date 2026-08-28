local utils = require("keymaps.utils")

-- Toggle quickfix
vim.keymap.set("n", "<leader>.", utils.toggle_quickfix)

-- Go to next/prev quickfix result
vim.keymap.set("n", "<leader>,", ":cnext<CR>")
vim.keymap.set("n", "<leader>.", ":cprev<CR>")
