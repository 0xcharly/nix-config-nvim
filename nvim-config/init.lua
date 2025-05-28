-- Configure Neovim diagnostic messages

-- Alternatives: { error = '󰅗 󰅙 󰅘 󰅚 󱄊 ', warn = '󰀨 󰗖 󱇎 󱇏 󰲼 ', info = '󰋽 󱔢 ', hint = '󰲽 ' },
local signs = {
  text = {
    [vim.diagnostic.severity.ERROR] = '󰅚 ',
    [vim.diagnostic.severity.WARN] = '󰗖 ',
    [vim.diagnostic.severity.INFO] = '󰋽 ',
    [vim.diagnostic.severity.HINT] = '󰲽 ',
  },
  numhl = {
    [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
    [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
    [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
    [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
  },
}

-- @param diagnostic vim.Diagnostic
local function diagnostic_format(diagnostic)
  return string.format((signs.text[diagnostic.severity] or '■') .. ' %s', diagnostic.message)
end

vim.diagnostic.config {
  -- NOTE: Choose between:
  --   - virtual_text (inline diagnostics)
  --   - virtual_lines (cascading diagnostics)
  virtual_text = {
    spacing = 2,
    prefix = '',
    format = diagnostic_format,
  },
  -- virtual_lines = {
  --   current_line = false, -- Show diagnostics for all lines.
  --   format = diagnostic_format,
  -- },
  signs = signs,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'if_many',
    header = '',
    prefix = '',
  },
}

-- Keep this at the very top. Changing this will erase all <Leader> and
-- <LocalLeader> bindings already defined.
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Native plugins.
vim.cmd.filetype('plugin', 'indent', 'on')
