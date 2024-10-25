local lsp = require('user.lsp')
local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup {
  cmd = { 'lua-language-server' },
  capabilities = lsp.make_client_capabilities(),
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global, etc.
        globals = {
          'vim',
          'describe',
          'it',
          'assert',
          'stub',
        },
        disable = {
          'duplicate-set-field',
        },
      },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- inlay hints (supported in Neovim >= 0.10)
      hint = { enable = true },
      format = {
        enable = true,
        defaultConfig = {
          call_arg_parentheses = 'remove',
          indent_style = 'space',
          quote_style = 'single',
        },
      },
    },
  },
}
