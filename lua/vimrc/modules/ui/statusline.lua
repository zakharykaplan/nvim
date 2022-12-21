-- File:        statusline.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

local lualine = require("lualine")

-- Blazing fast statusline
lualine.setup {
  options = {
    component_separators = "│",
    section_separators = "",
    globalstatus = true,
  },
}
