-- ~/.config/nvim/lua/plugins/colorscheme.lua
-- Catppuccin colorscheme configuration

return {

    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load before other plugins
    lazy = false, -- Load immediately

    opts = {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {
            light = "latte",
            dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
            enabled = false,
            shade = "dark",
            percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
            comments = { "italic" },
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
        },
        color_overrides = {
            mocha = {
                base = "#0a0a0a"
            } 
        },
        custom_highlights = {},
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            telescope = {
                enabled = true,
            },
            mason = true,
            which_key = true,
        },
    },

    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd.colorscheme("catppuccin")
    end,
}
