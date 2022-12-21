-- File:        telescope.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

local telescope = require("telescope")
local builtin   = require("telescope.builtin")

telescope.load_extension("fzf")

-- Require module setup
telescope.setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    -- Determines the direction "better" results are sorted towards.
    sorting_strategy = "ascending",
    -- Determines the default layout of Telescope pickers.
    layout_strategy = "flex",
    -- Determines the default configuration values for layout strategies.
    layout_config = {
      -- Horizontal layout has two columns, one for the preview and one for the
      -- prompt and results.
      horizontal = {
        prompt_position = "top",
      },
      -- Vertical layout stacks the items on top of each other.
      vertical = {
        mirror = true,
        prompt_position = "top",
      },
    },
    -- Configure winblend for telescope floating windows.
    winblend = 10,
    -- The character(s) that will be shown in front of Telescope's prompt.
    prompt_prefix = " ",
    -- The character(s) that will be shown in front of the current selection.
    selection_caret = "» ",
    -- Your mappings to override telescope's default mappings.
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        -- ["<C-h>"] = "which_key",
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
}

-- Configure mappings
do
  -- Set up keymaps
  -- Builtins
  vimrc.map("n", "<F1>", builtin.help_tags,   nil, "List help tags")
  vimrc.map("n", "<M-b>", builtin.buffers,    nil, "List buffers")
  vimrc.map("n", "<M-f>", builtin.find_files, nil, "List files")
  vimrc.map("n", "<M-F>", function()
    builtin.find_files { hidden = true }
  end,                             nil, "List hidden files")
  vimrc.map("n", "<M-o>", builtin.oldfiles,   nil, "List oldfiles")
  vimrc.map("n", "<M-g>", builtin.live_grep,  nil, "Live grep")
  vimrc.map("n", "<M-s>", builtin.builtin,    nil, "Launch telescope")
  vimrc.map("n", "<M-S>", builtin.resume,     nil, "Resume telescope")
end
