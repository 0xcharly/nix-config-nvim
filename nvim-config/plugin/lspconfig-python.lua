local pylsp_cmd = 'pylsp'

if vim.fn.executable(pylsp_cmd) ~= 1 then
  return
end

local lsp = require('user.lsp')
local lspconfig = require('lspconfig')

---@diagnostic disable-next-line: missing-fields
lspconfig.pylsp.setup {
  cmd = { pylsp_cmd },
  on_attach = lsp.on_attach,
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
