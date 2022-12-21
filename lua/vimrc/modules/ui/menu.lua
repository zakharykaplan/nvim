-- File:        menu.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     18 Jul 2022
-- SPDX-License-Identifier: MIT

local gitsigns  = require("gitsigns")
local gitconf   = require("gitsigns.config").config
local hydra     = require("hydra")
local which_key = require("which-key")

-- Create custom submodes and menus
do
  local hint

  -- Side scroll
  hydra {
    name = "Side scroll",
    mode = "n",
    body = "z",
    heads = {
      { "h", "5zh" },
      { "l", "5zl", { desc = "←/→" } },
      { "H", "zH" },
      { "L", "zL", { desc = "half screen ←/→" } },
    }
  }

  -- Git submode
  hint = [[
  ^  ^ ^              ^ ^                    ^ ^                 ^ ^                   ^
  ^  _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line       ^
  ^  _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full  ^
  ^  ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file   ^
  ^  ^ ^              ^ ^                    ^ ^                 ^ ^                   ^
  ]]

  hydra {
    name = "Git",
    hint = hint,
    config = {
      color = "pink",
      invoke_on_body = true,
      hint = {
        border = "rounded"
      },
      on_enter = function()
        vim.cmd("silent! %foldopen!")
        vim.bo.modifiable = false
        vim.b.hydra = {
          vim = {
            timeoutlen = vim.o.timeoutlen,
          },
          gitsigns = {
            signs  = gitconf.signcolumn,
            linehl = gitconf.linehl,
          }
        }
        vim.o.timeoutlen = 50
        gitsigns.toggle_signs(true)
        gitsigns.toggle_linehl(true)
      end,
      on_exit = function()
        vim.opt.timeoutlen = vim.b.hydra.vim.timeoutlen
        gitsigns.toggle_deleted(false)
        gitsigns.toggle_signs(vim.b.hydra.gitsigns.signs)
        gitsigns.toggle_linehl(vim.b.hydra.gitsigns.linehl)
        vim.b.hydra = nil
      end,
    },
    mode = { "n", "x" },
    body = "<Leader>g",
    heads = {
      { "J", function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() gitsigns.next_hunk() end)
        return "<Ignore>"
      end,
        { expr = true, desc = "next hunk" }
      },
      { "K", function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() gitsigns.prev_hunk() end)
        return "<Ignore>"
      end,
        { expr = true, desc = "prev hunk" }
      },
      { "s", gitsigns.stage_hunk,
        { silent = true, desc = "stage hunk" }
      },
      { "u", gitsigns.undo_stage_hunk,
        { desc = "undo last stage" }
      },
      { "S", gitsigns.stage_buffer,
        { desc = "stage buffer" }
      },
      { "p", gitsigns.preview_hunk,
        { desc = "preview hunk" }
      },
      { "d", gitsigns.toggle_deleted,
        { nowait = true, desc = "toggle deleted" }
      },
      { "b", gitsigns.blame_line,
        { desc = "blame" }
      },
      { "B", function() gitsigns.blame_line { full = true } end,
        { desc = "blame show full" }
      },
      { -- Show the base of the file
        "/", gitsigns.show,
        { exit = true, desc = "show base file" }
      },
      { "q", nil, { exit = true, nowait = true, desc = "exit" } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    }
  }

  -- Vim options
  hint = [[
  ^                  ^  ^ ^ ^^^^^        Options           ^
  ^⠀⠀⠀⢀⣴⣷⡀⠀⠀⠀⠀⠀⢸⣦⡀⠀⠀⠀^  ^ ^ ^^^^^                          ^
  ^⠀⠀⡐⣿⣿⣿⣿⣄⠀⠀⠀⠀⢸⣿⣿⣦⡀⠀^  _v_ %{ve}^^^ virtual edit          ^
  ^⠀⢸⠈⢎⢿⣿⣿⣿⣦⠀⠀⠀⢸⣿⣿⣿⡇⠀^  _i_ %{list}^ invisible characters  ^
  ^⠀⢸⠀⠀⠢⡻⣿⣿⣿⣷⡀⠀⢸⣿⣿⣿⡇⠀^  _s_ %{spell} spell                 ^
  ^⠀⢸⠀⠀⠀⡇⠙⣿⣿⣿⣿⣄⢸⣿⣿⣿⡇⠀^  _w_ %{wrap}^ wrap                  ^
  ^⠀⢸⠀⠀⠀⡇⠀⠈⢿⣿⣿⣿⣮⢻⣿⣿⡇⠀^  _c_ %{cul}^^ cursor line           ^
  ^⠀⢸⠀⠀⠀⡇⠀⠀⠀⠻⣿⣿⣿⣷⡹⣿⡇⠀^  _n_ %{nu}^^^ number                ^
  ^⠀⠈⠢⡀⠀⡇⠀⠀⠀⠀⠙⣿⣿⣿⣿⠜⠁⠀^  _r_ %{rnu}^^ relative number       ^
  ^⠀⠀⠀⠈⠢⡇⠀⠀⠀⠀⠀⠈⢿⠟⠁⠀⠀⠀^  ^ ^ ^^^^^                          ^
  ^                  ^      ^^^^^               _q_: exit  ^
  ]]

  hydra {
    name = "Options",
    hint = hint,
    config = {
      color = "amaranth",
      invoke_on_body = true,
      hint = {
        border = "rounded",
        position = "middle"
      }
    },
    mode = { "n", "x" },
    body = "<Leader>o",
    heads = {
      {
        "n",
        function()
          if vim.o.number == true then
            vim.o.number = false
          else
            vim.o.number = true
          end
        end, { desc = "number" }
      },
      {
        "r",
        function()
          if vim.o.relativenumber == true then
            vim.o.relativenumber = false
          else
            vim.o.number = true
            vim.o.relativenumber = true
          end
        end, { desc = "relativenumber" }
      },
      {
        "v",
        function()
          if vim.o.virtualedit == "all" then
            vim.o.virtualedit = "block"
          else
            vim.o.virtualedit = "all"
          end
        end, { desc = "virtualedit" }
      },
      {
        "i",
        function()
          if vim.o.list == true then
            vim.o.list = false
          else
            vim.o.list = true
          end
        end, { desc = "show invisible" }
      },
      {
        "s",
        function()
          if vim.o.spell == true then
            vim.o.spell = false
          else
            vim.o.spell = true
          end
        end, { desc = "spell" }
      },
      {
        "w",
        function()
          if vim.o.wrap == true then
            vim.o.wrap = false
          else
            vim.o.wrap = true
          end
        end, { desc = "wrap" }
      },
      {
        "c",
        function()
          if vim.o.cursorline == true then
            vim.o.cursorline = false
          else
            vim.o.cursorline = true
          end
        end, { desc = "cursor line" }
      },
      { "<Esc>", nil, { exit = true, desc = false } },
      { "<CR>", nil, { exit = true, desc = false } },
      { "q", nil, { exit = true, desc = false } },
    }
  }

  -- Window management
  hint = [[
  ^  ^^^^^^              ^^^^^^ ^ ^^^^ ^          ^^^ ^ ^ ^                ^
  ^  ^^^^^^     Move     ^^^^^^ ^ ^^^^  Resize   ^^^^ ^ ^     Split     ^  ^
  ^  ^^^^^^--------------^^^^^^ ^ ^^^^-----------^^^^ ^ ^---------------^  ^
  ^  ^ ^ _k_ ^ ^    ^ ^ _K_ ^ ^ ^ ^   ^ ^ _+_ ^ ^   ^ ^ _s_: horizontally  ^
  ^  _h_ ^ ^ _l_    _H_ ^ ^ _L_ ^ ^   _<_ ^ ^ _>_   ^ ^ _v_: vertically    ^
  ^  ^ ^ _j_ ^ ^    ^ ^ _J_ ^ ^ ^ ^   ^ ^ _-_ ^ ^   ^ ^ _o_: only          ^
  ^  ^^^^^^cursor  window^^^^^^ ^ ^^^_=_: equalize^^^ ^ _q_: close         ^
  ^  ^^^^^^              ^^^^^^ ^ ^^^^ ^          ^^^ ^ ^ ^                ^
  ]]

  hydra {
    name = "Windows",
    hint = hint,
    config = {
      invoke_on_body = true,
      hint = {
        border = "rounded",
        offset = -1
      }
    },
    mode = "n",
    body = "<Leader>w",
    heads = {
      -- Move cursor
      { "h", "<C-w>h" },
      { "j", "<C-w>j" },
      { "k", "<C-w>k" },
      { "l", "<C-w>l" },
      { "w", "<C-w>w", { exit = true, desc = false } },
      { "<C-w>", "<C-w>w", { exit = true, desc = false } },
      { "W", "<C-w>W", { exit = true, desc = false } },

      -- Move window
      { "H", "<C-w>H" },
      { "J", "<C-w>J" },
      { "K", "<C-w>K" },
      { "L", "<C-w>L" },

      -- Resize
      { "+", "<C-w>+" },
      { "-", "<C-w>-" },
      { "<", "<C-w><" },
      { ">", "<C-w>>" },
      { "=", "<C-w>=", { desc = "equalize" } },

      -- Split current
      { "s", "<C-w>s" }, { "<C-s>", "<C-w><C-s>", { desc = false } },
      { "v", "<C-w>v" }, { "<C-v>", "<C-w><C-v>", { desc = false } },

      -- Split into tab
      { "T", "<C-w>T", { desc = false } },

      -- Close current
      { "q", "<C-w>q", { desc = "close" } },
      { "<C-q>", "<C-w>q", { desc = false } },

      -- Close others
      { "o", "<C-w>o", { exit = true, desc = "only" } },
      { "<C-o>", "<C-w>o", { exit = true, desc = false } },
    }
  }
end

-- Create key bindings that stick
which_key.setup {}
