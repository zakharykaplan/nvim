-- File:        color.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     20 Dec 2022
-- SPDX-License-Identifier: MIT

local colors = require("rose-pine")
local tint   = require("tint")

-- Configure color options
colors.setup {
  dark_variant = "moon",
}

-- Set colorscheme
vim.cmd.colorscheme("rose-pine")

-- Dim inactive windows
tint.setup {}
