-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<CR>", builtin.git_files, { desc = "Find Git files" })
vim.keymap.set("n", "<BS>", builtin.oldfiles, { desc = "Find previously opened files" })
