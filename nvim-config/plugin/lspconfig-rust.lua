local lsp = require('user.lsp')
local lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup {
  cmd = { 'rust-analyzer' },
  capabilities = lsp.make_client_capabilities(),
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = false,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },
      rustfmt = {
        rangeFormatting = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
        ignored = {
          ['async-trait'] = { 'async_trait' },
          ['napi-derive'] = { 'napi' },
          ['async-recursion'] = { 'async_recursion' },
        },
      },
    },
  },
}
