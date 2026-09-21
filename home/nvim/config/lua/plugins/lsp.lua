return {
    {
        "seblyng/roslyn.nvim",
        opts = {},
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
        },
        config = function()
            -- servers and formatters come from home.nix via nix, not mason, so they're
            -- already on PATH by the time nvim starts. nothing to bootstrap here.
            local blink = require("blink.cmp")

            -- merge existing capabilities with blink and set for ls
            local existing = vim.lsp.config["*"] and vim.lsp.config["*"].capabilities or nil
            local with_blink = blink.get_lsp_capabilities(existing)
            vim.lsp.config("*", {
                capabilities = with_blink,
            })

            local basedpyright_config = require("lspconfigs.basedpyright")
            -- overrides
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            })

            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = basedpyright_config.normal,
                },
            })

            -- vim.lsp.config("csharp_ls", {})
            -- vim.lsp.config("texlab", {})
            -- vim.lsp.config("roslyn", {})
            -- jdtls is meant to be started per buffer so config is in ftplugin/java
            -- vim.lsp.enable uses underscores instead of dashes, so rust-analyzer becomes rust_analyzer
            vim.lsp.enable({
                "lua_ls",
                "ruff",
                "basedpyright",
                "roslyn",
                "texlab",
                "clangd",
                "nil_ls",
                "rust_analyzer",
            })
        end,
    },
}
