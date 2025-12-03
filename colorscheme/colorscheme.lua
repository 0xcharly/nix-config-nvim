-- Helpers {{{

---@param groups {[string]: table}
local function generate_colorscheme(groups)
  if type(groups) ~= 'table' then
    error('generate_colorscheme: invalid parameter: expected a table, got ' .. type(groups))
  end

  for group, setting in pairs(groups) do
    vim.api.nvim_set_hl(0, group, setting)
  end
end

-- }}}
-- Palette {{{

local P = {
  ['slate-50'] = 0xF8FAFC,
  ['slate-100'] = 0xF1F5F9,
  ['slate-200'] = 0xE2E8F0,
  ['slate-300'] = 0xCBD5E1,
  ['slate-400'] = 0x94A3B8,
  ['slate-500'] = 0x64748B,
  ['slate-600'] = 0x475569,
  ['slate-700'] = 0x334155,
  ['slate-800'] = 0x1E293B,
  ['slate-900'] = 0x0F172A,
  ['slate-950'] = 0x020617,
  ['gray-50'] = 0xF9FAFB,
  ['gray-100'] = 0xF3F4F6,
  ['gray-200'] = 0xE5E7EB,
  ['gray-300'] = 0xD1D5DB,
  ['gray-400'] = 0x9CA3AF,
  ['gray-500'] = 0x6B7280,
  ['gray-600'] = 0x4B5563,
  ['gray-700'] = 0x374151,
  ['gray-800'] = 0x1F2937,
  ['gray-900'] = 0x111827,
  ['gray-950'] = 0x030712,
  ['zinc-50'] = 0xFAFAFA,
  ['zinc-100'] = 0xF4F4F5,
  ['zinc-200'] = 0xE4E4E7,
  ['zinc-300'] = 0xD4D4D8,
  ['zinc-400'] = 0xA1A1AA,
  ['zinc-500'] = 0x71717A,
  ['zinc-600'] = 0x52525B,
  ['zinc-700'] = 0x3F3F46,
  ['zinc-800'] = 0x27272A,
  ['zinc-900'] = 0x18181B,
  ['zinc-950'] = 0x09090B,
  ['neutral-50'] = 0xFAFAFA,
  ['neutral-100'] = 0xF5F5F5,
  ['neutral-200'] = 0xE5E5E5,
  ['neutral-300'] = 0xD4D4D4,
  ['neutral-400'] = 0xA3A3A3,
  ['neutral-500'] = 0x737373,
  ['neutral-600'] = 0x525252,
  ['neutral-700'] = 0x404040,
  ['neutral-800'] = 0x262626,
  ['neutral-900'] = 0x171717,
  ['neutral-950'] = 0x0A0A0A,
  ['stone-50'] = 0xFAFAF9,
  ['stone-100'] = 0xF5F5F4,
  ['stone-200'] = 0xE7E5E4,
  ['stone-300'] = 0xD6D3D1,
  ['stone-400'] = 0xA8A29E,
  ['stone-500'] = 0x78716C,
  ['stone-600'] = 0x57534E,
  ['stone-700'] = 0x44403C,
  ['stone-800'] = 0x292524,
  ['stone-900'] = 0x1C1917,
  ['stone-950'] = 0x0C0A09,
  ['red-50'] = 0xFEF2F2,
  ['red-100'] = 0xFEE2E2,
  ['red-200'] = 0xFECACA,
  ['red-300'] = 0xFCA5A5,
  ['red-400'] = 0xF87171,
  ['red-500'] = 0xEF4444,
  ['red-600'] = 0xDC2626,
  ['red-700'] = 0xB91C1C,
  ['red-800'] = 0x991B1B,
  ['red-900'] = 0x7F1D1D,
  ['red-950'] = 0x450A0A,
  ['orange-50'] = 0xFFF7ED,
  ['orange-100'] = 0xFFEDD5,
  ['orange-200'] = 0xFED7AA,
  ['orange-300'] = 0xFDBA74,
  ['orange-400'] = 0xFB923C,
  ['orange-500'] = 0xF97316,
  ['orange-600'] = 0xEA580C,
  ['orange-700'] = 0xC2410C,
  ['orange-800'] = 0x9A3412,
  ['orange-900'] = 0x7C2D12,
  ['orange-950'] = 0x431407,
  ['amber-50'] = 0xFFFBEB,
  ['amber-100'] = 0xFEF3C7,
  ['amber-200'] = 0xFDE68A,
  ['amber-300'] = 0xFCD34D,
  ['amber-400'] = 0xFBBF24,
  ['amber-500'] = 0xF59E0B,
  ['amber-600'] = 0xD97706,
  ['amber-700'] = 0xB45309,
  ['amber-800'] = 0x92400E,
  ['amber-900'] = 0x78350F,
  ['amber-950'] = 0x451A03,
  ['yellow-50'] = 0xFEFCE8,
  ['yellow-100'] = 0xFEF9C3,
  ['yellow-200'] = 0xFEF08A,
  ['yellow-300'] = 0xFDE047,
  ['yellow-400'] = 0xFACC15,
  ['yellow-500'] = 0xEAB308,
  ['yellow-600'] = 0xCA8A04,
  ['yellow-700'] = 0xA16207,
  ['yellow-800'] = 0x854D0E,
  ['yellow-900'] = 0x713F12,
  ['yellow-950'] = 0x422006,
  ['lime-50'] = 0xF7FEE7,
  ['lime-100'] = 0xECFCCB,
  ['lime-200'] = 0xD9F99D,
  ['lime-300'] = 0xBEF264,
  ['lime-400'] = 0xA3E635,
  ['lime-500'] = 0x84CC16,
  ['lime-600'] = 0x65A30D,
  ['lime-700'] = 0x4D7C0F,
  ['lime-800'] = 0x3F6212,
  ['lime-900'] = 0x365314,
  ['lime-950'] = 0x1A2E05,
  ['green-50'] = 0xF0FDF4,
  ['green-100'] = 0xDCFCE7,
  ['green-200'] = 0xBBF7D0,
  ['green-300'] = 0x86EFAC,
  ['green-400'] = 0x4ADE80,
  ['green-500'] = 0x22C55E,
  ['green-600'] = 0x16A34A,
  ['green-700'] = 0x15803D,
  ['green-800'] = 0x166534,
  ['green-900'] = 0x14532D,
  ['green-950'] = 0x052E16,
  ['emerald-50'] = 0xECFDF5,
  ['emerald-100'] = 0xD1FAE5,
  ['emerald-200'] = 0xA7F3D0,
  ['emerald-300'] = 0x6EE7B7,
  ['emerald-400'] = 0x34D399,
  ['emerald-500'] = 0x10B981,
  ['emerald-600'] = 0x059669,
  ['emerald-700'] = 0x047857,
  ['emerald-800'] = 0x065F46,
  ['emerald-900'] = 0x064E3B,
  ['emerald-950'] = 0x022C22,
  ['teal-50'] = 0xF0FDFA,
  ['teal-100'] = 0xCCFBF1,
  ['teal-200'] = 0x99F6E4,
  ['teal-300'] = 0x5EEAD4,
  ['teal-400'] = 0x2DD4BF,
  ['teal-500'] = 0x14B8A6,
  ['teal-600'] = 0x0D9488,
  ['teal-700'] = 0x0F766E,
  ['teal-800'] = 0x115E59,
  ['teal-900'] = 0x134E4A,
  ['teal-950'] = 0x042F2E,
  ['cyan-50'] = 0xECFEFF,
  ['cyan-100'] = 0xCFFAFE,
  ['cyan-200'] = 0xA5F3FC,
  ['cyan-300'] = 0x67E8F9,
  ['cyan-400'] = 0x22D3EE,
  ['cyan-500'] = 0x06B6D4,
  ['cyan-600'] = 0x0891B2,
  ['cyan-700'] = 0x0E7490,
  ['cyan-800'] = 0x155E75,
  ['cyan-900'] = 0x164E63,
  ['cyan-950'] = 0x083344,
  ['sky-50'] = 0xF0F9FF,
  ['sky-100'] = 0xE0F2FE,
  ['sky-200'] = 0xBAE6FD,
  ['sky-300'] = 0x7DD3FC,
  ['sky-400'] = 0x38BDF8,
  ['sky-500'] = 0x0EA5E9,
  ['sky-600'] = 0x0284C7,
  ['sky-700'] = 0x0369A1,
  ['sky-800'] = 0x075985,
  ['sky-900'] = 0x0C4A6E,
  ['sky-950'] = 0x082F49,
  ['blue-50'] = 0xEFF6FF,
  ['blue-100'] = 0xDBEAFE,
  ['blue-200'] = 0xBFDBFE,
  ['blue-300'] = 0x93C5FD,
  ['blue-400'] = 0x60A5FA,
  ['blue-500'] = 0x3B82F6,
  ['blue-600'] = 0x2563EB,
  ['blue-700'] = 0x1D4ED8,
  ['blue-800'] = 0x1E40AF,
  ['blue-900'] = 0x1E3A8A,
  ['blue-950'] = 0x172554,
  ['indigo-50'] = 0xEEF2FF,
  ['indigo-100'] = 0xE0E7FF,
  ['indigo-200'] = 0xC7D2FE,
  ['indigo-300'] = 0xA5B4FC,
  ['indigo-400'] = 0x818CF8,
  ['indigo-500'] = 0x6366F1,
  ['indigo-600'] = 0x4F46E5,
  ['indigo-700'] = 0x4338CA,
  ['indigo-800'] = 0x3730A3,
  ['indigo-900'] = 0x312E81,
  ['indigo-950'] = 0x1E1B4B,
  ['violet-50'] = 0xF5F3FF,
  ['violet-100'] = 0xEDE9FE,
  ['violet-200'] = 0xDDD6FE,
  ['violet-300'] = 0xC4B5FD,
  ['violet-400'] = 0xA78BFA,
  ['violet-500'] = 0x8B5CF6,
  ['violet-600'] = 0x7C3AED,
  ['violet-700'] = 0x6D28D9,
  ['violet-800'] = 0x5B21B6,
  ['violet-900'] = 0x4C1D95,
  ['violet-950'] = 0x2E1065,
  ['purple-50'] = 0xFAF5FF,
  ['purple-100'] = 0xF3E8FF,
  ['purple-200'] = 0xE9D5FF,
  ['purple-300'] = 0xD8B4FE,
  ['purple-400'] = 0xC084FC,
  ['purple-500'] = 0xA855F7,
  ['purple-600'] = 0x9333EA,
  ['purple-700'] = 0x7E22CE,
  ['purple-800'] = 0x6B21A8,
  ['purple-900'] = 0x581C87,
  ['purple-950'] = 0x3B0764,
  ['fuchsia-50'] = 0xFDF4FF,
  ['fuchsia-100'] = 0xFAE8FF,
  ['fuchsia-200'] = 0xF5D0FE,
  ['fuchsia-300'] = 0xF0ABFC,
  ['fuchsia-400'] = 0xE879F9,
  ['fuchsia-500'] = 0xD946EF,
  ['fuchsia-600'] = 0xC026D3,
  ['fuchsia-700'] = 0xA21CAF,
  ['fuchsia-800'] = 0x86198F,
  ['fuchsia-900'] = 0x701A75,
  ['fuchsia-950'] = 0x4A044E,
  ['pink-50'] = 0xFDF2F8,
  ['pink-100'] = 0xFCE7F3,
  ['pink-200'] = 0xFBCFE8,
  ['pink-300'] = 0xF9A8D4,
  ['pink-400'] = 0xF472B6,
  ['pink-500'] = 0xEC4899,
  ['pink-600'] = 0xDB2777,
  ['pink-700'] = 0xBE185D,
  ['pink-800'] = 0x9D174D,
  ['pink-900'] = 0x831843,
  ['pink-950'] = 0x500724,
  ['rose-50'] = 0xFFF1F2,
  ['rose-100'] = 0xFFE4E6,
  ['rose-200'] = 0xFECDD3,
  ['rose-300'] = 0xFDA4AF,
  ['rose-400'] = 0xFB7185,
  ['rose-500'] = 0xF43F5E,
  ['rose-600'] = 0xE11D48,
  ['rose-700'] = 0xBE123C,
  ['rose-800'] = 0x9F1239,
  ['rose-900'] = 0x881337,
  ['rose-950'] = 0x4C0519,
}

-- }}}
-- Theme {{{

T = {
  text = P['slate-300'],
  text_dim = P['slate-400'],
  text_dimmer = P['slate-500'],
  text_dimmest = P['slate-600'],
  text_conceal = P['slate-700'],

  text_variant = P['gray-300'],
  text_variant_dim = P['gray-400'],
  text_variant_dimmer = P['gray-500'],
  text_variant_dimmest = P['gray-600'],
  text_variant_conceal = P['gray-700'],

  text_red = P['red-200'],
  text_orange = P['orange-100'],
  text_amber = P['amber-100'],
  text_yellow = P['yellow-50'],
  text_lime = P['lime-200'],
  text_green = P['green-200'],
  text_emerald = P['emerald-200'],
  text_teal = P['teal-300'],
  text_cyan = P['cyan-200'],
  text_sky = P['sky-300'],
  text_blue = P['blue-300'],
  text_indigo = P['indigo-200'],
  text_violet = P['violet-200'],
  text_purple = P['purple-200'],
  text_fuchsia = P['fuchsia-200'],
  text_pink = P['pink-200'],
  text_rose = P['rose-200'],

  text_title = P['slate-100'],
  text_link = P['blue-300'],
  text_function = P['blue-300'],

  text_ok = P['green-200'],
  text_error = P['red-200'],
  text_warning = P['amber-100'],
  text_info = P['blue-300'],
  text_hint = P['indigo-300'],

  borders = P['slate-500'],

  surface_dark = P['gray-950'],
  surface = 0x10141E, -- gray-950 + white/5
  surface_cursorline = 0x1C2029, -- surface + white/5
  surface_statusline = 0x1C2029, -- surface + white/5
  surface_menu = 0x1C2029, -- surface + white/5
  surface_menu_cursorline = 0x282B34, -- surface_menu + white/5

  surface_scrollbar = 0x0F1324, -- slate-950 + white/5
  surface_scrollbar_thumb = 0x1B1F2F, -- surface_scrollbar + white/5

  surface_visual = P['blue-800'],
  on_surface_visual = P['blue-50'],

  surface_red = 0x352932, -- surface + red-300/15
  on_surface_red = P['red-200'],

  surface_green = 0x203533, -- surface + green-300/15
  on_surface_green = P['green-200'],

  surface_amber = 0x343121, -- surface + amber-300/15
  on_surface_amber = P['amber-100'],

  surface_blue = 0x232F41, -- surface + blue-300/15
  on_surface_blue = P['blue-300'],

  surface_violet = 0x2B2C41, -- surface + violet-300/15
  on_surface_violet = P['violet-200'],

  NONE = 'NONE',
  UNUSED = 0xFF00FF,
}

-- }}}
-- Terminal groups {{{

vim.g.terminal_color_0 = T.surface
vim.g.terminal_color_8 = T.surface_menu

vim.g.terminal_color_1 = T.text_red
vim.g.terminal_color_9 = T.text_orange

vim.g.terminal_color_2 = T.text_green
vim.g.terminal_color_10 = T.text_emerald

vim.g.terminal_color_3 = T.text_amber
vim.g.terminal_color_11 = T.text_yellow

vim.g.terminal_color_4 = T.text_blue
vim.g.terminal_color_12 = T.text_sky

vim.g.terminal_color_13 = T.text_teal
vim.g.terminal_color_5 = T.text_cyan

vim.g.terminal_color_6 = T.text_indigo
vim.g.terminal_color_14 = T.text_violet

vim.g.terminal_color_7 = T.text
vim.g.terminal_color_15 = T.text_dim

--- }}}

