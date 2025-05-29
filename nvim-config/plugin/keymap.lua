local cmd = vim.cmd
local diagnostic = vim.diagnostic
local keymap = vim.keymap

-- Keymaps for better default experience.
-- See `:help vim.keymap.set()`
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Helix-inspired keymaps.
keymap.set('n', 'U', '<C-r>', { silent = true }) -- Redo
keymap.set('n', 'gn', cmd.bnext, { silent = true }) -- Goto next buffer
keymap.set('n', 'gp', cmd.bprevious, { silent = true }) -- Goto previous buffer

-- Diagnostic keymaps.
keymap.set('n', '<leader>e', diagnostic.open_float, { silent = true })
keymap.set('n', '<leader>q', diagnostic.setloclist, { silent = true })

-- Make esc leave terminal mode.
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { silent = true })

-- Try and make sure to not mangle space items.
keymap.set('t', '<S-Space>', '<Space>', { silent = true })
keymap.set('t', '<C-Space>', '<Space>', { silent = true })

-- Use `Control+{←↓↑→}` to navigate windows from any mode.
keymap.set({ 'i', 't' }, '<C-Left>', '<C-\\><C-N><C-w>h', { silent = true })
keymap.set({ 'i', 't' }, '<C-Down>', '<C-\\><C-N><C-w>j', { silent = true })
keymap.set({ 'i', 't' }, '<C-Up>', '<C-\\><C-N><C-w>k', { silent = true })
keymap.set({ 'i', 't' }, '<C-Right>', '<C-\\><C-N><C-w>l', { silent = true })
keymap.set('n', '<C-Left>', '<C-w>h', { silent = true })
keymap.set('n', '<C-Down>', '<C-w>j', { silent = true })
keymap.set('n', '<C-Up>', '<C-w>k', { silent = true })
keymap.set('n', '<C-Right>', '<C-w>l', { silent = true })

-- Use `Control+Shift+{←↓↑→} to navigate between tabs and buffers.
keymap.set({ 'i', 'n' }, '<C-S-Left>', cmd.tabprev, { silent = true })
keymap.set({ 'i', 'n' }, '<C-S-Right>', cmd.tabnext, { silent = true })
keymap.set({ 'i', 'n' }, '<C-S-Up>', cmd.bufprev, { silent = true })
keymap.set({ 'i', 'n' }, '<C-S-Down>', cmd.bufnext, { silent = true })

-- Better defaults.
keymap.set('n', 'n', 'nzzzv', { silent = true })
keymap.set('n', 'N', 'Nzzzv', { silent = true })
keymap.set('n', 'J', 'mzJ`z', { silent = true })
keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })

-- Better virtual paste.
keymap.set('x', '<leader>p', '"_dP', { silent = true })
keymap.set('i', '<C-v>', '<C-o>"+p', { silent = true })
keymap.set('c', '<C-v>', '<C-r>+', { silent = true })

-- Better yank.
keymap.set('n', 'Y', 'yg$', { silent = true })
keymap.set('n', '<leader>Y', '"+Y', { silent = true })
keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { silent = true })

-- Better delete.
keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { silent = true })

-- Pane creation.
keymap.set('n', '<leader>wh', cmd.split, { silent = true })
keymap.set('n', '<leader>wv', cmd.vsplit, { silent = true })

-- Virtual mode line movements.
keymap.set('v', 'J', ":m '>+1<cr>gv=gv", { silent = true })
keymap.set('v', 'K', ":m '<-2<cr>gv=gv", { silent = true })
