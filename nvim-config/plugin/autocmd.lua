-- [[ Flash on yank ]]
-- See `:help vim.highlight.on_yank()`
local yank_group = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 40,
    }
  end,
})

-- [[ Remove trailing whitespaces ]]
local whitespace_group = vim.api.nvim_create_augroup('TrimWhitespace', {})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = whitespace_group,
  pattern = '*',
  command = '%s/\\s\\+$//e',
})

-- [[ Disable history on sensitive files ]]
local disable_history_group = vim.api.nvim_create_augroup('DisableHistory', {})
vim.api.nvim_create_autocmd({ 'BufRead' }, {
  group = disable_history_group,
  pattern = { '*.age' },
  command = 'setlocal nobackup nomodeline noshelltemp noswapfile noundofile nowritebackup shadafile=NONE',
})

-- [[ Yank ring ]]
-- https://github.com/neovim/neovim/discussions/33425
-- https://x.com/justinmk/status/1911092038109364377
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    if vim.v.event.operator == 'y' or vim.v.event.operator == 'd' then
      vim.fn.setreg(tostring(0), vim.fn.getreg('"'))
      for i = 9, 1, -1 do
        vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
      end
    end
  end,
})
