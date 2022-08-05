-- File:        gitsigns.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     19 Oct 2021
-- SPDX-License-Identifier: MIT

require("gitsigns").setup {
  -- Set symbols in the sign column.
  signcolumn = true,
  -- Set line number highlights.
  numhl      = false,
  -- Callback called when attaching to a buffer.
  on_attach  = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Set up keymaps
    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, { expr = true })
    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, { expr = true })

    -- Actions
    map({ "n", "v" }, "<Leader>hs", gs.stage_hunk)
    map({ "n", "v" }, "<Leader>hr", gs.reset_hunk)
    map("n", "<Leader>hS", gs.stage_buffer)
    map("n", "<Leader>hu", gs.undo_stage_hunk)
    map("n", "<Leader>hR", gs.reset_buffer)
    map("n", "<Leader>hp", gs.preview_hunk)
    map("n", "<Leader>hb", function() gs.blame_line { full = true } end)
    map("n", "<Leader>tb", gs.toggle_current_line_blame)
    map("n", "<Leader>hd", gs.diffthis)
    map("n", "<Leader>hD", function() gs.diffthis("~") end)
    map("n", "<Leader>td", gs.toggle_deleted)

    -- Text object
    map({ "o", "x" }, "ih", gs.select_hunk)
  end,
}
