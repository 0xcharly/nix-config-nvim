local lsp = require('user.lsp')

vim.g.rustaceanvim = {
  server = {
    on_attach = lsp.on_attach,
    capabilities = lsp.make_client_capabilities(),
    default_settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
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
  },
}
