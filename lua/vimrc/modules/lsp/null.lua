-- File:        null.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     18 Aug 2022
-- SPDX-License-Identifier: MIT

local null = require("null-ls")

null.setup {
  sources = {
    null.builtins.formatting.black,
    null.builtins.formatting.isort,
    null.builtins.formatting.rustfmt,
  },
}
