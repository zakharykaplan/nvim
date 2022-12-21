-- File:        init.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     05 Jul 2022
-- SPDX-License-Identifier: MIT

local util = require("vimrc.util")

local M = {}
_G.vimrc = M

-- Create an augroup
M.augroup = util.autocmd.augroup

-- Create an autocmd
M.autocmd = util.autocmd.autocmd

-- Create a keymap
M.map     = util.keymap.map

-- Set up vimrc
function M.setup()
  -- Bootstrap
  require("vimrc.boot")

  -- Install plugins
  require("vimrc.plugins")

  -- Configure packages
  require("vimrc.packages")

  -- General configuration
  require("vimrc.options")
  require("vimrc.autocmds")
  require("vimrc.keymaps")

  -- Configure modules
  require("vimrc.modules")
end

return M
