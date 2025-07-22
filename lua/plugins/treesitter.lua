return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
            -- Languages to install
            ensure_installed = {
                "kotlin",
                "java",
                "lua",
                "vim",
                "vimdoc",
                "json",
                "yaml",
                "toml",
                "markdown",
                "markdown_inline",
                "bash",
                "c",
                "cpp",
                "go",
                "html",
                "gitignore",
                "query"
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            auto_install = true,

            -- List of parsers to ignore installing (for "all")
            ignore_install = {},

            highlight = {
                enable = true,
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },

            indent = {
                enable = true,
                -- Disable for languages that have poor indentation support
                disable = { "python", "yaml" },
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    scope_incremental = false,
                    init_selection = "ni",
                    node_incremental = "nk",
                    node_decremental = "nj",
                },
            },

            -- Text objects for better navigation
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
            },

            -- Folding
            fold = {
                enable = true,
            },
    },

    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)

        -- Enable folding based on treesitter
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldenable = false -- Start with folds open
    end,
}
