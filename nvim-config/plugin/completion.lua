local cmp = require('cmp')

local cmp_kinds = {
  Text = ' ',
  Method = ' ',
  Function = ' ',
  Constructor = ' ',
  Field = ' ',
  Variable = ' ',
  Class = ' ',
  Interface = ' ',
  Module = ' ',
  Property = ' ',
  Unit = ' ',
  Value = ' ',
  Enum = ' ',
  Keyword = ' ',
  Snippet = ' ',
  Color = ' ',
  File = ' ',
  Reference = ' ',
  Folder = ' ',
  EnumMember = ' ',
  Constant = ' ',
  Struct = ' ',
  Event = ' ',
  Operator = ' ',
  TypeParameter = ' ',
}

cmp.setup {
  formatting = {
    fields = { 'kind', 'abbr' },
    format = function(_, vim_item)
      vim_item.kind = cmp_kinds[vim_item.kind] or ''
      return vim_item
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-p>'] = cmp.mapping.complete(),
    ['<C-k>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    ['<C-j>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    ['<C-y>'] = cmp.mapping.confirm { select = true },
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'render-markdown' },
  }, {
    { name = 'buffer' },
  }),
}

local function cmdline_mapping(f)
  return {
    c = function(fallback)
      local lcmp = require('cmp')
      if lcmp.visible() then
        f(lcmp)
      else
        fallback()
      end
    end,
  }
end

-- Use cmdline & path source for ':' (incompatible with `native_menu`).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline {
    ['<C-p>'] = cmp.config.disable,
    ['<C-n>'] = cmp.config.disable,
    ['<C-k>'] = cmdline_mapping(function(lcmp)
      lcmp.select_prev_item()
    end),
    ['<C-j>'] = cmdline_mapping(function(lcmp)
      lcmp.select_next_item()
    end),
  },
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
  matching = { disallow_symbol_nonprefix_matching = false },
})
