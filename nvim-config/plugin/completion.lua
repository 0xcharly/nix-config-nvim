require('blink-cmp').setup {
  completion = {
    menu = {
      border = 'rounded',
    },
    documentation = {
      window = {
        border = 'rounded',
      },
    },
  },
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = 'normal',
  },
  signature = { enabled = true },
  keymap = {
    ['<C-p>'] = {},
    ['<C-n>'] = {},
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-S-f>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-S-b>'] = { 'scroll_documentation_down', 'fallback' },
  },
}
