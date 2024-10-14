--- @mod user.lsp

local M = {}

--- Gets a 'ClientCapabilities' object, describing the LSP client capabilities
--- Extends the object with capabilities provided by plugins.
--- @return lsp.ClientCapabilities
function M.make_client_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- Add com_nvim_lsp capabilities.
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  -- Enable preliminary support for workspace/didChangeWatchedFiles.
  capabilities = vim.tbl_deep_extend('keep', capabilities, {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
      configuration = true,
    },
  })
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  -- Add any additional plugin capabilities here.
  -- Make sure to follow the instructions provided in the plugin's docs.
  return capabilities
end

-- NOTE: Wasted a bunch of time trying to figure out why `gq` was not working in
-- Rust files after enabling LSP formatting for that language. Turns out it also
-- didn't work in Lua files, and possibly other languages for which the LSP
-- supports 'textDocument/rangeFormatting'.
--
-- There's multiple reasons for this:
--
--   1. https://github.com/neovim/neovim/pull/19677 changes Neovim's LSP
--      behavior to set `formatexpr` to `v:lua.vim.lsp.formatexpr()` which calls
--      into the LSP to format the selected text.
--   2. https://github.com/neovim/neovim/pull/23681 adds support for a new
--      handler `client/registerCapability` which sets the same defaults
--      as (1) and therefore also overrides `formatexpr`.
--
-- While (1) can be worked around by wrapping `on_attach(…)` and restoring the
-- `formatexpr` value after Neovim's LSP code changes should work so that the
-- config can be fine-tuned by language, (2) reintroduces the issue when the LSP
-- is first initialized. This means that the first buffer in that language (the
-- one that spawns the LSP server for that language), will have `formatexpr =
-- "v:lua.vim.lsp.formatexpr()"` while any successive buffer will not -- because
-- the code involved in (2) is only called when initializing the LSP server.
--
-- A solution for (2) is to wrap the 'client/registerCapability' and restore
-- `formatexpr`, much like `on_attach`. Unlike `on_attach`, this is a global
-- handler and we need to explicitely check for the languages/LSP servers that
-- do not support 'textDocument/rangeFormatting' the way we want (e.g. ignore
-- comments).
--
-- At this point, the solution involves too much workaround code that I care to
-- maintain. It also appears that `:h gw` is equivalent to `:h gq`, but ignores
-- `formatexpr` which seems to imply that I was abusing `gq` when what I really
-- wanted was `gw`, and that it all boils down to a skill issue.
--
-- Conclusion: I gave up on working around the default behavior, and decided to
-- "git gud". I'll keep the code below commented for documentation purposes.

--[[
M.on_attach = function(...)
  lsp.on_attach(...)

  -- Fixes `gq` being borked: https://github.com/neovim/neovim/pull/19677.
  -- rust-analyzer does not support formatting lines with `gq`.
  vim.bo[bufnr].formatexpr = nil

  -- NOTE: but it actually doesn't… read on.
end

-- https://github.com/neovim/neovim/pull/23681 introduces a regression for LSP
-- calling into the `client/registerCapability` handler which unconditionally
-- calls `vim.lsp._set_defaults(…)` without giving users a chance to negate its
-- effects:
-- https://github.com/neovim/neovim/blob/b7e896671500a6e9a0c773bc6bac2d073e588eba/runtime/lua/vim/lsp/handlers.lua#L118
local client_registerCapability = vim.lsp.handlers['client/registerCapability']
vim.lsp.handlers['client/registerCapability'] = function(_, __, ctx)
  client_registerCapability(_, __, ctx)

  local client_id = ctx.client_id
  local client = assert(vim.lsp.get_client_by_id(client_id))

  for bufnr, _ in pairs(client.attached_buffers) do
    vim.bo[bufnr].formatexpr = nil
  end
end
--]]

-- { error = '󰅗 󰅙 󰅘 󰅚 󱄊 ', warn = '󰀨 󰗖 󱇎 󱇏 󰲼 ', info = '󰋽 󱔢 ', hint = '󰲽 ' },
M.diagnostic_signs = {
  Error = '󰅚 ',
  Warn = '󰗖 ',
  Info = '󰋽 ',
  Hint = '󰲽 ',
}

local preview_location_callback = function(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  local buf, _ = vim.lsp.util.preview_location(result[1], { border = 'rounded' })
  if buf then
    local cur_buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].filetype = vim.bo[cur_buf].filetype
  end
end

local peek_definition = function()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

local peek_type_definition = function()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/typeDefinition', params, preview_location_callback)
end

-- Bordered popups.
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

M.on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Mappings.
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', '<Leader>gt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<Leader>pd', peek_definition, opts)
  vim.keymap.set('n', '<Leader>pt', peek_type_definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<M-CR>', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set({ 'n', 'v' }, '<Leader>f', function()
    vim.lsp.buf.format { async = true }
  end, opts)

  if client.server_capabilities.inlayHintProvider then
    vim.keymap.set('n', '<space>h', function()
      local current_setting = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
      vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
    end, opts)
  end
end

return M
