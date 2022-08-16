-- File:        keymaps.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     12 Sep 2020
-- SPDX-License-Identifier: MIT
-- Vim:         set fdl=0 fdm=marker:

-- Set up keymaps
local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end


---------------
-- Mapleader --
---------------

-- Change mapleader
vim.g.mapleader = ","
-- Bypass mapleader action
map("n", "<Leader><Leader>", "<Leader>")


---------------
--  Actions  --
---------------

-- Write to file
map("n", "<C-s>", "<Cmd>update<CR>")
