local lsp = require('user.lsp')
local lspconfig = require('lspconfig')

lspconfig.beancount.setup {
  name = 'beancount',
  cmd = { 'beancount-language-server', '--stdio' },
  capabilities = lsp.make_client_capabilities(),
  root_dir = lspconfig.util.root_pattern('delay.beancount'),
  init_options = {
    journal_file = '~/beancount/delay.beancount',
  },
}
