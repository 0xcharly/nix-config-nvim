local section_filename = {
  'filename',
  separator = '',
  symbols = {
    modified = '󱇨 ', -- Text to show when the file is modified.
    readonly = '󱀰 ', -- Text to show when the file is non-modifiable or readonly.
    unnamed = '[No Name]', -- Text to show for unnamed buffers.
    newfile = '󰻭 ', -- Text to show for newly created file before first write
  },
}

local C = require('catppuccin.palettes').get_palette('mocha')
local lsp = require('user.lsp')

local function hi(accent)
  return {
    a = { bg = C.base, fg = accent },
    b = { bg = C.base, fg = C.overlay2, gui = 'italic' },
    c = { bg = C.base, fg = C.overlay0 },
    x = { bg = C.base, fg = C.overlay0 },
    y = { bg = C.base, fg = C.overlay0 },
    z = { bg = C.base, fg = C.overlay0 },
  }
end

---@diagnostic disable-next-line: undefined-field
require('lualine').setup {
  options = {
    theme = {
      normal = hi(C.overlay2),
      insert = hi(C.blue),
      visual = hi(C.mauve),
      replace = hi(C.flamingo),
      command = hi(C.red),
      inactive = {
        a = { bg = C.mantle, fg = C.overlay0, gui = 'italic' },
        b = { bg = C.mantle, fg = C.overlay0, gui = 'italic' },
        c = { bg = C.mantle, fg = C.overlay0, gui = 'italic' },
        x = { bg = C.mantle, fg = C.overlay0, gui = 'italic' },
        y = { bg = C.mantle, fg = C.overlay0, gui = 'italic' },
        z = { bg = C.mantle, fg = C.overlay0, gui = 'italic' },
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
