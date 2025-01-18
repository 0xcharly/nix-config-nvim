local fzf = require('fzf-lua')

fzf.setup {
  fzf_bin = 'sk',
  defaults = { compat_warn = false },
}

vim.keymap.set('n', '<LocalLeader>g', fzf.live_grep, { desc = '[g]rep' })
vim.keymap.set('n', '<LocalLeader>?', fzf.helptags, { desc = '[?] help tags' })
vim.keymap.set('n', '<LocalLeader>f', fzf.files, { desc = '[f]iles' })
vim.keymap.set('n', '<LocalLeader>q', fzf.quickfix, { desc = '[q]uickfix list' })
vim.keymap.set('n', '<LocalLeader>r', fzf.registers, { desc = '[r]egisters' })
vim.keymap.set('n', '<LocalLeader>d', fzf.diagnostics_workspace, { desc = '[d]iagnostics' })
vim.keymap.set('n', '<LocalLeader>b', fzf.buffers, { desc = '[bb]uffers' })
