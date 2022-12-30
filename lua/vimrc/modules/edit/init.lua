-- File:        init.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     20 Dec 2022
-- SPDX-License-Identifier: MIT

require("vimrc.modules.edit.dial")

local comment   = require("mini.comment")
local pairs     = require("mini.pairs")
local retrail   = require("retrail")
local surround  = require("mini.surround")

-- Fast and familiar per-line commenting
comment.setup {}

-- Automatically manage character pairs
pairs.setup {}

-- Whitespace management
retrail.setup {}

-- Fast and feature-rich surround actions
surround.setup {}
