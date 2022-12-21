-- File:        lsp.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     20 Dec 2022
-- SPDX-License-Identifier: MIT

local fidget = require("fidget")

-- UI for nvim-lsp progress
fidget.setup {
  text = {
    -- Character shown when all tasks are completed
    done = "✓",
  },
}
