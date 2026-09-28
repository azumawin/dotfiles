vim.g.mapleader = " "

vim.opt.relativenumber = true
vim.opt.number = true

-- 4-space indentation (and insert spaces when you press Tab)
vim.opt.expandtab = true -- tab inserts spaces
vim.opt.tabstop = 4 -- number of spaces that a literal '\t' character counts for (cursor movement)
vim.opt.shiftwidth = 4 -- number of spaces per indentation when performing an indent operation: auto-indent, >>, <<, ==
vim.opt.softtabstop = 4 -- number of spaces per indentation when pressing tab in insert mode? actually don't know but it works so i keep it
vim.opt.smartindent = true

-- make the unnamed register (") point to system clipboard register (+)
-- so that p/y operations when register isn't specified use system's clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.incsearch = true -- jump to and highlight first match of search pattern

vim.opt.scrolloff = 10 -- minimum number of lines to keep above and below cursor
vim.opt.wrap = false -- don't wrap text longer than the screen

-- Persist undo history on disk so closing and reopening nvim will still allow to undo changes from previous session
-- vim.opt.undofile = true
-- vim.opt.undodir = vim.fn.expand("~/.local/state/nvim/undo//")

vim.opt.updatetime = 1000
vim.opt.guicursor =
    "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-blinkon500-blinkoff500-TermCursor"

-- https://www.reddit.com/r/neovim/comments/1c0bemk/using_ripgrep_as_grepprg_to_search_in_the_current/
vim.o.grepprg = "rg --vimgrep --smart-case --hidden --glob '!.git'"
vim.o.grepformat = "%f:%l:%c:%m"
