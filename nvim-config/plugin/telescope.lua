local telescope = require('telescope')
local pickers = require('telescope.builtin')

telescope.setup {
}

vim.keymap.set('n', '<LocalLeader>g', pickers.live_grep, { desc = '[g]rep' })
vim.keymap.set('n', '<LocalLeader>?', pickers.help_tags, { desc = '[?] help tags' })
vim.keymap.set('n', '<LocalLeader>f', pickers.find_files, { desc = '[f]iles' })
vim.keymap.set('n', '<LocalLeader>q', pickers.quickfix, { desc = '[q]uickfix list' })
vim.keymap.set('n', '<LocalLeader>r', pickers.registers, { desc = '[r]egisters' })
vim.keymap.set('n', '<LocalLeader>d', pickers.diagnostics, { desc = '[d]iagnostics' })
vim.keymap.set('n', '<LocalLeader>b', pickers.buffers, { desc = '[bb]uffers' })
