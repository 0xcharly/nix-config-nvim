function GenerateTabLine()
  local buf = ''
  local current_tab = vim.fn.tabpagenr()
  local total_tabs = vim.fn.tabpagenr('$')

  for i = 1, total_tabs do
    if i == current_tab then
      buf = buf .. '%#TabLineSel#' .. tostring(i) .. '%#TabLine#'
    else
      buf = buf .. tostring(i)
    end

    if i ~= total_tabs then
      buf = buf .. ' '
    end
  end

  buf = buf .. '%#TabLineFill#%T'
  return buf
end

vim.opt.tabline = '%!v:lua.GenerateTabLine()'
