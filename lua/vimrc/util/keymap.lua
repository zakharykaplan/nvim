-- File:        keymap.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     12 Sep 2020
-- SPDX-License-Identifier: MIT
-- Vim:         set fdl=0 fdm=marker:

-- Set up keymaps
local function map(mode, lhs, rhs, opts, hint)
  opts = opts or { noremap = true, silent = true, desc = hint }
  vim.keymap.set(mode, lhs, rhs, opts)
end

return {
  -- Make a non-recursive silent keymap
  map = map,
}
