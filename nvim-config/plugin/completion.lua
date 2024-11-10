local cmp = require('cmp')

-- Sorts symbols that start by an underscore last.
-- Copied from cmp-under-comparator; don't need a plugin for this.
-- https://github.com/lukas-reineke/cmp-under-comparator
local function cmp_config_compare_underscore(lhs, rhs)
  local _, lhs_under = lhs.completion_item.label:find('^_+')
  local _, rhs_under = rhs.completion_item.label:find('^_+')
  lhs_under = lhs_under or 0
  rhs_under = rhs_under or 0
  if lhs_under > rhs_under then
    return false
  elseif lhs_under < rhs_under then
    return true
  end
end

cmp.setup {
  mapping = cmp.mapping.preset.insert {
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-S-j>'] = cmp.mapping.select_next_item(),
    ['<C-S-k>'] = cmp.mapping.select_prev_item(),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-a>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm { select = true },
    ['<C-S-y>'] = cmp.mapping.confirm { select = true },
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<c-space>'] = cmp.mapping.complete {},
    ['<C-q>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
    ['<Tab>'] = cmp.config.disable,
  },
  sources = {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer', keyword_length = 3 },
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp_config_compare_underscore,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  completion = { completeopt = 'menu,menuone,noinsert' },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
}

-- Use buffer source for `/`.
cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } })

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
})

cmp.setup.filetype('beancount', {
  sources = cmp.config.sources { { name = 'beancount' } },
})
