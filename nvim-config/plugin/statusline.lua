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

local function is_new_file()
  local fname = vim.fn.expand('%')
  return fname ~= '' and fname:match('^%a+://') == nil and vim.bo.buftype == '' and vim.fn.filereadable(fname) == 0
end

local function filename()
  if is_new_file() then
    return '[New]'
  end

  local fname = vim.fn.expand('%:t')
  if fname == '' then
    return '[No Name]'
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
  return '%l:%c ‥  %P'
end

local function lspinfo()
  local function count(severity)
    return vim.tbl_count(vim.diagnostic.get(0, { severity = severity }))
  end
  local count_errors = count(vim.diagnostic.severity.ERROR)
  local count_warnings = count(vim.diagnostic.severity.WARN)
  local count_info = count(vim.diagnostic.severity.INFO)
  local count_hints = count(vim.diagnostic.severity.HINT)

  local errors = ''
  local warnings = ''
  local hints = ''
  local info = ''

  if count_errors ~= 0 then
    errors = '%#DiagnosticSignError#󰅚 ' .. count_errors .. ' '
  end
  if count_warnings ~= 0 then
    warnings = '%#DiagnosticSignWarn#󰗖 ' .. count_warnings .. ' '
  end
  if count_info ~= 0 then
    info = '%#DiagnosticSignInfo#󰋽 ' .. count_info .. ' '
  end
  if count_hints ~= 0 then
    hints = '%#DiagnosticSignHint#󰲽 ' .. count_hints .. ' '
  end

  return table.concat {
    errors,
    warnings,
    hints,
    info,
    '%#Normal#',
  }
end

function Statusline.active()
  return table.concat {
    ' %#StatuslineMode#',
    mode(),
    '%#Normal#  %#StatusLineFilename#',
    filename(),
    '%#Normal#   %#StatusLineLocation#',
    location(),
    '%#Normal# %#StatusLineBuffer#',
    bufinfo(),
    '%=',
    lspinfo(),
  }
end

function Statusline.inactive()
  return table.concat {
    ' %#StatuslineModeInactive#',
    mode(),
    '%#Normal#  %#StatusLineFilenameInactive#',
    filename(),
  }
end

local statusline_group = vim.api.nvim_create_augroup('StatusLineGroup', {})

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = statusline_group,
  pattern = '*',
  command = 'setlocal statusline=%!v:lua.Statusline.active()',
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  group = statusline_group,
  pattern = '*',
  command = 'setlocal statusline=%!v:lua.Statusline.inactive()',
})
