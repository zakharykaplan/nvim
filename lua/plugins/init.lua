-- File:        init.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     05 Aug 2021
-- SPDX-License-Identifier: MIT
-- Vim:         set fdl=0 fdm=marker:

-- This file can be loaded by calling `lua require("plugins")` in your init.lua
-- Bootstrap {{{
local bootstrap
do
  -- Install packer if not currently installed
  local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if vim.fn.empty(vim.fn.glob(path)) > 0 then
    bootstrap = vim.fn.system {
      "git",
      "clone",
      "--depth=1",
      "https://github.com/wbthomason/packer.nvim",
      path
    }
    vim.cmd.packadd("packer.nvim")
  end

  -- Automatically run `:PackerCompile` whenever this file is updated
  vim.cmd [[
    augroup Plugins
      autocmd!
      autocmd BufWritePost lua/**/*.lua source <afile> | PackerCompile
    augroup end
  ]]
end
-- }}}

-- Packer startup
return require("packer").startup(function(use)
  -- Colorscheme {{{
  do
    use "EdenEast/nightfox.nvim"
    use "rebelot/kanagawa.nvim"
    use "sainnhe/everforest"
    use "xero/sourcerer.vim"
  end
  -- }}}

  -- Editing {{{
  do
    -- Edit sandwiched textobjects
    use "machakann/vim-sandwich"
    -- Smart and powerful comments
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup {
          mappings = {
            extended = true,
          },
        }
      end
    }
    -- Super powerful autopairs
    use {
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
        require("nvim-autopairs").setup {}
        -- Interoperability with nvim-cmp
        do
          -- If you want insert `(` after select function or method item
          local autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on(
            "confirm_done",
            autopairs.on_confirm_done {}
          )
        end
      end,
      event = "InsertEnter",
    }
    -- Whitespace management
    use {
      "zakharykaplan/nvim-retrail",
      config = function()
        require("retrail").setup {}
      end,
    }
  end
  -- }}}

  -- Extensions {{{
  do
    -- Neovim {{{
    do
      -- Enhanced increment/decrement
      use {
        "monaqa/dial.nvim",
        config = function()
          require("plugins.dial")
        end,
      }
      -- Modal multiple cursors
      use {
        "mg979/vim-visual-multi",
        config = function()
          vim.g.VM_leader = "\\"
        end,
      }
      -- Searches, substitutions, and abbreviations
      use "tpope/vim-abolish"
      -- Unix file manipulation
      use "tpope/vim-eunuch"
      -- Repeat plugin maps
      use "tpope/vim-repeat"
      -- Heuristically set buffer options
      use "tpope/vim-sleuth"
      -- Handy bracket mappings
      use "tpope/vim-unimpaired"
      -- Additional text objects
      use "wellle/targets.vim"
      -- Handle line numbers in file names
      use "wsdjeg/vim-fetch"
    end
    -- }}}

    -- Git {{{
    do
      -- Git integration for buffers
      use {
        "lewis6991/gitsigns.nvim",
        config = function()
          require("plugins.gitsigns")
        end,
        requires = "nvim-lua/plenary.nvim",
      }
      -- Magit for Neovim
      use {
        "TimUntersberger/neogit",
        config = function()
          require("neogit").setup {
            integrations = {
              diffview = true,
            },
          }
        end,
        requires = {
          "nvim-lua/plenary.nvim",
          "sindrets/diffview.nvim",
        },
      }
    end
    -- }}}
  end
  -- }}}

  -- Intelligence {{{
  do
    -- Completion {{{
    do
      -- Auto completion plugin
      use {
        "hrsh7th/nvim-cmp",
        config = function()
          require("plugins.cmp")
        end,
        requires = {
          -- Vim-builtin
          "f3fora/cmp-spell",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-calc",
          "hrsh7th/cmp-omni",
          -- Neovim-builtin
          "hrsh7th/cmp-nvim-lua",
          "ray-x/cmp-treesitter",
          -- Snippets
          "dcampos/cmp-snippy",
          -- Language Server Protocol
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-nvim-lsp-document-symbol",
          "hrsh7th/cmp-nvim-lsp-signature-help",
          -- Filesystem
          "hrsh7th/cmp-path",
          "lukas-reineke/cmp-rg",
          -- Extensions
          "hrsh7th/cmp-cmdline",
        },
      }
    end
    -- }}}

    -- Language {{{
    do
      use {
        "rust-lang/rust.vim",
        ft = "rust",
      }
    end
    -- }}}

    -- LSP {{{
    do
      -- A pretty list for showing diagnostics
      use {
        "folke/trouble.nvim",
        config = function()
          local trouble = require("trouble")
          -- Call setup
          trouble.setup {}
          -- Toggle trouble
          vim.keymap.set("n", "<Space>d", trouble.toggle, {
            noremap = true,
            silent = true
          })
        end,
        requires = "kyazdani42/nvim-web-devicons",
      }
      -- Ui for nvim-lsp progress
      use {
        "j-hui/fidget.nvim",
        config = function()
          require("fidget").setup {
            text = {
              -- Character shown when all tasks are completed
              done = "✓",
            }
          }
        end,
      }
      -- Use Neovim as a language server
      use {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("plugins.null-ls")
        end,
        requires = "nvim-lua/plenary.nvim",
      }
      -- Lsp common configurations
      use {
        "neovim/nvim-lspconfig",
        config = function()
          require("plugins.lspconfig")
        end,
      }
      -- Add pictograms to LSP
      use "onsails/lspkind-nvim"
    end
    -- }}}

    -- Snippets {{{
    do
      -- Snippet engine
      use {
        "dcampos/nvim-snippy",
        config = function()
          require("plugins.snippy")
        end,
        requires = "honza/vim-snippets",
      }
    end
    -- }}}

    -- Treesitter {{{
    do
      -- Treesitter configurations
      use {
        "nvim-treesitter/nvim-treesitter",
        config = function()
          require("plugins.nvim-treesitter")
        end,
        run = ":TSUpdate",
      }
      -- Show code context
      use "nvim-treesitter/nvim-treesitter-context"
      -- Syntax aware text-objects
      use "nvim-treesitter/nvim-treesitter-textobjects"
      -- Auto-close and auto-rename markup tags
      use "windwp/nvim-ts-autotag"
    end
    -- }}}
  end
  -- }}}

  -- Packages {{{
  do
    -- Neovim plugin manager
    -- NOTE: Packer can manage itself
    use "wbthomason/packer.nvim"
    -- Portable package manager for Neovim
    use {
      "williamboman/mason.nvim",
      config = function()
        require("plugins.mason")
      end,
      requires = "williamboman/mason-lspconfig.nvim",
    }
  end
  -- }}}

  -- User Interface {{{
  do
    -- Snazzy bufferline
    use {
      "akinsho/bufferline.nvim",
      config = function()
        require("plugins.bufferline")
      end,
      requires = "kyazdani42/nvim-web-devicons",
    }
    -- Create custom submodes and menus
    use {
      "anuvyklack/hydra.nvim",
      config = function()
        require("plugins.hydra")
      end,
    }
    -- Create key bindings that stick
    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {}
      end,
    }
    -- Ultra fold in Neovim
    use {
      "kevinhwang91/nvim-ufo",
      config = function()
        require("ufo").setup {
          open_fold_hl_timeout = 0,
        }
      end,
      requires = "kevinhwang91/promise-async"
    }
    -- File explorer written in lua
    use {
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("plugins.nvim-tree")
      end,
      cmd = "NvimTreeToggle",
      keys = {
        { "n", "<Leader>n" },
        { "n", "<Leader>N" },
      },
      requires = "kyazdani42/nvim-web-devicons",
    }
    -- Show vertical lines for indent
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("indent_blankline")
      end,
    }
    -- Blazing fast statusline
    use {
      "nvim-lualine/lualine.nvim",
      config = function()
        require("plugins.lualine")
      end,
      requires = {
        "kyazdani42/nvim-web-devicons",
        opt = true
      },
    }
    -- Fuzzy finder over lists
    use {
      "nvim-telescope/telescope.nvim",
      config = function()
        require("plugins.telescope")
      end,
      requires = {
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make",
          config = function()
            require("telescope").load_extension("fzf")
          end,
        },
        {
          "nvim-telescope/telescope-packer.nvim",
          config = function()
            require("telescope").load_extension("packer")
          end,
        },
        {
          "nvim-telescope/telescope-project.nvim",
          config = function()
            require("telescope").load_extension("project")
          end,
        },
      },
    }
    -- Improve the default vim.ui interfaces
    use "stevearc/dressing.nvim"
  end
  -- }}}

  -- Automatically set up your configuration after cloning packer.nvim
  -- (Put this at the end after all plugins)
  if bootstrap then
    require("packer").sync()
  end
end)
