-- File:        plugins.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     05 Aug 2021
-- SPDX-License-Identifier: MIT

local lazy = require("lazy")

lazy.setup({
  -- Colors
  {
    -- nightfox
    "EdenEast/nightfox.nvim",
    -- kanagawa
    "rebelot/kanagawa.nvim",
    -- rose-pine
    { 'rose-pine/neovim', name = 'rose-pine' },
    -- everforest
    "sainnhe/everforest",
    -- sourcerer
    "xero/sourcerer.vim",
  },

  -- Editing
  {
    -- Fast and familiar per-line commenting
    "echasnovski/mini.comment",
    -- Automatically manage character pairs
    "echasnovski/mini.pairs",
    -- Fast and feature-rich surround actions
    "echasnovski/mini.surround",
    -- Modal multiple cursors
    "mg979/vim-visual-multi",
    -- Enhanced increment/decrement
    "monaqa/dial.nvim",
    -- Whitespace management
    "kaplanz/nvim-retrail",
  },

  -- Extensions
  {
    -- Searches, substitutions, and abbreviations
    "tpope/vim-abolish",
    -- Unix file manipulation
    "tpope/vim-eunuch",
    -- Repeat plugin maps
    "tpope/vim-repeat",
    -- Heuristically set buffer options
    "tpope/vim-sleuth",
    -- Handy bracket mappings
    "tpope/vim-unimpaired",
    -- Additional text objects
    "wellle/targets.vim",
    -- Handle line numbers in file names
    "wsdjeg/vim-fetch",
  },

  -- Completion
  {
    -- Auto completion
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        -- Vim-builtin
        "f3fora/cmp-spell",
        "hrsh7th/cmp-calc",
        -- Neovim-builtin
        "hrsh7th/cmp-nvim-lua",
        -- Snippets
        "dcampos/cmp-snippy",
        -- Language Server Protocol
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        -- Filesystem
        "hrsh7th/cmp-path",
      },
    },

    -- Snippet engine
    {
      "dcampos/nvim-snippy",
      dependencies = {
        "honza/vim-snippets",
      },
    },
  },

  -- Language Server Protocol
  {
    -- Use Neovim as a language server
    {
      "jose-elias-alvarez/null-ls.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
    -- Lsp common configurations
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
      },
    },
    -- Add pictograms to LSP
    "onsails/lspkind-nvim",
  },

  -- Language Tools
  {
    -- Vim configuration for Rust
    "rust-lang/rust.vim",
  },

  -- Packages
  {
    -- Portable package manager for Neovim
    {
      "williamboman/mason.nvim",
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
      },
    },
  },

  -- Syntax
  {
    -- Treesitter configurations
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      dependencies = {
        -- Show code context
        "nvim-treesitter/nvim-treesitter-context",
        -- Syntax aware text-objects
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
    },
  },

  -- User Interface
  {
    -- Snazzy bufferline
    {
      "akinsho/bufferline.nvim",
      dependencies = {
        "kyazdani42/nvim-web-devicons",
      },
    },
    -- Create custom submodes and menus
    "anuvyklack/hydra.nvim",
    -- Create key bindings that stick
    "folke/which-key.nvim",
    -- UI for nvim-lsp progress
    "j-hui/fidget.nvim",
    -- Ultra fold in Neovim
    {
      "kevinhwang91/nvim-ufo",
      config = function()
        require("ufo").setup {
          open_fold_hl_timeout = 0,
        }
      end,
      dependencies = {
        "kevinhwang91/promise-async",
      },
    },
    -- File explorer written in lua
    {
      "kyazdani42/nvim-tree.lua",
      dependencies = {
        "kyazdani42/nvim-web-devicons",
      },
    },
    -- Dim inactive windows
      "levouh/tint.nvim",
    -- Show vertical lines for indent
    {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("indent_blankline")
      end,
    },
    -- Blazing fast statusline
    {
      "nvim-lualine/lualine.nvim",
      dependencies = {
        "kyazdani42/nvim-web-devicons",
        opt = true
      },
    },
    -- Fuzzy finder over lists
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
        },
      },
    },
    -- Improve the default vim.ui interfaces
    "stevearc/dressing.nvim",
  },

  -- Version Control Systems
  {
    -- Git integration for buffers
    {
      "lewis6991/gitsigns.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
  },
}, {
  ui = {
    border = "rounded",
  },
})
