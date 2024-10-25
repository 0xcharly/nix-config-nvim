local lsp = require('user.lsp')
local lspconfig = require('lspconfig')

lspconfig.pylsp.setup {
  cmd = { 'pylsp' },
  capabilities = lsp.make_client_capabilities(),
  settings = {
    pylsp = {
      plugins = {
        black = {
          enabled = true, -- Disables autopep8 and yapf.
        },
        flake8 = {
          enabled = true,
        },
        pylint = {
          enabled = true,
        },
        mccabe = {
          enabled = true,
        },
        pycodestyle = {
          enabled = true,
          convention = 'google',
        },
        pyflakes = {
          enabled = false,
        },
        mypy = {
          enabled = true,
        },
      },
    },
  },
}
