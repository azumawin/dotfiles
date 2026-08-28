local utils = require("keymaps.utils")

-- Diff current buffer against last write.
vim.keymap.set("n", "\\", utils.diff_original, { desc = "Diff with last write." })
