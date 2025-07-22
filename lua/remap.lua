vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex) -- Exit file
vim.keymap.set("n", "<leader>la", vim.cmd.La) -- Lazy Package Manager

-- Yanks to clipboard
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Moves line up and donw using K and J in Visual Mode
vim.keymap.set("v", "K", ":m  '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m  '>+1<CR>gv=gv")

vim.keymap.set('v', '<leader>{', 'c{<C-r>"}<Esc>')
vim.keymap.set('v', '<leader>(', 'c(<C-r>")<Esc>')
vim.keymap.set('v', '<leader>[', 'c[<C-r>"]<Esc>')
vim.keymap.set('v', '<leader>"', 'c"<C-r>""<Esc>')
