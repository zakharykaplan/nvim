-- File:        bufferline.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     11 Aug 2021
-- SPDX-License-Identifier: MIT

require("bufferline").setup {
  options = {
    mode = "tabs",
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "NvimTree",
        text = "Finder",
        highlight = "Directory",
      },
    },
  },
}
