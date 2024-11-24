local conform = require('conform')

conform.setup {
  formatters_by_ft = {
    just = { 'just' },
    json = { 'yq' },
    kdl = { 'kdlfmt' },
    lua = { 'stylua' },
    nix = { 'alejandra' },
    python = { 'isort', 'black' },
    toml = { 'taplo' },
    rust = { 'rustfmt', lsp_format = 'fallback' },
    yaml = { 'yq' },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ['_'] = { 'trim_whitespace' },
  },
  notify_on_error = false,
}

vim.keymap.set('', '<leader>f', function()
  conform.format({ async = true, lsp_format = 'fallback' }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), 'v') then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
      end
    end
  end)
end, { desc = '[F]ormat buffer' })
