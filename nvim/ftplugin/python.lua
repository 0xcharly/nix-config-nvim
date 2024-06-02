local pylsp_cmd = 'pylsp'

if vim.fn.executable(pylsp_cmd) ~= 1 then
  return
end

local lsp = require('user.lsp')

---@diagnostic disable-next-line: missing-fields
vim.lsp.start {
  name = 'pylsp',
  cmd = { nixd_cmd },
  root_dir = vim.fs.dirname(vim.fs.find({ 'flake.nix', '.git' }, { upward = true })[1]),
  on_attach = lsp.on_attach,
  capabilities = lsp.make_client_capabilities(),
  settings = {
    pylsp = {
      plugins = {
        black = {
          enabled = true -- Disables autopep8 and yapf.
        },
      }
    }
  },
}
