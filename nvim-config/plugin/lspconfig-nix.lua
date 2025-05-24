vim.lsp.config('nixd', {
  cmd = { 'nixd', '--inlay-hints', '--semantic-tokens' },
  settings = {
    nixd = {
      formatting = {
        command = { 'alejandra', '-qq' },
      },
    },
  },
})

vim.lsp.enable('nixd')
