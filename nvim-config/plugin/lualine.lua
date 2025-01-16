local section_filename = {
  'filename',
  separator = '',
  symbols = {
    modified = '[dirty] ', -- Text to show when the file is modified.
    readonly = '[readonly] ', -- Text to show when the file is non-modifiable or readonly.
    unnamed = '[No Name]', -- Text to show for unnamed buffers.
    newfile = '[New] ', -- Text to show for newly created file before first write
  },
}

local theme = require('lualine.themes.auto')
local catppuccin = require('catppuccin.palettes').get_palette('mocha')

local function hi(accent)
  return {
    a = { bg = theme.normal.b.bg, fg = accent, gui = 'bold' },
    b = { bg = theme.normal.b.bg, fg = theme.normal.c.fg },
    c = { bg = theme.normal.b.bg, fg = theme.normal.c.fg },
    x = { bg = theme.normal.b.bg, fg = theme.normal.c.fg },
    y = { bg = theme.normal.b.bg, fg = theme.normal.c.fg },
    z = { bg = theme.normal.b.bg, fg = theme.normal.c.fg },
  }
end

local lsp = require('user.lsp')

---@diagnostic disable-next-line: undefined-field
require('lualine').setup {
  options = {
    theme = {
      normal = hi(catppuccin.lavender),
      insert = hi(catppuccin.blue),
      visual = hi(catppuccin.mauve),
      replace = hi(catppuccin.flamingo),
      command = hi(catppuccin.red),
      inactive = {
        a = { bg = theme.inactive.b.bg, fg = theme.inactive.c.fg },
        b = { bg = theme.inactive.b.bg, fg = theme.inactive.c.fg },
        c = { bg = theme.inactive.b.bg, fg = theme.inactive.c.fg },
        x = { bg = theme.inactive.b.bg, fg = theme.inactive.c.fg },
        y = { bg = theme.inactive.b.bg, fg = theme.inactive.c.fg },
        z = { bg = theme.inactive.b.bg, fg = theme.inactive.c.fg },
      },
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      section_filename,
      { 'location', separator = '‥' },
      'progress',
    },
    lualine_c = { 'selectioncount' },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      { 'lsp_info', separator = '‥' },
      {
        'diagnostics',
        symbols = {
          error = lsp.diagnostic_signs.Error,
          warn = lsp.diagnostic_signs.Warn,
          info = lsp.diagnostic_signs.Info,
          hint = lsp.diagnostic_signs.Hint,
        },
      },
    },
  },
  inactive_sections = {
    lualine_a = { 'mode' },
    lualine_b = { section_filename },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}
