require('fff').setup {
  prompt = '   ',
  title = 'Find files',
  keymaps = {
    move_up = { '<Up>', '<C-k>' },
    move_down = { '<Down>', '<C-j>' },
  },
  hl = { cursor = 'Normal' },
  preview = { enabled = false },
}

vim.keymap.set('n', 'ff', vim.cmd.FFFFind, { desc = '[f]iles' })

-- IMPORTANT NOTE: if deleting this in the future, also cleanup the
-- `InactiveDisableCursorLine` auto-group in `autocmd.lua`.
