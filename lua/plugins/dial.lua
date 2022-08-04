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
    augend.date.alias["%d.%m.%Y"],
    augend.date.alias["%d.%m.%Y"],
    augend.date.alias["%d.%m.%y"],
    augend.date.alias["%d/%m/%Y"],
    augend.date.alias["%d/%m/%y"],
    augend.date.alias["%m/%d"],
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
local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Increment
map("n", "<C-a>", dial.inc_normal())
map("v", "<C-a>", dial.inc_visual())
map("v", "<C-a>", dial.inc_gvisual())

-- Decrement
map("n", "<C-x>", dial.dec_normal())
map("v", "<C-x>", dial.dec_visual())
map("v", "<C-x>", dial.dec_gvisual())
