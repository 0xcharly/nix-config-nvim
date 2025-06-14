local ext = {
  title = '#d9e2e4',

  surface_red = '#41262e',
  on_surface_red = '#fe9fa9',

  surface_orange = '#433027',
  on_surface_orange = '#fec49a',

  surface_yellow = '#343637',
  on_surface_yellow = '#f9e1ae',

  surface_green = '#243c2e',
  on_surface_green = '#aff3c0',

  surface_cyan = '#233a48',
  on_surface_cyan = '#89dceb',

  surface_blue = '#203147',
  on_surface_blue = '#9fcdfe',

  surface_purple = '#312b41',
  on_surface_purple = '#cab4f4',
}

require('catppuccin').setup {
  transparent_background = false,
  term_colors = true,
  integrations = {
    alpha = false,
    cmp = true,
    dashboard = false,
    flash = false,
    fidget = true,
    fzf = false,
    gitsigns = true,
    harpoon = true,
    illuminate = {
      enabled = false,
    },
    indent_blankline = {
      enabled = false,
    },
    navic = {
      enabled = false,
    },
    neotree = false,
    neogit = false,
    nvimtree = false,
    mini = {
      enabled = false,
    },
    rainbow_delimiters = false,
    ufo = false,
  },
  color_overrides = {
    all = {
      rosewater = '#f5e0dc',
      flamingo = '#f2cdcd',
      pink = '#f5c2e7',
      mauve = '#d0aff8',
      red = '#fe9aa4',
      maroon = '#eba0ac',
      peach = '#f1b48e',
      yellow = '#e6dac1',
      green = '#addba9',
      teal = '#91d7d1',
      sky = '#95b7ef',
      sapphire = '#74c7ec',
      blue = '#89b4fa',
      lavender = '#b4befe',
      text = '#e1e8f4',
      subtext1 = '#bac2de',
      subtext0 = '#9ca0a8',
      overlay2 = '#7a8490',
      overlay1 = '#454759',
      overlay0 = '#232932',
      surface2 = '#1d2530',
      surface1 = '#192029',
      surface0 = '#1d1f21',
      base = '#11181c',
      mantle = '#101618',
      crust = '#0b1215',
    },
  },
  custom_highlights = function(color)
    return {
      -- Editor.
      Conceal = { fg = color.overlay2 },
      CursorLine = { bg = color.overlay0 },
      LineNr = { fg = color.overlay2 },
      CursorLineNr = { fg = color.subtext1 },
      NonText = { fg = color.overlay2 },
      NormalFloat = { fg = color.text, bg = color.base },
      FloatBorder = { fg = color.overlay1 },
      Pmenu = { bg = color.overlay0 },
      PmenuSel = { fg = ext.on_surface_blue, bg = ext.surface_blue },
      PmenuSbar = { bg = color.overlay0 },
      PmenuThumb = { bg = color.overlay2 },
      TabLine = { fg = color.subtext1 },
      TabLineSel = { link = 'PmenuSel' },
      Title = { fg = ext.title, style = { 'bold' } },
      Visual = { link = 'CursorLine' },
      VisualNOS = { link = 'Visual' },
      WildMenu = { bg = color.overlay0 },
      -- Same as CursorLine and StatusLine
      WinSeparator = { fg = color.overlay0 },
      -- Syntax.
      Comment = { fg = color.overlay2, style = {} },
      Keyword = { fg = color.subtext1, style = { 'bold' } },
      Punctuation = { fg = color.subtext0 },
      Operator = { fg = color.subtext0 },
      Delimiter = { fg = color.subtext0 },
      Boolean = { fg = color.pink },
      -- copilot.
      CopilotSuggestion = { link = 'LspInlayHint' },
      -- native_lsp.
      LspCodeLens = { link = 'NonText' },
      LspInlayHint = { link = 'LspCodeLens' },
      -- Treesitter.
      ['@variable.member'] = { fg = color.none },
      ['@keyword.function'] = { link = 'Keyword' },
      ['@keyword.return'] = { link = 'Keyword' },
      ['@keyword.operator'] = { link = 'Keyword' },
      ['@constructor.lua'] = { link = 'Punctuation' },
      ['@punctuation.delimiter'] = { link = 'Punctuation' },
      ['@punctuation.bracket'] = { link = 'Punctuation' },
      ['@punctuation.special'] = { link = 'Punctuation' },

      -- StatusLine = { bg = '#202d40' },
      StatusLine = { bg = color.overlay0 },
      StatusLineNC = { link = 'StatusLine' },
      StatusLineFocusedPrimary = { link = 'Title' },
      StatusLineFocusedSecondary = { fg = color.subtext0 },

      StatusLineUnfocusedPrimary = { fg = color.subtext1, style = { 'bold' } },
      StatusLineUnfocusedSecondary = { fg = color.subtext0 },
    }
  end,
}

vim.cmd.colorscheme('catppuccin')
