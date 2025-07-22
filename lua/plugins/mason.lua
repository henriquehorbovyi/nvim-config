return {
    {
        "neovim/nvim-lspconfig",
            config = function()
            local lspconfig = require("lspconfig")
            -- LSP Keymaps function
            local function setup_lsp_keymaps(client, bufnr)
                local opts = { buffer = bufnr, silent = true }
                -- Navigation
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- Go to declaration
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- Go to implementation
                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts) -- Go to type definition
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- Show references
                -- Documentation
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Show hover documentation
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts) -- Signature help
                vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts) -- Signature help in insert mode
                -- Code actions
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- Code actions
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Rename symbol
                vim.keymap.set("n", "<leader>f", function()
                    vim.lsp.buf.format({ async = true })
                end, opts) -- Format buffer
                -- Diagnostics
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- Show line diagnostics
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- Previous diagnostic
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- Next diagnostic
                vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts) -- Diagnostics to location list
                -- Workspace
                vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts) -- Add workspace folder
                vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts) -- Remove workspace folder
                vim.keymap.set("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts) -- List workspace folders
                -- Alternative keymaps (if you prefer different keys)
                -- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
                -- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
                -- vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
            end
            -- Enhanced capabilities for autocompletion (if using nvim-cmp)
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- Uncomment if you have nvim-cmp installed:
            -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
            -- Default LSP setup function
            local function setup_server(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    on_attach = setup_lsp_keymaps,
                    -- Add server-specific settings here if needed
                })
            end
            -- Setup common LSP servers
            local servers = {
                "lua_ls",
                "clangd",
            }
            for _, server in ipairs(servers) do
                setup_server(server)
            end
            -- Custom server configurations
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = setup_lsp_keymaps,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })
            -- Configure diagnostics appearance
            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●", -- Could be '■', '▎', 'x', '●'
                    severity = { min = vim.diagnostic.severity.WARN },
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" },
        config = function()
            require("mason-lspconfig").setup()
        end,
    }

}

