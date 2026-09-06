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
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({

                -- a list of all tools you want to ensure are installed upon
                -- start
                ensure_installed = {
                    -- Python
                    { "basedpyright", version = "1.39.10" },
                    { "pyright", version = "1.1.413" },
                    { "ruff", version = "0.16.5" },
                    { "black", version = "26.5.1" },

                    -- Nix
                    { "nil", version = "2025-06-13" },
                    { "nixfmt", version = "v1.4.0" },

                    -- C / C++
                    { "clangd", version = "22.1.6" },
                    { "clang-format", version = "23.1.0" },

                    -- C#
                    { "csharpier", version = "1.2.6" },
                    { "roslyn", version = "5.12.0-1.26428.1" },

                    -- Java
                    { "jdtls", version = "v1.60.0" },
                    { "google-java-format", version = "v1.36.1" },

                    -- Lua
                    { "lua-language-server", version = "3.19.1" },
                    { "luacheck", version = "1.1.0" },
                    { "stylua", version = "v2.5.2" },

                    -- LaTeX
                    { "texlab", version = "v5.26.0" },
                    { "latexindent", version = "V4.0.2" },

                    -- Markdown
                    { "mdformat", version = "1.0.0" },

                    -- SQL
                    { "pgformatter", version = "v5.10" },

                    -- TOML
                    { "taplo", version = "0.10.0" },

                    -- XML
                    { "xmlformatter", version = "0.2.9" },

                    -- Prose / spelling (language-agnostic)
                    { "vale", version = "v3.19.0" },

                    -- Web / multi-language (JS, TS, CSS, HTML, YAML, JSON, ...)
                    { "prettier", version = "3.9.6" },
                },
                -- if set to true this will check each tool for updates. If updates
                -- are available the tool will be updated. This setting does not
                -- affect :MasonToolsUpdate or :MasonToolsInstall.
                -- Default: false
                auto_update = false,

                -- automatically install / update on startup. If set to false nothing
                -- will happen on startup. You can use :MasonToolsInstall or
                -- :MasonToolsUpdate to install tools and check for updates.
                -- Default: true
                run_on_start = true,

                -- set a delay (in ms) before the installation starts. This is only
                -- effective if run_on_start is set to true.
                -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
                -- Default: 0
                start_delay = 3000, -- 3 second delay

                -- Only attempt to install if 'debounce_hours' number of hours has
                -- elapsed since the last time Neovim was started. This stores a
                -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
                -- This is only relevant when you are using 'run_on_start'. It has no
                -- effect when running manually via ':MasonToolsInstall' etc....
                -- Default: nil
                debounce_hours = 5, -- at least 5 hours between attempts to install/update

                -- By default all integrations are enabled. If you turn on an integration
                -- and you have the required module(s) installed this means you can use
                -- alternative names, supplied by the modules, for the thing that you want
                -- to install. If you turn off the integration (by setting it to false) you
                -- cannot use these alternative names. It also suppresses loading of those
                -- module(s) (assuming any are installed) which is sometimes wanted when
                -- doing lazy loading.
                integrations = {
                    ["mason-lspconfig"] = true,
                    ["mason-null-ls"] = true,
                    ["mason-nvim-dap"] = true,
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
            vim.lsp.enable({ "lua_ls", "ruff", "basedpyright", "roslyn", "texlab", "clangd", "nil" })
        end,
    },
}
