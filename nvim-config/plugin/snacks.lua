require('snacks').setup {
  -- Add support for inlined images via the Kitty Graphics Protocol.
  image = { enabled = true },
  -- Better pickers.
  picker = {
    enabled = true,
    prompt = '  ',
    ui_select = true,
    main = {
      -- Does not force opening in a buffer showing the content of a file. This
      -- effectively allows opening the file in the current buffer even if it's
      -- showing something else than a file (eg. terminal or oil.nvim).
      file = false,
      current = true,
    },
    db = {
      ---@diagnostic disable-next-line: missing-parameter
      sqlite3_path = require('luv').os_getenv('LIBSQLITE_CLIB_PATH'),
    },
    icons = {
      files = { enabled = false },
      tree = { last = '╰╴' },
    },
  },
  -- Backdrop uses winblend which doesn't blend well with (at least) underlines:
  -- links' underline turn red when a floating window with backdrop is visible.
  win = { backdrop = false },
  -- Load files content first, plugins after.
  quickfile = { enabled = true },
  -- Integrated terminal on a hot-key.
  terminal = {
    enabled = true,
    win = {
      border = 'rounded',
      position = 'float',
      backdrop = 60,
      height = 0.9,
      width = 0.9,
      zindex = 50,
    },
  },
}

-- LSP-aware rename built into Oil.
vim.api.nvim_create_autocmd('User', {
  pattern = 'OilActionsPost',
  callback = function(event)
    if event.data.actions[1].type == 'move' then
      Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
    end
  end,
})

-- Snacks.picker
vim.keymap.set('n', '<Leader>g', Snacks.picker.grep, { desc = '[g]rep' })
vim.keymap.set('n', '<Leader>?', Snacks.picker.help, { desc = '[?] help tags' })
vim.keymap.set('n', '<Leader><Space>', Snacks.picker.smart, { desc = '[f]iles' })
vim.keymap.set('n', '<leader>fb', Snacks.picker.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>ff', Snacks.picker.files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', Snacks.picker.git_files, { desc = 'Find Git Files' })
vim.keymap.set('n', '<leader>fp', Snacks.picker.projects, { desc = 'Projects' })
vim.keymap.set('n', '<leader>fr', Snacks.picker.recent, { desc = 'Recent' })
vim.keymap.set('n', '<Leader>q', Snacks.picker.qflist, { desc = '[q]uickfix list' })
vim.keymap.set('n', '<Leader>r', Snacks.picker.registers, { desc = '[r]egisters' })
vim.keymap.set('n', '<Leader>d', Snacks.picker.diagnostics, { desc = '[d]iagnostics' })
vim.keymap.set('n', '<Leader>b', Snacks.picker.buffers, { desc = '[bb]uffers' })

-- Snacks.terminal
vim.keymap.set({ 'n', 't' }, '<A-y>', Snacks.terminal.toggle, { desc = 'Terminal' })
