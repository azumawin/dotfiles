return {
    {
        "mason-org/mason.nvim",
        opts = {},
        config = function()
            require("mason").setup({
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                },
            })
        end,
    },

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
            "mason-org/mason.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            require("mason").setup()

            local blink = require("blink.cmp")

            -- merge existing capabilities with blink and set for ls
            local existing = vim.lsp.config["*"] and vim.lsp.config["*"].capabilities or nil
            local with_blink = blink.get_lsp_capabilities(existing)
            vim.lsp.config("*", {
                capabilities = with_blink,
            })

            -- overrides
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            })

            -- basedpyright defaults to typeCheckingMode = "recommended", which turns
            -- every optional rule into an error. "standard" is pyright's own default:
            -- it still catches wrong types, bad attrs and None-deref, without demanding
            -- a fully annotated codebase. A project's pyproject.toml wins over this.
            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                        analysis = {
                            typeCheckingMode = "standard",
                            diagnosticMode = "workspace",
                            diagnosticSeverityOverrides = {
                                reportImplicitAbstractClass = "error",
                                -- ruff owns these and can autofix them; without this
                                -- you get every unused import reported twice
                                reportUnusedImport = "none",
                                reportUnusedVariable = "none",
                                -- noise from untyped third-party libs, not your bugs
                                reportMissingTypeStubs = "none",
                                reportUnknownMemberType = "none",
                                reportUnknownArgumentType = "none",
                                reportUnknownVariableType = "none",
                                -- basedpyright-only rules that fire constantly
                                reportAny = "none",
                                reportExplicitAny = "none",
                                reportUnusedCallResult = "none",
                                reportImplicitOverride = "none",
                                reportUnannotatedClassAttribute = "none",
                            },
                        },
                    },
                },
            })

            -- vim.lsp.config("csharp_ls", {})
            -- vim.lsp.config("texlab", {})
            -- vim.lsp.config("roslyn", {})
            -- jdtls is meant to be started per buffer so config is in ftplugin/java
            vim.lsp.enable({ "lua_ls", "ruff", "basedpyright", "roslyn", "texlab", "clangd" })
        end,
    },
}
