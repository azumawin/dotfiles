local function call(cmd)
    vim.fn.system(cmd)
    return vim.v.shell_error == 0
end

return {
    {
        "nvim-telescope/telescope.nvim",
        version = "v0.1.9",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            telescope.setup({
                extensions = {
                    fzf = {},
                    file_browser = {
                        mappings = {
                            ["n"] = {
                                -- Trash files instead of deleting them
                                -- need to have trash-cli installed
                                -- ref: https://github.com/nvim-telescope/telescope-file-browser.nvim/issues/169
                                ["d"] = function(prompt_bufnr)
                                    local action_state = require("telescope.actions.state")
                                    local fb_utils =
                                        require("telescope._extensions.file_browser.utils")
                                    -- Get the finder
                                    local current_picker =
                                        action_state.get_current_picker(prompt_bufnr)
                                    local finder = current_picker.finder
                                    -- Get the selections
                                    local selections =
                                        fb_utils.get_selected_files(prompt_bufnr, false)
                                    if vim.tbl_isempty(selections) then
                                        fb_utils.notify("actions.trash", {
                                            msg = "No selection to be trashed!",
                                            level = "WARN",
                                            quiet = finder.quiet,
                                        })
                                        return
                                    end
                                    -- Trash the selected files
                                    local trashed = {}
                                    for _, selection in ipairs(selections) do
                                        local filename =
                                            selection.filename:sub(#selection:parent().filename + 2)
                                        -- `trash-put` is from the `trash-cli` package
                                        if call({ "trash-put", "--", selection:absolute() }) then
                                            table.insert(trashed, filename)
                                        end
                                    end
                                    -- Notify about operations
                                    local message = ""
                                    if not vim.tbl_isempty(trashed) then
                                        message = message
                                            .. "Trashed: "
                                            .. table.concat(trashed, ", ")
                                    end
                                    fb_utils.notify(
                                        "actions.trash",
                                        { msg = message, level = "INFO", quiet = finder.quiet }
                                    )
                                    -- Reset multi selection
                                    current_picker:refresh(
                                        current_picker.finder,
                                        { reset_prompt = true }
                                    )
                                end,
                            },
                        },
                    },
                },
            })

            telescope.load_extension("fzf")

            vim.keymap.set("n", "<leader>fc", function()
                builtin.find_files({ cwd = vim.fn.stdpath("config") })
            end, { desc = "Telescope: find config" })
        end,
    },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").load_extension("file_browser")

            vim.keymap.set("n", "<leader>fb", function()
                require("telescope").extensions.file_browser.file_browser({
                    use_fd = true,
                    path = vim.fn.expand("%:p:h"),
                    select_buffer = true,
                    hidden = { file_browser = false, folder_browser = false },
                    respect_gitignore = true,
                    no_ignore = false,
                })
            end, { desc = "Telescope: file browser" })

            vim.keymap.set("n", "<leader>fh", function()
                require("telescope").extensions.file_browser.file_browser({
                    use_fd = true,
                    path = vim.fn.expand("%:p:h"),
                    select_buffer = true,
                    hidden = { file_browser = true, folder_browser = true },
                    respect_gitignore = false,
                    no_ignore = true,
                })
            end, { desc = "Telescope: file hidden" })
        end,
    },
}
