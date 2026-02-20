local modes = {
  ['v'] = 'VISUAL',
  ['V'] = 'VISUAL',
  [''] = 'VISUAL',
  ['s'] = 'SELECT',
  ['S'] = 'SELECT',
  [''] = 'SELECT',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rv'] = 'REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'COMMAND',
  ['ce'] = 'COMMAND',
  ['t'] = 'TERMINAL',
}
local default_mode_icon = 'NORMAL'

local function mode(bufnr)
  if bufnr == vim.api.nvim_get_current_buf() then
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format('%s', modes[current_mode] or default_mode_icon):upper()
  end

  return default_mode_icon
end

local function filename(bufnr)
  local function buf_fname()
    local buf = '#' .. tostring(bufnr)
    return (vim.fn.expand(buf) == '' and '-- Empty --') or vim.fn.expand(buf .. ':t')
  end

  local fname = buf_fname()
  if fname == '' then
    return '-- No Name --'
  end

  return fname .. ' '
end

local function bufinfo(bufnr)
  if vim.api.nvim_get_option_value('modified', { buf = bufnr }) then
    return '[+]'
  end
  if
    not vim.api.nvim_get_option_value('modifiable', { buf = bufnr })
    or vim.api.nvim_get_option_value('readonly', { buf = bufnr })
  then
    return '[RO]'
  end
  return ''
end

local function location(bufnr)
  if vim.api.nvim_get_option_value('filetype', { buf = bufnr }) == 'alpha' then
    return ''
  end
  return '%l:%c %P'
end

local function lspinfo(bufnr)
  local function count(severity)
    return vim.tbl_count(vim.diagnostic.get(bufnr, { severity = severity }))
  end

  local function render(severity, hl, sign)
    local severity_count = count(severity)
    if severity_count == 0 then
      return ''
    end
    return '%#DiagnosticSign' .. hl .. '#' .. sign .. severity_count .. ' '
  end

  return table.concat {
    render(vim.diagnostic.severity.ERROR, 'Error', '󰅚 '),
    render(vim.diagnostic.severity.WARN, 'Warn', '󰗖 '),
    render(vim.diagnostic.severity.INFO, 'Info', '󰋽 '),
    render(vim.diagnostic.severity.HINT, 'Hint', '󰲽 '),
  }
end

local function GenerateFocusedStatusline(bufnr)
  return table.concat {
    '%#StatusLineFocusedPrimary#',
    ' ',
    mode(bufnr),
    '%#StatusLineFocusedSecondary#',
    '  ',
    filename(bufnr),
    ' ',
    location(bufnr),
    ' ',
    bufinfo(bufnr),
    '%=',
    lspinfo(bufnr),
  }
end

local function GenerateUnfocusedStatusline(bufnr)
  return table.concat {
    '%#StatusLineUnfocusedPrimary#',
    '▍ ',
    mode(bufnr),
    '%#StatusLineUnfocusedSecondary#',
    '  ',
    filename(bufnr),
    ' ',
    location(bufnr),
    ' ',
    bufinfo(bufnr),
  }
end

function GenerateStatusline(bufnr)
  if bufnr == vim.api.nvim_get_current_buf() then
    return GenerateFocusedStatusline(bufnr)
  else
    return GenerateUnfocusedStatusline(bufnr)
  end
end

function RefreshStatusline(event)
  local bufnr = event.buf
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufnr })

  if buftype == '' or buftype == 'file' or buftype == 'terminal' then
    vim.api.nvim_set_option_value('statusline', GenerateStatusline(bufnr), { scope = 'local' })
    vim.api.nvim_command([[ redrawstatus ]])
  end
end

local statusline_group = vim.api.nvim_create_augroup('StatusLineRefreshGroup', {})

vim.api.nvim_create_autocmd({
  'BufEnter',
  'BufModifiedSet',
  'BufNew',
  'BufNewFile',
  'BufReadPost',
  'BufWinEnter',
  'BufWritePost',
  'DiagnosticChanged',
  'ModeChanged',
  'TabEnter',
  'TermOpen',
  'VimResized',
  'WinEnter',
}, {
  callback = vim.schedule_wrap(RefreshStatusline),
  group = statusline_group,
})
