-- File:        dial.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     03 Aug 2022
-- SPDX-License-Identifier: MIT

local dial   = require("dial.map")
local augend = require("dial.augend")
local config = require("dial.config")

config.augends:register_group {
  default = {
    -- Numbers
    augend.integer.alias.binary,
    augend.integer.alias.decimal_int,
    augend.integer.alias.hex,
    augend.integer.alias.octal,
    -- -- Date
    augend.date.alias["%H:%M"],
    augend.date.alias["%H:%M:%S"],
    augend.date.alias["%Y-%m-%d"],
    augend.date.alias["%Y/%m/%d"],
    augend.date.alias["%d/%m/%Y"],
    augend.date.new {
        pattern = "%d %b %Y",
        default_kind = "day",
        only_valid = true,
    },
    -- Constant
    augend.constant.alias.Alpha,
    augend.constant.alias.alpha,
    augend.constant.alias.bool,
    augend.constant.new {
      elements = { "and", "or" },
      word     = true,
      cyclic   = true,
    },
    augend.constant.new {
      elements = { "&&", "||" },
      word     = false,
      cyclic   = true,
    },
    -- Hexcolor
    augend.hexcolor.new {
      case = "lower",
    },
    -- Semver
    augend.semver.alias.semver,
    -- Misc
    augend.misc.alias.markdown_header,
  },
}

-- Set up keymaps
local function map(mode, lhs, rhs, opts, hint)
  opts = opts or { noremap = true, silent = true, desc = hint }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Increment
map("n", "<C-a>", dial.inc_normal(),   nil, "Add [count] to the value at the cursor")
map("v", "<C-a>", dial.inc_visual(),   nil, "Add [count] to the value at the cursor")
map("v", "g<C-a>", dial.inc_gvisual(), nil, "Add [count] to the value at the cursor")

-- Decrement
map("n", "<C-x>", dial.dec_normal(),   nil, "Subtract [count] to the value at the cursor")
map("v", "<C-x>", dial.dec_visual(),   nil, "Subtract [count] to the value at the cursor")
map("v", "g<C-x>", dial.dec_gvisual(), nil, "Subtract [count] to the value at the cursor")
