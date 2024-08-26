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
