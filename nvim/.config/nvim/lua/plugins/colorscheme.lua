return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                styles = {
                    keywords = { italic = false },
                    comments = { italic = false },
                },
                on_colors = function(colors)
                    colors.hint = colors.orange
                    colors.error = "#ff0000"
                    colors.bg = "#000000"
                end,
                -- borderless telescope
                on_highlights = function(hl, c)
                    local prompt = "#2d3149"
                    hl.TelescopeNormal = {
                        bg = c.bg_dark,
                        -- fg = c.fg_dark,
                    }
                    hl.TelescopePreviewNormal = {
                        bg = "#000000",
                    }
                    hl.TelescopeBorder = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                    hl.TelescopePromptNormal = {
                        bg = prompt,
                    }
                    hl.TelescopePromptBorder = {
                        bg = prompt,
                        fg = prompt,
                    }
                    hl.TelescopePromptTitle = {
                        bg = prompt,
                        fg = prompt,
                    }
                    hl.TelescopePreviewTitle = {
                        bg = c.bg_dark,
                        -- fg = c.bg_dark,
                    }
                    hl.TelescopeResultsTitle = {
                        bg = c.bg_dark,
                        fg = c.bg_dark,
                    }
                end,
            })
            vim.cmd.colorscheme("tokyonight-moon")
            -- Override background color through vim api
            -- vim.opt.termguicolors = true
            -- vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
            -- vim.api.nvim_set_hl(0, "CurSearch", { bg = "#ff0000" }) -- set bg color of the word under cursor in hlsearch to red

            -- transparent background
            -- vim.cmd([[
            --   highlight Normal       ctermbg=NONE guibg=NONE
            --   highlight NormalNC     ctermbg=NONE guibg=NONE
            --   highlight EndOfBuffer  ctermbg=NONE guibg=NONE
            --   highlight SignColumn   ctermbg=NONE guibg=NONE
            --   highlight VertSplit    ctermbg=NONE guibg=NONE
            -- ]])
        end,
    },
}
