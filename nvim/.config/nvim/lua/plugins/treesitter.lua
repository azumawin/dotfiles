return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master", -- frozen, supports up to nvim 0.12
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "python", "c_sharp", "latex", "java", "sql" },
                highlight = { enable = true },
                indent = { enable = false }, -- ahh indentation, off by default tbf
            })
        end,
    },
}

-- TROUBLESHOOTING
-- installing latex parser requires tree-parser-cli, which can be installed via rust package manager - cargo.
-- make sure to do: cargo install --locked --force tree-sitter-cli --version 0.25.10
-- since 0.25.10 is the last version of tree-sitter-cli that still supports the nvim-treesitter "master" branch
-- source: https://github.com/nvim-treesitter/nvim-treesitter/issues/7781
