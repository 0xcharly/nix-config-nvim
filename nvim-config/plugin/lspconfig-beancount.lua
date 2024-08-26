local beancount_cmd = 'beancount-language-server'

if vim.fn.executable(beancount_cmd) ~= 1 then
  return
end

local lsp = require('user.lsp')
local lspconfig = require('lspconfig')

lspconfig.beancount.setup {
  name = 'beancount',
  cmd = { beancount_cmd, '--stdio' },
  on_attach = lsp.on_attach,
  capabilities = lsp.make_client_capabilities(),
  root_dir = lspconfig.util.root_pattern('delay.beancount'),
  init_options = {
    journal_file = '~/beancount/delay.beancount',
  },
}

-- require 'telescope'.load_extension 'beancount'
--
-- vim.keymap.set('n', '<Leader>mc', '<cmd>%s/txn/*/gc<CR>', {
--   desc = 'beancount-nvim: mark transactions as reconciled',
--   noremap = true,
--   silent = true,
-- })
-- vim.keymap.set('n', '<Leader>mt', function()
--   require 'telescope'.extensions.beancount.copy_transactions(require 'telescope.themes'.get_ivy {})
-- end, {
--   desc = 'Telescope: beancount: copy beancount transactions',
--   noremap = true,
--   silent = true,
-- })
