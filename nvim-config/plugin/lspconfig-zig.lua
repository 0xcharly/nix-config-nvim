local lsp = require('user.lsp')
local lspconfig = require('lspconfig')

lspconfig.zls.setup {
  cmd = { 'zls' },
  capabilities = lsp.make_client_capabilities(),
}
