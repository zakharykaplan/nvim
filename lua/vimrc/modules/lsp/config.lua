-- File:        config.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

local cmp       = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")
local mason     = require("mason-lspconfig")
local telescope = require("telescope.builtin")

-- Prepare capabilities, handlers, and on_attach
local capabilities
do
  -- Add additional capabilities supported by nvim-cmp
  capabilities = vim.lsp.protocol.make_client_capabilities()
  vim.tbl_deep_extend("force", capabilities, cmp.default_capabilities())
end

local handlers
do
  -- Style of (optional) window border. This can either be a string or
  -- an array.
  -- The string values are:
  -- • "none": No border (default).
  -- • "single": A single line box.
  -- • "double": A double line box.
  -- • "rounded": Like "single", but with rounded corners ("╭" etc.).
  -- • "solid": Adds padding by a single whitespace cell.
  -- • "shadow": A drop shadow effect by blending with the background.
  local border = "rounded"

  -- LSP settings (for overriding per client)
  handlers = {
    ["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
      -- Style of (optional) window border.
      border = border,
    }),
    ["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
      -- Style of (optional) window border.
      border = border,
    }),
  }

  -- Customize how diagnostics are displayed
  vim.diagnostic.config {
    -- Use virtual text for diagnostics.
    virtual_text = {
      -- Format a diagnostic as text used to display it.
      format = function(diagnostic)
        local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
        if diagnostic.lnum <= lnum and lnum <= diagnostic.end_lnum then
          return diagnostic.message
        end
      end,
    },
    -- Options for floating windows.
    float = {
      -- Style of (optional) window border.
      border = border,
      -- Enable focus by user actions.
      focusable = false,
      -- Configure the appearance of the window.
      style = "minimal",
      -- Include the diagnostic source in the message.
      source = "if_many",
    },
    -- Sort diagnostics by severity.
    severity_sort = true,
  }

  -- Change diagnostic symbols in the sign column (gutter)
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Show line diagnostics in virtual text
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = function() vim.diagnostic.show() end,
  })
end

local on_attach
do
  -- Use an `on_attach` function to only map the following keys...
  -- ... after the language server attaches to the current buffer
  on_attach = function(client, bufnr)
    -- Highlight symbol under cursor
    if client.server_capabilities.documentHighlightProvider then
      vim.cmd [[
        hi! LspReferenceRead cterm=bold
        hi! LspReferenceText cterm=bold
        hi! LspReferenceWrite cterm=bold
      ]]
      local group = vim.api.nvim_create_augroup("LspDocumentHighlight", {})
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vimrc.map("n", "<Space>e", vim.diagnostic.open_float,     nil, "Show diagnostics")
    vimrc.map("n", "<Space>q", vim.diagnostic.setloclist,     nil, "Set diagnostics")
    vimrc.map("n", "<Space>so", function()
      telescope.lsp_document_symbols()
    end,                                                nil, "List symbols in buffer")
    vimrc.map("n", "<Space>wa", vim.lsp.buf.add_workspace_folder)
    vimrc.map("n", "<Space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
    vimrc.map("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder)
    vimrc.map("n", "K", vim.lsp.buf.hover)
    vimrc.map("n", "]d", vim.diagnostic.goto_next,            nil, "Go to next diagnostic")
    vimrc.map("n", "[d", vim.diagnostic.goto_prev,            nil, "Go to previous diagnostic")

    -- Set some key bindings conditional on server capabilities
    if client.server_capabilities.codeActionProvider then
      vimrc.map("n", "<Space>ca", vim.lsp.buf.code_action,    nil, "Perform code action")
      vimrc.map("v", "<Space>ca", vim.lsp.buf.code_action,    nil, "Perform code action")
    end
    if client.server_capabilities.declarationProvider then
      vimrc.map("n", "gD", vim.lsp.buf.declaration,           nil, "Jump to declaration")
    end
    if client.server_capabilities.definitionProvider then
      vimrc.map("n", "gd", vim.lsp.buf.definition,            nil, "Jump to definition")
    end
    if client.server_capabilities.documentFormattingProvider then
      vimrc.map("n", "<Space>f", function()
        vim.lsp.buf.format { async = true }
      end,                                              nil, "Format buffer")
    end
    if client.server_capabilities.implementationProvider then
      vimrc.map("n", "gi", vim.lsp.buf.implementation,        nil, "List implementations")
    end
    if client.server_capabilities.referencesProvider then
      vimrc.map("n", "gr", vim.lsp.buf.references,            nil, "List references")
    end
    if client.server_capabilities.renameProvider then
      vimrc.map("n", "<Space>rn", vim.lsp.buf.rename,         nil, "Rename symbol")
    end
    if client.server_capabilities.signatureHelpProvider then
      vimrc.map("n", "<C-k>", vim.lsp.buf.signature_help,     nil, "Show signature help")
    end
    if client.server_capabilities.typeDefinitionProvider then
      vimrc.map("n", "<Space>D", vim.lsp.buf.type_definition, nil, "Jump to type definition")
    end
  end
end

-- Override the default configuration to be applied to all servers
lspconfig.util.default_config = vim.tbl_extend(
  "force",
  lspconfig.util.default_config,
  {
    capabilities = capabilities,
    handlers     = handlers,
    on_attach    = on_attach,
  }
)


-- Registers the provided `handlers`, to be called by mason when an installed
-- server supported by lspconfig is ready to be setup.
mason.setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server) -- default handler (optional)
    lspconfig[server].setup {}
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ["rust_analyzer"] = function(_)
    lspconfig.rust_analyzer.setup {
      settings = {
        ["rust-analyzer"] = {
          assist = {
            emitMistUse = true,
          },
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
        }
      },
    }
  end,
  ["sumneko_lua"] = function(_)
    lspconfig.sumneko_lua.setup {
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            -- Whether third party libraries can be detected and applied
            checkThirdParty = false,
          },
        },
      },
    }
  end,
}