generate_colorscheme {

  -- Editor {{{

  ColorColumn = { bg = T.surface_amber }, -- used for the columns set with 'colorcolumn'
  Conceal = { fg = T.text_variant_conceal }, -- placeholder characters substituted for concealed text (see 'conceallevel')
  Cursor = { fg = T.text, bg = T.surface, reverse = true }, -- character under the cursor
  lCursor = { link = 'Cursor' }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
  CursorIM = { link = 'Cursor' }, -- like Cursor, but used when in IME mode |CursorIM|
  CursorColumn = { link = 'CursorLine' },
  CursorLine = { bg = T.surface_cursorline },
  Directory = { fg = T.text_blue }, -- directory names (and other special names in listings)
  EndOfBuffer = { fg = T.text_conceal }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
  ErrorMsg = { fg = T.text_error }, -- error messages on the command line
  VertSplit = { fg = T.surface }, -- the column separating vertically split windows
  Folded = { fg = T.on_surface_blue, bg = T.surface_blue }, -- line used for closed folds
  FoldColumn = { fg = T.text_variant_dimmer }, -- 'foldcolumn'
  SignColumn = { fg = T.text_variant_dim }, -- column where |signs| are displayed
  SignColumnSB = { fg = T.text_variant_dim, bg = T.surface }, -- column where |signs| are displayed
  Substitute = { fg = T.on_surface_green, bg = T.surface_green }, -- |:substitute| replacement text highlighting
  LineNr = { fg = T.text_variant_dimmer }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
  CursorLineNr = { fg = T.text_pink }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line. highlights the number in numberline.
  MatchParen = { fg = T.UNUSED, bg = T.UNUSED }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
  ModeMsg = { fg = T.text }, -- 'showmode' message (e.g., "-- INSERT -- ")
  -- MsgArea = { fg = T.UNUSED }, -- Area for messages and cmdline, don't set this highlight because of https://github.com/neovim/neovim/issues/17832
  MsgSeparator = { link = 'WinSeparator' }, -- Separator for scrolled messages, `msgsep` flag of 'display'
  MoreMsg = { fg = T.text_blue }, -- |more-prompt|
  NonText = { link = 'Conceal' }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
  Normal = { fg = T.text, bg = T.surface },
  NormalNC = { link = 'Normal' }, -- normal text in non-current windows
  NormalSB = { link = 'Normal' }, -- normal text in non-current windows
  NormalFloat = { link = 'Normal' }, -- normal text in floating windows
  FloatBorder = { fg = T.borders, bg = T.NONE },
  FloatTitle = { link = 'Title' }, -- Title of floating windows
  FloatShadow = { fg = T.NONE },
  Pmenu = { fg = T.text, bg = T.surface_menu }, -- Popup menu: normal item.
  PmenuSel = { bg = T.surface_menu_cursorline }, -- Popup menu: selected item.
  PmenuMatch = { fg = T.text, bold = true }, -- Popup menu: matching text.
  PmenuMatchSel = { bold = true }, -- Popup menu: matching text in selected item; is combined with |hl-PmenuMatch| and |hl-PmenuSel|.
  PmenuSbar = { bg = T.surface_scrollbar }, -- Popup menu: scrollbar.
  PmenuThumb = { bg = T.surface_scrollbar_thumb }, -- Popup menu: Thumb of the scrollbar.
  PmenuExtra = { fg = T.text_dim }, -- Popup menu: normal item extra text.
  PmenuExtraSel = { fg = T.text_dim, bg = T.surface_menu_cursorline, bold = true }, -- Popup menu: selected item extra text.
  ComplMatchIns = { link = 'PreInsert' }, -- Matched text of the currently inserted completion.
  PreInsert = { fg = T.text_dimmer }, -- Text inserted when "preinsert" is in 'completeopt'.
  ComplHint = { fg = T.text_dim }, -- Virtual text of the currently selected completion.
  ComplHintMore = { link = 'Question' }, -- The additional information of the virtual text.
  Question = { fg = T.text_blue }, -- |hit-enter| prompt and yes/no questions
  QuickFixLine = { bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
  Search = { fg = T.on_surface_amber, bg = T.surface_amber }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
  IncSearch = { fg = T.on_surface_amber, bg = T.surface_amber }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
  CurSearch = { fg = T.on_surface_amber, bg = T.surface_amber, standout = true }, -- 'cursearch' highlighting: highlights the current search you're on differently
  SpecialKey = { link = 'NonText' }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' textspace. |hl-Whitespace|
  SpellBad = { sp = T.text_red, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
  SpellCap = { sp = T.text_yellow, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
  SpellLocal = { sp = T.text_blue, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
  SpellRare = { sp = T.text_green, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
  StatusLine = { fg = T.text_dim, bg = T.surface_statusline }, -- status line of current window
  StatusLineNC = { link = 'StatusLine' }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
  TabLine = { fg = T.text_dimmer, bg = T.surface }, -- tab pages line, not active tab page label
  TabLineFill = { link = 'TabLine' }, -- tab pages line, where there are no labels
  TabLineSel = { fg = T.text, bg = T.surface, bold = true }, -- tab pages line, active tab page label
  TermCursor = { link = 'Cursor' }, -- cursor in a focused terminal
  TermCursorNC = { link = 'Cursor' }, -- cursor in unfocused terminals
  Title = { fg = T.text_title, bold = true },
  Visual = { fg = T.on_surface_visual, bg = T.surface_visual },
  VisualNOS = { link = 'Visual' },
  WarningMsg = { fg = T.text_yellow }, -- warning messages
  Whitespace = { link = 'Conceal' }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
  WildMenu = { bg = T.UNUSED }, -- current match in 'wildmenu' completion
  WinBar = { fg = T.UNUSED },
  WinBarNC = { link = 'WinBar' },
  WinSeparator = { fg = T.text_variant_conceal },

  -- }}}
  -- Syntax {{{

  Punctuation = { fg = T.text_dimmer },

  Comment = { fg = T.text_variant_dimmer },
  SpecialComment = { link = 'Special' }, -- special things inside a comment
  Constant = { fg = T.text_orange }, -- (preferred) any constant
  String = { fg = T.text_green }, -- a string constant: "this is a string"
  Character = { fg = T.text_teal }, --  a character constant: 'c', '\n'
  Number = { fg = T.text_red }, --   a number constant: 234, 0xff
  Float = { link = 'Number' }, -- a floating point constant: 2.3e10
  Boolean = { fg = T.text_cyan }, -- a boolean constant: TRUE, false
  Identifier = { fg = T.text }, -- (preferred) any variable name
  Function = { fg = T.text_function }, -- function name (also: methods for classes)
  Statement = { fg = T.text, bold = true }, -- (preferred) any statement
  Conditional = { fg = T.text_indigo }, --  if, then, else, endif, switch, etc.
  Repeat = { link = 'Conditional' }, --   for, do, while, etc.
  Label = { fg = T.text_sky }, --    case, default, etc.
  Operator = { link = 'Punctuation' }, -- "sizeof", "+", "*", etc.
  Keyword = { fg = T.text_variant, bold = true }, --  any other keyword
  Exception = { link = 'Statement' }, --  try, catch, throw

  PreProc = { fg = T.text_pink }, -- (preferred) generic Preprocessor
  Include = { fg = T.text_indigo }, --  preprocessor #include
  Define = { link = 'PreProc' }, -- preprocessor #define
  Macro = { fg = T.text_indigo }, -- same as Define
  PreCondit = { link = 'PreProc' }, -- preprocessor #if, #else, #endif, etc.

  StorageClass = { fg = T.text_amber }, -- static, register, volatile, etc.
  Structure = { fg = T.text_amber }, --  struct, union, enum, etc.
  Special = { fg = T.text_pink }, -- (preferred) any special symbol
  Type = { fg = T.text_amber }, -- (preferred) int, long, char, etc.
  Typedef = { link = 'Type' }, --  A typedef
  SpecialChar = { link = 'Special' }, -- special character in a constant
  Tag = { fg = T.text_purple, bold = true }, -- you can use CTRL-] on this
  Delimiter = { link = 'Punctuation' }, -- character that needs attention
  Debug = { link = 'Special' }, -- debugging statements

  Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
  Bold = { bold = true },
  Italic = { italic = true },
  -- ("Ignore", below, may be invisible…)
  -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

  Error = { fg = T.text_error }, -- (preferred) any erroneous construct
  Todo = { fg = T.text_sky, bold = true }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
  qfLineNr = { fg = T.text_amber },
  qfFileName = { fg = T.text_blue },
  htmlH1 = { fg = T.text_pink, bold = true },
  htmlH2 = { fg = T.text_blue, bold = true },
  mkdHeading = { fg = T.text, bold = true },
  mkdCode = { fg = T.text, bg = T.surface_dark },
  mkdCodeDelimiter = { fg = T.text, bg = T.surface },
  mkdCodeStart = { fg = T.text_pink, bold = true },
  mkdCodeEnd = { fg = T.text_pink, bold = true },
  mkdLink = { fg = T.text_link, underline = true },

  -- diff
  Added = { fg = T.text_green },
  Changed = { fg = T.text_blue },
  diffAdded = { fg = T.text_green },
  diffRemoved = { fg = T.text_red },
  diffChanged = { fg = T.text_blue },
  diffOldFile = { fg = T.text_amber },
  diffNewFile = { fg = T.text_orange },
  diffFile = { fg = T.text_blue },
  diffLine = { fg = T.surface },
  diffIndexLine = { fg = T.text_teal },
  DiffAdd = { bg = T.surface_green }, -- diff mode: Added line |diff.txt|
  DiffChange = { bg = T.surface_blue }, -- diff mode: Changed line |diff.txt|
  DiffDelete = { bg = T.surface_red }, -- diff mode: Deleted line |diff.txt|
  DiffText = { bg = T.surface_violet }, -- diff mode: Changed text within a changed line |diff.txt|

  -- NeoVim
  healthError = { fg = T.text_error },
  healthSuccess = { fg = T.text_ok },
  healthWarning = { fg = T.text_warning },

  -- rainbow
  rainbow1 = { fg = T.text_red },
  rainbow2 = { fg = T.text_orange },
  rainbow3 = { fg = T.text_yellow },
  rainbow4 = { fg = T.text_green },
  rainbow5 = { fg = T.text_sky },
  rainbow6 = { fg = T.text_violet },

  -- markdown
  markdownHeadingDelimiter = { fg = T.text_orange, bold = true },
  markdownCode = { fg = T.text_rose },
  markdownCodeBlock = { fg = T.text_rose },
  markdownLinkText = { fg = T.text_link, underline = true },
  markdownH1 = { link = 'rainbow1' },
  markdownH2 = { link = 'rainbow2' },
  markdownH3 = { link = 'rainbow3' },
  markdownH4 = { link = 'rainbow4' },
  markdownH5 = { link = 'rainbow5' },
  markdownH6 = { link = 'rainbow6' },

  -- }}}
  -- Diagnostics and LSP {{{

  LspReferenceText = { bg = T.surface_menu }, -- used for highlighting "text" references
  LspReferenceRead = { bg = T.surface_menu }, -- used for highlighting "read" references
  LspReferenceWrite = { bg = T.surface_menu }, -- used for highlighting "write" references
  LspSignatureActiveParameter = { fg = T.text_indigo, bold = true },
  LspCodeLens = { fg = T.text_variant_dimmer }, -- virtual text of the codelens
  LspCodeLensSeparator = { link = 'LspCodeLens' }, -- virtual text of the codelens separators
  -- fg of `Comment` and bg of `CursorLine`.
  LspInlayHint = { fg = T.text_variant_dimmer, bg = T.surface_cursorline }, -- virtual text of the inlay hints
  LspInfoBorder = { link = 'FloatBorder' },

  DiagnosticOk = { fg = T.text_ok },
  DiagnosticHint = { fg = T.text_hint },
  DiagnosticInfo = { fg = T.text_info },
  DiagnosticWarn = { fg = T.text_warning },
  DiagnosticError = { fg = T.text_error },
  DiagnosticFloatingOk = { link = 'DiagnosticOk' }, -- Used to color diagnostic messages in diagnostics float
  DiagnosticFloatingHint = { link = 'DiagnosticHint' },
  DiagnosticFloatingInfo = { link = 'DiagnosticInfo' },
  DiagnosticFloatingWarn = { link = 'DiagnosticWarn' },
  DiagnosticFloatingError = { link = 'DiagnosticError' },
  DiagnosticSignOk = { link = 'DiagnosticOk' }, -- Used for signs in sign column
  DiagnosticSignHint = { link = 'DiagnosticHint' },
  DiagnosticSignInfo = { link = 'DiagnosticInfo' },
  DiagnosticSignWarn = { link = 'DiagnosticWarn' },
  DiagnosticSignError = { link = 'DiagnosticError' },
  DiagnosticUnderlineOk = { sp = T.text_ok, undercurl = true }, -- Used to underline diagnostics
  DiagnosticUnderlineHint = { sp = T.text_hint, undercurl = true },
  DiagnosticUnderlineInfo = { sp = T.text_info, undercurl = true },
  DiagnosticUnderlineWarn = { sp = T.text_warning, undercurl = true },
  DiagnosticUnderlineError = { sp = T.text_error, undercurl = true },
  DiagnosticVirtualTextOk = { fg = T.on_surface_green, bg = T.surface_green }, -- Used as the mantle highlight group. Other Diagnostic highlights link to this by default
  DiagnosticVirtualTextHint = { fg = T.on_surface_violet, bg = T.surface_violet },
  DiagnosticVirtualTextInfo = { fg = T.on_surface_blue, bg = T.surface_blue },
  DiagnosticVirtualTextWarn = { fg = T.on_surface_amber, bg = T.surface_amber },
  DiagnosticVirtualTextError = { fg = T.on_surface_red, bg = T.surface_red },

  LspDiagnosticsHint = { link = 'DiagnosticHint' },
  LspDiagnosticsInformation = { link = 'DiagnosticInfo' },
  LspDiagnosticsWarning = { link = 'DiagnosticWarn' },
  LspDiagnosticsError = { link = 'DiagnosticError' },
  LspDiagnosticsDefaultHint = { link = 'DiagnosticHint' }, -- Used as the mantle highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
  LspDiagnosticsDefaultInformation = { link = 'DiagnosticInfo' },
  LspDiagnosticsDefaultWarning = { link = 'DiagnosticWarn' },
  LspDiagnosticsDefaultError = { link = 'DiagnosticError' },
  LspDiagnosticsVirtualTextHint = { link = 'DiagnosticVirtualTextHint' }, -- Used for diagnostic virtual text
  LspDiagnosticsVirtualTextInformation = { link = 'DiagnosticVirtualTextInfo' },
  LspDiagnosticsVirtualTextWarning = { link = 'DiagnosticVirtualTextWarn' },
  LspDiagnosticsVirtualTextError = { link = 'DiagnosticVirtualTextError' },

  -- }}}
  -- Treesitter {{{

  -- Identifiers
  ['@variable'] = { fg = T.text }, -- Any variable name that does not have another highlight.
  ['@variable.builtin'] = { fg = T.text_purple }, -- Variable names that are defined by the languages, like this or self.
  ['@variable.parameter'] = { fg = T.text_red, italic = true }, -- For parameters of a function.
  ['@variable.member'] = { fg = T.text_pink }, -- For fields.

  ['@constant'] = { link = 'Constant' }, -- For constants
  ['@constant.builtin'] = { fg = T.text_orange }, -- For constant that are built in the language: nil in Lua.
  ['@constant.macro'] = { link = 'Macro' }, -- For constants that are defined by macros: NULL in C.

  ['@module'] = { fg = T.text_amber, italic = true }, -- For identifiers referring to modules and namespaces.
  ['@label'] = { link = 'Label' }, -- For labels: label: in C and :label: in Lua.

  -- Literals
  ['@string'] = { link = 'String' }, -- For strings.
  ['@string.documentation'] = { fg = T.text_teal }, -- For strings documenting code (e.g. Python docstrings).
  ['@string.regexp'] = { fg = T.text_pink }, -- For regexes.
  ['@string.escape'] = { fg = T.text_pink }, -- For escape characters within a string.
  ['@string.special'] = { link = 'Special' }, -- other special strings (e.g. dates)
  ['@string.special.path'] = { link = 'Special' }, -- filenames
  ['@string.special.symbol'] = { fg = T.text_pink }, -- symbols or atoms
  ['@string.special.url'] = { fg = T.text_link, italic = true, underline = true }, -- urls, links and emails
  ['@punctuation.delimiter.regex'] = { link = '@string.regexp' },

  ['@character'] = { link = 'Character' }, -- character literals
  ['@character.special'] = { link = 'SpecialChar' }, -- special characters (e.g. wildcards)

  ['@boolean'] = { link = 'Boolean' }, -- For booleans.
  ['@number'] = { link = 'Number' }, -- For all numbers
  ['@number.float'] = { link = 'Float' }, -- For floats.

  -- Types
  ['@type'] = { link = 'Type' }, -- For types.
  ['@type.builtin'] = { fg = T.text_purple, italic = true }, -- For builtin types.
  ['@type.definition'] = { link = 'Type' }, -- type definitions (e.g. `typedef` in C)

  ['@attribute'] = { link = 'Constant' }, -- attribute annotations (e.g. Python decorators)
  ['@property'] = { fg = T.text_function }, -- For fields, like accessing `bar` property on `foo.bar`. Overriden later for data languages and CSS.

  -- Functions
  ['@function'] = { link = 'Function' }, -- For function (calls and definitions).
  ['@function.builtin'] = { fg = T.text_orange }, -- For builtin functions: table.insert in Lua.
  ['@function.call'] = { link = 'Function' }, -- function calls
  ['@function.macro'] = { link = 'Macro' }, -- For macro defined functions (calls and definitions): each macro_rules in Rust.

  ['@function.method'] = { link = 'Function' }, -- For method definitions.
  ['@function.method.call'] = { link = 'Function' }, -- For method calls.

  ['@constructor'] = { fg = T.text_amber }, -- For constructor calls and definitions: = { } in Lua, and Java constructors.
  ['@operator'] = { link = 'Operator' }, -- For any operator: +, but also -> and * in C.

  -- Keywords
  ['@keyword'] = { link = 'Keyword' }, -- For keywords that don't fall in previous categories.
  ['@keyword.modifier'] = { link = 'Keyword' }, -- For keywords modifying other constructs (e.g. `const`, `static`, `public`)
  ['@keyword.type'] = { link = 'Keyword' }, -- For keywords describing composite types (e.g. `struct`, `enum`)
  ['@keyword.coroutine'] = { link = 'Keyword' }, -- For keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
  ['@keyword.function'] = { fg = T.text_indigo }, -- For keywords used to define a function.
  ['@keyword.operator'] = { fg = T.text_indigo }, -- For new keyword operator
  ['@keyword.import'] = { link = 'Include' }, -- For includes: #include in C, use or extern crate in Rust, or require in Lua.
  ['@keyword.repeat'] = { link = 'Repeat' }, -- For keywords related to loops.
  ['@keyword.return'] = { fg = T.text_indigo },
  ['@keyword.debug'] = { link = 'Exception' }, -- For keywords related to debugging
  ['@keyword.exception'] = { link = 'Exception' }, -- For exception related keywords.

  ['@keyword.conditional'] = { link = 'Conditional' }, -- For keywords related to conditionnals.
  ['@keyword.conditional.ternary'] = { link = 'Operator' }, -- For ternary operators (e.g. `?` / `:`)

  ['@keyword.directive'] = { link = 'PreProc' }, -- various preprocessor directives & shebangs
  ['@keyword.directive.define'] = { link = 'Define' }, -- preprocessor definition directives
  ['@keyword.export'] = { fg = T.text_indigo }, -- JS & derivative

  -- Punctuation
  ['@punctuation.delimiter'] = { link = 'Delimiter' }, -- For delimiters (e.g. `;` / `.` / `,`).
  ['@punctuation.bracket'] = { link = 'Punctuation' }, -- For brackets and parenthesis.
  ['@punctuation.special'] = { link = 'Special' }, -- For special punctuation that does not fall in the categories before (e.g. `{}` in string interpolation).

  -- Comment
  ['@comment'] = { link = 'Comment' },
  ['@comment.documentation'] = { link = 'Comment' }, -- For comments documenting code

  ['@comment.error'] = { fg = T.text_error, bold = true },
  ['@comment.warning'] = { fg = T.text_warning, bold = true },
  ['@comment.hint'] = { fg = T.text_hint, bold = true },
  ['@comment.todo'] = { fg = T.text_info, bold = true },
  ['@comment.note'] = { link = 'Title' },

  -- Markup
  ['@markup'] = { fg = T.text }, -- For strings considerated text in a markup language.
  ['@markup.strong'] = { link = 'Bold' }, -- bold
  ['@markup.italic'] = { link = 'Italic' }, -- italic
  ['@markup.strikethrough'] = { strikethrough = true }, -- strikethrough text
  ['@markup.underline'] = { link = 'Underlined' }, -- underlined text

  ['@markup.heading'] = { link = 'Title' }, -- titles like: # Example
  ['@markup.heading.markdown'] = { bold = true }, -- bold headings in markdown, but not in HTML or other markup

  -- ['@markup.math'] = { fg = C.blue }, -- math environments (e.g. `$ ... $` in LaTeX)
  -- ['@markup.quote'] = { fg = C.pink }, -- block quotes
  -- ['@markup.environment'] = { fg = C.pink }, -- text environments of markup languages
  -- ['@markup.environment.name'] = { fg = C.blue }, -- text indicating the type of an environment

  ['@markup.link'] = { fg = T.text_link, underline = true }, -- text references, footnotes, citations, etc.
  ['@markup.link.label'] = { link = '@markup.link' }, -- link, reference descriptions
  ['@markup.link.url'] = { link = '@markup.link' }, -- urls, links and emails

  ['@markup.raw'] = { fg = T.text_green }, -- used for inline code in markdown and for doc in python (""")

  ['@markup.list'] = { fg = T.text_teal },
  ['@markup.list.checked'] = { fg = T.text_green }, -- todo notes
  ['@markup.list.unchecked'] = { fg = T.text_dim }, -- todo notes

  -- Diff
  ['@diff.plus'] = { link = 'diffAdded' }, -- added text (for diff files)
  ['@diff.minus'] = { link = 'diffRemoved' }, -- deleted text (for diff files)
  ['@diff.delta'] = { link = 'diffChanged' }, -- deleted text (for diff files)

  -- Tags
  ['@tag'] = { fg = T.text_blue }, -- Tags like HTML tag names.
  ['@tag.builtin'] = { fg = T.text_blue }, -- JSX tag names.
  ['@tag.attribute'] = { fg = T.text_amber, italic = true }, -- XML/HTML attributes (foo in foo="bar").
  ['@tag.delimiter'] = { fg = T.text_teal }, -- Tag delimiter like < > /

  -- Misc
  ['@error'] = { link = 'Error' },

  -- Language specific {{{

  -- markdown
  ['@markup.heading.1.markdown'] = { link = 'markdownH1' },
  ['@markup.heading.2.markdown'] = { link = 'markdownH2' },
  ['@markup.heading.3.markdown'] = { link = 'markdownH3' },
  ['@markup.heading.4.markdown'] = { link = 'markdownH4' },
  ['@markup.heading.5.markdown'] = { link = 'markdownH5' },
  ['@markup.heading.6.markdown'] = { link = 'markdownH6' },

  -- html
  ['@markup.heading.html'] = { link = '@markup' },
  ['@markup.heading.1.html'] = { link = '@markup' },
  ['@markup.heading.2.html'] = { link = '@markup' },
  ['@markup.heading.3.html'] = { link = '@markup' },
  ['@markup.heading.4.html'] = { link = '@markup' },
  ['@markup.heading.5.html'] = { link = '@markup' },
  ['@markup.heading.6.html'] = { link = '@markup' },

  ['@string.special.url.html'] = { fg = T.text_green }, -- Links in href, src attributes.
  ['@markup.link.label.html'] = { fg = T.text }, -- Text between <a></a> tags.
  ['@character.special.html'] = { fg = T.text_red }, -- Symbols such as &nbsp;.

  -- CSS
  ['@property.css'] = { fg = T.text_blue },
  ['@property.scss'] = { fg = T.text_blue },
  ['@property.id.css'] = { fg = T.text_amber },
  ['@property.class.css'] = { fg = T.text_amber },
  ['@type.css'] = { fg = T.text_indigo },
  ['@type.tag.css'] = { fg = T.text_blue },
  ['@string.plain.css'] = { fg = T.text},
  ['@keyword.directive.css'] = { link = 'Keyword' }, -- CSS at-rules: https://developer.mozilla.org/en-US/docs/Web/CSS/At-rule.

  -- Lua
  ['@constructor.lua'] = { link = '@punctuation.bracket' }, -- For constructor calls and definitions: = { } in Lua.

  -- Python
  ['@constructor.python'] = { fg = T.text_sky }, -- __init__(), __new__().

  -- C/CPP
  ['@keyword.import.c'] = { link = 'Include' },
  ['@keyword.import.cpp'] = { link = 'Include' },

  -- gitcommit
  ['@comment.warning.gitcommit'] = { fg = T.text_warning },

  -- gitignore
  ['@string.special.path.gitignore'] = { fg = T.text },

  -- }}}
  -- }}}
  -- StatusLine {{{

  StatusLineFocusedPrimary = { fg = T.text, bold = true },
  StatusLineFocusedSecondary = { fg = T.text_dim },

  StatusLineUnfocusedPrimary = { fg = T.text_dim, bold = true },
  StatusLineUnfocusedSecondary = { fg = T.text_dim },

  -- }}}
  -- Cmp {{{

  CmpItemAbbr = { fg = T.text_dim },
  CmpItemAbbrDeprecated = { fg = T.text_dim, strikethrough = true },
  CmpItemKind = { fg = T.text_blue },
  CmpItemMenu = { fg = T.text },
  CmpItemAbbrMatch = { fg = T.text, bold = true },
  CmpItemAbbrMatchFuzzy = { fg = T.text, bold = true },

  -- kind support
  CmpItemKindSnippet = { fg = T.text_violet },
  CmpItemKindKeyword = { fg = T.text_red },
  CmpItemKindText = { fg = T.text_teal },
  CmpItemKindMethod = { link = 'Function' },
  CmpItemKindConstructor = { link = 'Function' },
  CmpItemKindFunction = { link = 'Function' },
  CmpItemKindFolder = { link = 'Directory' },
  CmpItemKindModule = { fg = T.text_blue },
  CmpItemKindConstant = { link = 'Constant' },
  CmpItemKindField = { fg = T.text_green },
  CmpItemKindProperty = { fg = T.text_green },
  CmpItemKindEnum = { fg = T.text_green },
  CmpItemKindUnit = { fg = T.text_green },
  CmpItemKindClass = { fg = T.text_amber },
  CmpItemKindVariable = { fg = T.text_pink },
  CmpItemKindFile = { fg = T.text_blue },
  CmpItemKindInterface = { fg = T.text_amber },
  CmpItemKindColor = { fg = T.text_red },
  CmpItemKindReference = { fg = T.text_red },
  CmpItemKindEnumMember = { fg = T.text_red },
  CmpItemKindStruct = { fg = T.text_blue },
  CmpItemKindValue = { fg = T.text_orange },
  CmpItemKindEvent = { fg = T.text_blue },
  CmpItemKindOperator = { fg = T.text_blue },
  CmpItemKindTypeParameter = { fg = T.text_blue },
  CmpItemKindCopilot = { fg = T.text_teal },

  -- }}}
  -- Noice {{{

  NoiceCmdLine = { link = 'Normal' },
  NoiceCmdlinePopupBorder = { link = 'FloatBorder' },
  NoiceCmdLineIcon = { link = 'Normal' },
  NoiceCmdlineIconCmdline = { fg = T.text_emerald },
  NoiceCmdlineIconLua = { fg = T.text_violet },
  NoiceConfirmBorder = { fg = T.text_red },

  -- }}}
  -- render markdown {{{

  RenderMarkdownH1 = { link = 'markdownH1' },
  RenderMarkdownH2 = { link = 'markdownH2' },
  RenderMarkdownH3 = { link = 'markdownH3' },
  RenderMarkdownH4 = { link = 'markdownH4' },
  RenderMarkdownH5 = { link = 'markdownH5' },
  RenderMarkdownH6 = { link = 'markdownH6' },
  RenderMarkdownCode = { bg = T.surface_dark },
  RenderMarkdownCodeInline = { bg = T.text },
  RenderMarkdownBullet = { fg = T.text_sky },
  RenderMarkdownTableHead = { fg = T.text_blue },
  RenderMarkdownTableRow = { fg = T.text_indigo },
  RenderMarkdownSuccess = { fg = T.text_ok },
  RenderMarkdownInfo = { fg = T.text_info },
  RenderMarkdownHint = { fg = T.text_hint },
  RenderMarkdownWarn = { fg = T.text_warning },
  RenderMarkdownError = { fg = T.text_error },

  -- }}}
  -- Snacks {{{

  SnacksNormal = { link = 'Normal' },
  SnacksWinBar = { link = 'Title' },
  SnacksBackdrop = { link = 'FloatShadow' },
  SnacksNormalNC = { link = 'NormalFloat' },
  SnacksWinBarNC = { link = 'SnacksWinBar' },

  SnacksNotifierInfo = { link = 'DiagnosticInfo' },
  SnacksNotifierIconInfo = { link = 'DiagnosticInfo' },
  SnacksNotifierTitleInfo = { fg = T.text_info, italic = true },
  SnacksNotifierBorderInfo = { link = 'DiagnosticInfo' },
  SnacksNotifierFooterInfo = { link = 'DiagnosticInfo' },
  SnacksNotifierWarn = { link = 'DiagnosticWarn' },
  SnacksNotifierIconWarn = { link = 'DiagnosticWarn' },
  SnacksNotifierTitleWarn = { fg = T.text_warning, italic = true },
  SnacksNotifierBorderWarn = { link = 'DiagnosticWarn' },
  SnacksNotifierFooterWarn = { link = 'DiagnosticWarn' },
  SnacksNotifierDebug = { link = 'DiagnosticHint' },
  SnacksNotifierIconDebug = { link = 'DiagnosticHint' },
  SnacksNotifierTitleDebug = { fg = T.text_hint, italic = true },
  SnacksNotifierBorderDebug = { link = 'DiagnosticHint' },
  SnacksNotifierFooterDebug = { link = 'DiagnosticHint' },
  SnacksNotifierError = { link = 'DiagnosticError' },
  SnacksNotifierIconError = { link = 'DiagnosticError' },
  SnacksNotifierTitleError = { fg = T.text_error, italic = true },
  SnacksNotifierBorderError = { link = 'DiagnosticError' },
  SnacksNotifierFooterError = { link = 'DiagnosticError' },
  SnacksNotifierTrace = { fg = T.text_fuchsia },
  SnacksNotifierIconTrace = { fg = T.text_fuchsia },
  SnacksNotifierTitleTrace = { fg = T.text_fuchsia, italic = true },
  SnacksNotifierBorderTrace = { fg = T.text_fuchsia },
  SnacksNotifierFooterTrace = { fg = T.text_fuchsia },

  SnacksDashboardNormal = { link = 'Normal' },
  SnacksDashboardDesc = { fg = T.text_blue },
  SnacksDashboardFile = { fg = T.text_indigo },
  SnacksDashboardDir = { link = 'NonText' },
  SnacksDashboardFooter = { fg = T.text_amber, italic = true },
  SnacksDashboardHeader = { fg = T.text_blue },
  SnacksDashboardIcon = { fg = T.text_pink, bold = true },
  SnacksDashboardKey = { fg = T.text_orange },
  SnacksDashboardTerminal = { link = 'SnacksDashboardNormal' },
  SnacksDashboardSpecial = { link = 'Special' },
  SnacksDashboardTitle = { link = 'Title' },

  SnacksIndent = { fg = T.surface },
  SnacksIndentScope = { fg = T.text },

  SnacksPickerSelected = { fg = T.text_pink, bg = T.surface, bold = true },
  SnacksPickerMatch = { fg = T.text_blue },

  SnacksPicker = { link = 'NormalFloat' },
  SnacksPickerBorder = { link = 'FloatBorder' },
  SnacksPickerDir = { link = 'SnacksPickerDimmed' },
  SnacksPickerDimmed = { fg = T.text_dimmer },
  SnacksPickerInputBorder = { link = 'SnacksPickerBorder' },
  SnacksPickerInput = { link = 'NormalFloat' },
  SnacksPickerPrompt = { fg = T.text_pink },
  SnacksPickerTitle = { link = 'Title' },
  SnacksPickerPreviewTitle = { link = 'SnacksPickerTitle' },
  SnacksPickerInputTitle = { link = 'SnacksPickerTitle' },
  SnacksPickerListTitle = { link = 'SnacksPickerTitle' },
  SnacksPickerInputCursorLine = { link = 'Normal' },

  -- }}}
  -- CompileMode {{{

  CompileModeError = { link = 'Error' },
  CompileModeInfo = { bold = true },
  CompileModeWarning = { link = 'WarningMsg' },
  CompileModeMessage = { link = 'Normal' },
  CompileModeMessageRow = { link = 'Normal' },
  CompileModeMessageCol = { link = 'Normal' },
  CompileModeCommandOutput = { fg = T.text_blue },
  CompileModeOutputFile = { link = 'Normal' },
  CompileModeCheckResult = { bold = true },
  CompileModeCheckTarget = { link = 'Normal' },
  CompileModeDirectoryMessage = { link = 'Normal' },
  CompileModeErrorLocus = { link = 'Normal' },

  -- }}}
}
