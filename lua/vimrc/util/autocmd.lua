-- File:        autocmd.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     12 Sep 2020
-- SPDX-License-Identifier: MIT
-- Vim:         set fdl=0 fdm=marker:

-- Create an autocmd
local function autocmd(event, pattern, callback)
  vim.api.nvim_create_autocmd(event, {
    pattern  = pattern,
    callback = callback,
  })
end

-- Create an augroup
local function augroup(name, setup)
  local group = vim.api.nvim_create_augroup(name, {})
  setup(function(event, pattern, callback)
    vim.api.nvim_create_autocmd(event, {
      group    = group,
      pattern  = pattern,
      callback = callback,
    })
  end)
end

return {
  -- Create autocmds namespaced within an augroup
  augroup = augroup,
  -- Create an autocmd in any augroup
  autocmd = autocmd,
}
