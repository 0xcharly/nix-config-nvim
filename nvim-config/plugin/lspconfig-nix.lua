local nixd_cmd = 'nixd'

if vim.fn.executable(nixd_cmd) ~= 1 then
  return
end

local lsp = require('user.lsp')
local lspconfig = require('lspconfig')

lspconfig.nixd.setup {
  cmd = { nixd_cmd, '--inlay-hints', '--semantic-tokens' },
  on_attach = lsp.on_attach,
  capabilities = lsp.make_client_capabilities(),
  settings = {
    nixd = {
      formatting = {
        command = { 'alejandra', '-qq' },
      },
    },
  },
}
