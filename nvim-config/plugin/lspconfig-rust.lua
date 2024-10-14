local rust_analyzer_cmd = 'rust-analyzer'

if vim.fn.executable(rust_analyzer_cmd) ~= 1 then
  return
end

local lsp = require('user.lsp')
local lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup {
  cmd = { rust_analyzer_cmd },
  on_attach = function(client, bufnr)
    lsp.on_attach(client, bufnr)
    -- Fixes `gq` being borked: https://github.com/neovim/neovim/pull/19677.
    -- rust-analyzer does not support formatting lines with `gq`.
    vim.bo[bufnr].formatexpr = nil
  end,
  capabilities = lsp.make_client_capabilities(),
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
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
