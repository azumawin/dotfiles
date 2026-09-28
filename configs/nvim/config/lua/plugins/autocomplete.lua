return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        { -- vim.snippet engine doesnt load vscode snippets
            "L3MON4D3/LuaSnip",
            dependencies = { "rafamadriz/friendly-snippets" },
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
    },
    version = "1.*",
    init = function()
        vim.g.blink_cmp_autoshow = true

        vim.keymap.set("i", "<C-e>", function()
            vim.g.blink_cmp_autoshow = not vim.g.blink_cmp_autoshow

            if not vim.g.blink_cmp_autoshow then
                require("blink.cmp").hide()
            end

            vim.notify("blink.cmp auto_show: " .. tostring(vim.g.blink_cmp_autoshow))
        end, { desc = "Toggle blink.cmp auto_show" })
    end,

    opts = {
        snippets = { preset = "luasnip" },
        keymap = {
            preset = "default",
            -- ["<C-e>"] = { "show", "hide" },
            ["<C-e>"] = false, -- use init script above for full toggle instead
            ["<C-space>"] = { "show_documentation", "hide_documentation" },

            ["<Tab>"] = { "accept", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },

            ["<C-m>"] = { "select_prev", "fallback_to_mappings" },
            ["<C-n>"] = { "select_next", "fallback_to_mappings" },

            ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },

            -- ["<C-k>"] = { "scroll_documentation_up", "fallback" },
            -- ["<C-j>"] = { "scroll_documentation_down", "fallback" },

            -- i don't use
            -- ["<Up>"] = { "select_prev", "fallback" },
            -- ["<Down>"] = { "select_next", "fallback" },
            -- ["<C-y>"] = { "select_and_accept", "fallback" },
        },
        signature = { enabled = true },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            documentation = { auto_show = true },
            accept = { auto_brackets = { enabled = true } },
            menu = {
                auto_show = function(ctx)
                    return vim.g.blink_cmp_autoshow
                end,
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
