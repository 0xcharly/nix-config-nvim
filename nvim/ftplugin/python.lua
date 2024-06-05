local pylsp_cmd = 'pylsp'

if vim.fn.executable(pylsp_cmd) ~= 1 then
  return
end

local lsp = require('user.lsp')

---@diagnostic disable-next-line: missing-fields
vim.lsp.start {
  name = 'pylsp',
  cmd = { pylsp_cmd },
  on_attach = lsp.on_attach,
  capabilities = lsp.make_client_capabilities(),
  settings = {
    pylsp = {
      plugins = {
        black = {
          enabled = true -- Disables autopep8 and yapf.
        },
        flake8 = {
          enabled = true
        },
        pylint = {
          enabled = true
        },
      }
    }
  },
}
