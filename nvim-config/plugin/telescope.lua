local telescope = require('telescope')
local pickers = require('telescope.builtin')

telescope.setup {}

-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local is_inside_work_tree = {}

local function project_files()
  local opts = {} -- define here if you want to define something

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system('git rev-parse --is-inside-work-tree')
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    require('telescope.builtin').git_files(opts)
  else
    require('telescope.builtin').find_files(opts)
  end
end

vim.keymap.set('n', '<LocalLeader>g', pickers.live_grep, { desc = '[g]rep' })
vim.keymap.set('n', '<LocalLeader>?', pickers.help_tags, { desc = '[?] help tags' })
vim.keymap.set('n', '<LocalLeader>f', project_files, { desc = '[f]iles' })
vim.keymap.set('n', '<LocalLeader>q', pickers.quickfix, { desc = '[q]uickfix list' })
vim.keymap.set('n', '<LocalLeader>r', pickers.registers, { desc = '[r]egisters' })
vim.keymap.set('n', '<LocalLeader>d', pickers.diagnostics, { desc = '[d]iagnostics' })
vim.keymap.set('n', '<LocalLeader>b', pickers.buffers, { desc = '[bb]uffers' })
