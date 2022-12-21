-- File:        keymaps.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     12 Sep 2020
-- SPDX-License-Identifier: MIT

---------------
-- Mapleader --
---------------

-- Change mapleader
vim.g.mapleader = ","
-- Bypass mapleader action
vimrc.map("n", "<Leader><Leader>", "<Leader>", nil, "Perform mapleader action")

---------------
--  Actions  --
---------------

-- Write to file
  vimrc.map("n", "<C-s>", "<Cmd>update<CR>", nil, "Save buffer")
