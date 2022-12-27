-- File:        init.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     20 Dec 2022
-- SPDX-License-Identifier: MIT

require("vimrc.modules.edit.dial")

local autocmp   = require("nvim-autopairs.completion.cmp")
local autopairs = require("nvim-autopairs")
local cmp       = require("cmp")
local comment   = require("mini.comment")
local retrail   = require("retrail")
local surround  = require("mini.surround")

-- Fast and familiar per-line commenting
comment.setup {}

-- Super powerful autopairs
autopairs.setup {}
-- Interoperability with nvim-cmp
cmp.event:on(
  "confirm_done",
  autocmp.on_confirm_done {}
)

-- Whitespace management
retrail.setup {}

-- Fast and feature-rich surround actions
surround.setup {}
