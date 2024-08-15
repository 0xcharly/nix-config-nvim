local zls_cmd = 'zls'

if vim.fn.executable(zls_cmd) ~= 1 then
  return
end

local lsp = require('user.lsp')
local lspconfig = require('lspconfig')

---@diagnostic disable-next-line: missing-fields
lspconfig.zls.setup {
  cmd = { zls_cmd },
  on_attach = lsp.on_attach,
  capabilities = lsp.make_client_capabilities(),
}
