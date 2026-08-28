local utils = require("keymaps.utils")

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- NEED A PROJECT-WIDE FIND AND REPLACE
-- Buffer-wide find and replace for word under cursor
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]])
vim.keymap.set("n", "<leader>rW", [[:%s/\<<C-r><C-W>\>/<C-r><C-W>/gc<Left><Left><Left>]])

-- Buffer-wide find and replace for currently selected one-line string.
vim.keymap.set("x", "<leader>r", utils.buffer_wide_selection_find_and_replace)

-- Performs a project-wide ripgrep on currently selected one-line string and opens quickfix with the results.
vim.keymap.set({ "x", "n" }, "<leader>rg", utils.project_wide_ripgrep_to_quickfix)
