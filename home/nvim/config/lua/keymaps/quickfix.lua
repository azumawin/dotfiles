local impl = require("keymaps.implementations")

-- Toggle quickfix
vim.keymap.set("n", "<leader>.", impl.toggle_quickfix)

-- Go to next/prev quickfix result
vim.keymap.set("n", "<leader>;", ":cnext<CR>")
vim.keymap.set("n", "<leader>'", ":cprev<CR>")
