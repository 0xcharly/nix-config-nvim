-- Configure Neovim diagnostic messages

local function prefix_diagnostic(prefix, diagnostic)
  return string.format(prefix .. ' %s', diagnostic.message)
end

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = '',
  })
end
local diagnostic_signs = require('user.lsp').diagnostic_signs
for name, icon in pairs(diagnostic_signs) do
  sign {
    name = 'DiagnosticSign' .. name,
    text = icon,
  }
end

-- @param diagnostic vim.Diagnostic
local function diagnostic_format(diagnostic)
  local severity = diagnostic.severity
  if severity == vim.diagnostic.severity.ERROR then
    return prefix_diagnostic(diagnostic_signs.Error, diagnostic)
  end
  if severity == vim.diagnostic.severity.WARN then
    return prefix_diagnostic(diagnostic_signs.Warn, diagnostic)
  end
  if severity == vim.diagnostic.severity.INFO then
    return prefix_diagnostic(diagnostic_signs.Info, diagnostic)
  end
  if severity == vim.diagnostic.severity.HINT then
    return prefix_diagnostic(diagnostic_signs.Hint, diagnostic)
  end
  return prefix_diagnostic('■', diagnostic)
end

vim.diagnostic.config {
  -- NOTE: Choose between virtual_text (inline diagnostics) or virtual_lines
  -- (cascading diagnostics).
  -- virtual_text = {
  --   spacing = 4,
  --   prefix = '',
  --   format = diagnostic_format,
  -- },
  virtual_lines = {
    current_line = false, -- Show diagnostics for all lines.
    format = diagnostic_format,
  },
  signs = true,
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

-- Native plugins
vim.cmd.filetype('plugin', 'indent', 'on')
vim.cmd.packadd('cfilter') -- Allows filtering the quickfix list with :cfdo
