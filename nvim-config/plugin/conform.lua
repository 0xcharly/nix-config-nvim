local conform = require('conform')

conform.setup {
  formatters_by_ft = {
    just = { 'just' },
    json = { 'yq' },
    kdl = { 'kdlfmt' },
    lua = { 'stylua' },
    python = { 'isort', 'black' },
    toml = { 'taplo' },
    yaml = { 'yq' },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ['_'] = { 'trim_whitespace', 'trim_newlines', lsp_format = 'last' },
  },
  notify_on_error = false,
}

vim.keymap.set('', '<leader>f', function()
  conform.format({ async = true }, function(err, did_edit)
    if not err and not did_edit then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), 'v') then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
      end
    end
  end)
end, { desc = '[F]ormat buffer' })

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
