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
      text = '#cad5e2',
      subtext1 = '#bac2de',
      subtext0 = '#8fa3bb',
      overlay2 = '#7a8490',
      overlay1 = '#454759',
      overlay0 = '#232932',
      surface2 = '#1d2530',
      surface1 = '#192029',
      surface0 = '#1d1f21',
      base = '#10141E',
      mantle = '#101618',
      crust = '#0b1215',
    },
  },
  custom_highlights = function(color)
    return {
      -- Editor.
      Conceal = { fg = color.overlay2 },
      CursorLine = { bg = color.surface2 },
      LineNr = { fg = color.overlay2 },
      CursorLineNr = { fg = color.subtext1 },
      NonText = { fg = color.overlay2 },
      NormalFloat = { fg = color.text, bg = color.base },
      FloatBorder = { fg = color.sky, bg = color.none },
      Pmenu = { bg = color.overlay0 },
      PmenuSel = { fg = ext.on_surface_blue, bg = ext.surface_blue },
      PmenuExtra = { link = 'PmenuSel' },
      PmenuExtraSel = { link = 'PmenuSel' },
      PmenuSbar = { bg = color.overlay0 },
      PmenuThumb = { bg = color.sky },
      TabLine = { fg = color.subtext1 },
      TabLineSel = { link = 'PmenuSel' },
      Title = { fg = ext.title, style = { 'bold' } },
      Visual = { link = 'CursorLine' },
      VisualNOS = { link = 'Visual' },
      WildMenu = { bg = ext.surface_blue },
      -- Same as CursorLine and StatusLine
      WinSeparator = { fg = color.overlay0 },
      -- Syntax.
      Comment = { fg = color.overlay2, style = {} },
      Keyword = { fg = color.subtext1, style = { 'bold' } },
      Punctuation = { fg = color.subtext0 },
      Operator = { fg = color.subtext0 },
      Delimiter = { fg = color.subtext0 },
      Boolean = { fg = color.pink },
      -- native_lsp.
      LspCodeLens = { link = 'NonText' },
      LspInlayHint = { link = 'LspCodeLens' },
      -- Treesitter.
      ['@parameter'] = { fg = color.subtext1 },
      ['@variable.member'] = { fg = color.none },
      ['@keyword.function'] = { link = 'Keyword' },
      ['@keyword.return'] = { link = 'Keyword' },
      ['@keyword.operator'] = { link = 'Keyword' },
      ['@constructor.lua'] = { link = 'Punctuation' },
      ['@punctuation.delimiter'] = { link = 'Punctuation' },
      ['@punctuation.bracket'] = { link = 'Punctuation' },
      ['@punctuation.special'] = { link = 'Punctuation' },

      StatusLine = { bg = color.overlay0 },
      StatusLineNC = { link = 'StatusLine' },
      StatusLineFocusedPrimary = { link = 'Title' },
      StatusLineFocusedSecondary = { fg = color.subtext0 },

      StatusLineUnfocusedPrimary = { fg = color.subtext1, style = { 'bold' } },
      StatusLineUnfocusedSecondary = { fg = color.subtext0 },

      -- Snacks.
      SnacksPickerBorder = { link = 'FloatBorder' },
      SnacksPickerPrompt = { fg = color.blue },
      SnacksPickerInputCursorLine = { bg = color.base },

      -- Noice.
      NoicePopupBorder = { link = 'FloatBorder' },
      NoiceCmdlinePopupBorder = { link = 'FloatBorder' },

      -- Treesitter's `comment` queries.
      -- https://github.com/nvim-treesitter/nvim-treesitter/blob/42fc28ba918343ebfd5565147a42a26580579482/queries/comment/highlights.scm
      ['@comment.error'] = { fg = color.maroon, bg = color.none, style = { 'bold' } },
      ['@comment.note'] = { fg = ext.title, bg = color.none, style = { 'bold' } },
      ['@comment.todo'] = { fg = color.sky, bg = color.none, style = { 'bold' } },
      ['@comment.warning'] = { fg = color.yellow, bg = color.none, style = { 'bold' } },
    }
  end,
}

vim.cmd.colorscheme('catppuccin')
