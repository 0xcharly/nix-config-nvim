local lsp = require('user.lsp')
local flutter = require('flutter-tools')

flutter.setup {
  lsp = {
    capabilities = lsp.make_client_capabilities(),
  },
}
