local impl = require("keymaps.implementations")

-- Diff current buffer against last write.
vim.keymap.set("n", "\\", impl.diff_original, { desc = "Diff with last write." })
