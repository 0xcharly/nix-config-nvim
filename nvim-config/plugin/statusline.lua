Statusline = {}

local modes = {
  ['n'] = 'NORMAL',
  ['no'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['V'] = 'VISUAL LINE',
  [''] = 'VISUAL BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'SELECT LINE',
  [''] = 'SELECT BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rv'] = 'VISUAL REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'VIM EX',
  ['ce'] = 'EX',
  ['r'] = 'PROMPT',
  ['rm'] = 'MOAR',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format('%s', modes[current_mode]):upper()
end

local function filename()
  local function buf_fname()
    local buf = '#' .. vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    return (vim.fn.expand(buf) == '' and '-- Empty --') or vim.fn.expand(buf .. ':t')
  end

  local fname = buf_fname()
  if fname == '' then
    return '-- No Name --'
  end

  return fname .. ' '
end

local function bufinfo()
  if vim.bo.modified then
    return '[dirty]'
  end
  if vim.bo.modifiable == false or vim.bo.readonly == true then
    return '[readonly]'
  end
  return ''
end

local function location()
  if vim.bo.filetype == 'alpha' then
    return ''
  end
  return '%P   L%l'
end

local function lspinfo()
  local function count(severity)
    return vim.tbl_count(vim.diagnostic.get(0, { severity = severity }))
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

function Statusline.focused()
  return table.concat {
    '%#StatuslineFocusedPrimary# ',
    mode(),
    '%#StatusLineFocusedSecondary#  ',
    filename(),
    ' ',
    location(),
    ' ',
    bufinfo(),
    '%=',
    lspinfo(),
  }
end

function Statusline.unfocused()
  return table.concat {
    '%#StatuslineUnfocusedPrimary# ',
    mode(),
    '%#StatusLineUnfocusedSecondary#  ',
    filename(),
  }
end

local statusline_group = vim.api.nvim_create_augroup('StatusLineGroup', {})

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = statusline_group,
  pattern = '*',
  command = 'setlocal statusline=%!v:lua.Statusline.focused()',
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  group = statusline_group,
  pattern = '*',
  command = 'setlocal statusline=%!v:lua.Statusline.unfocused()',
})
