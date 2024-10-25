local lsp = require('user.lsp')
local lspconfig = require('lspconfig')

lspconfig.nixd.setup {
  cmd = { 'nixd', '--inlay-hints', '--semantic-tokens' },
  capabilities = lsp.make_client_capabilities(),
  settings = {
    nixd = {
      formatting = {
        command = { 'alejandra', '-qq' },
      },
    },
  },
}
