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

local catppuccin = require('catppuccin.palettes').get_palette('mocha')

local function hi(accent)
  return {
    a = { bg = catppuccin.mantle, fg = accent, gui = 'bold' },
    b = { bg = catppuccin.mantle, fg = catppuccin.overlay2 },
    c = { bg = catppuccin.mantle, fg = catppuccin.overlay2 },
    x = { bg = catppuccin.mantle, fg = catppuccin.overlay2 },
    y = { bg = catppuccin.mantle, fg = catppuccin.overlay2 },
    z = { bg = catppuccin.mantle, fg = accent, gui = 'bold' },
  }
end

---@diagnostic disable-next-line: undefined-field
require('lualine').setup {
  options = {
    theme = {
      normal = hi(catppuccin.rosewater),
      insert = hi(catppuccin.blue),
      visual = hi(catppuccin.mauve),
      replace = hi(catppuccin.peach),
      command = hi(catppuccin.red),
      inactive = hi(catppuccin.subtext0),
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
          error = '󰅚 ',
          warn = '󰗖 ',
          info = '󰋽 ',
          hint = '󰲽 ',
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
