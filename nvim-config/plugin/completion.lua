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
    ['<C-k>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-j>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
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
      if cmp.visible() then
        return f()
      end

      fallback()
    end,
  }
end

-- Use cmdline & path source for ':' (incompatible with `native_menu`).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline {
    ['<C-k>'] = cmdline_mapping(cmp.select_prev_item),
    ['<C-j>'] = cmdline_mapping(cmp.select_next_item),
    ['<C-y>'] = cmp.mapping.confirm { select = true },
  },
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
  matching = { disallow_symbol_nonprefix_matching = false },
})
