local impl = require("keymaps.implementations")

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Performs a project-wide ripgrep on currently selected one-line string and opens quickfix with the results.
vim.keymap.set({ "x", "n" }, "<leader>rg", impl.project_wide_ripgrep_to_quickfix)

-- Triggers a project-wide replace prompt given a quickfix of ripgrep results
vim.keymap.set("n", "<leader>r", impl.trigger_replace_on_quickfix)

-- Buffer-wide find and replace for word under cursor
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]])
vim.keymap.set("n", "<leader>rW", [[:%s/\<<C-r><C-W>\>/<C-r><C-W>/gc<Left><Left><Left>]])
