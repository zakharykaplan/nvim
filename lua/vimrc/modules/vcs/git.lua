-- File:        git.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     19 Oct 2021
-- SPDX-License-Identifier: MIT

local gitsigns = require("gitsigns")

gitsigns.setup {
  -- Set symbols in the sign column.
  signcolumn = true,
  -- Set line number highlights.
  numhl      = false,
  -- Callback called when attaching to a buffer.
  on_attach  = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Set up keymaps
    local function map(mode, lhs, rhs, opts, hint)
      opts = opts or { desc = hint }
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, { expr = true }, "Go to next hunk")
    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, { expr = true }, "Go to previous hunk")

    -- Actions
    map({ "n", "v" }, "<Leader>hs", gs.stage_hunk,       nil, "Stage hunk")
    map({ "n", "v" }, "<Leader>hr", gs.reset_hunk,       nil, "Reset hunk")
    map("n", "<Leader>hS",          gs.stage_buffer,     nil, "Stage buffer")
    map("n", "<Leader>hu",          gs.undo_stage_hunk,  nil, "Stage hunk")
    map("n", "<Leader>hR",          gs.reset_buffer,     nil, "Reset buffer")
    map("n", "<Leader>hp",          gs.preview_hunk,     nil, "Preview hunk")
    map("n", "<Leader>hb", function()
      gs.blame_line { full = true }
    end,                                                 nil, "Blame line")
    map("n", "<Leader>tb", gs.toggle_current_line_blame, nil, "Toggle blame line")
    map("n", "<Leader>hd", gs.diffthis,                  nil, "Diff this file")
    map("n", "<Leader>hD", function()
      gs.diffthis("~")
    end,                                                 nil, "Diff last commit")
    map("n", "<Leader>td", gs.toggle_deleted,            nil, "Toggle deleted")

    -- Text object
    map({ "o", "x" }, "ih", gs.select_hunk,              nil, "Select hunk")
  end,
}
