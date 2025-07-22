-- ~/.config/nvim/lua/plugins/telescope.lua
-- Telescope fuzzy finder configuration

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        "nvim-telescope/telescope-ui-select.nvim",
    },

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "truncate" },
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                mappings = {
                    i = {
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-c>"] = actions.close,
                        ["<Down>"] = actions.move_selection_next,
                        ["<Up>"] = actions.move_selection_previous,
                        ["<CR>"] = actions.select_default,
                        ["<C-x>"] = actions.select_horizontal,
                        ["<C-v>"] = actions.select_vertical,
                        ["<C-t>"] = actions.select_tab,
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,
                    },
                    n = {
                        ["<esc>"] = actions.close,
                        ["<CR>"] = actions.select_default,
                        ["<C-x>"] = actions.select_horizontal,
                        ["<C-v>"] = actions.select_vertical,
                        ["<C-t>"] = actions.select_tab,
                        ["j"] = actions.move_selection_next,
                        ["k"] = actions.move_selection_previous,
                        ["H"] = actions.move_to_top,
                        ["M"] = actions.move_to_middle,
                        ["L"] = actions.move_to_bottom,
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,
                        ["q"] = actions.close,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    file_ignore_patterns = {
                        "node_modules",
                        ".git",
                        ".venv",
                    },
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end,
                    file_ignore_patterns = {
                        "node_modules",
                        ".git",
                        ".venv",
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
            },
        })

        -- Load extensions
        pcall(telescope.load_extension, "fzf")
        pcall(telescope.load_extension, "ui-select")

        -- Set keymaps
        local builtin = require("telescope.builtin")
        local map = vim.keymap.set

        map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
        map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
        map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
        map("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
        map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
        map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
        map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
        map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
        map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

        -- Slightly advanced example: search in current buffer
        map("n", "<leader>/", function()
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = "[/] Fuzzily search in current buffer" })
    end,
}
