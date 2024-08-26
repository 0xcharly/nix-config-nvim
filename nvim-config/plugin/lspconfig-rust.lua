local rust_analyzer_cmd = 'rust-analyzer'

if vim.fn.executable(rust_analyzer_cmd) ~= 1 then
  return
end

local lsp = require('user.lsp')
local lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup {
  cmd = { rust_analyzer_cmd },
  on_attach = lsp.on_attach,
  capabilities = lsp.make_client_capabilities(),
}
