theme: ''
-- Terminal groups {{{

vim.g.terminal_color_0 = ${theme.surface}
vim.g.terminal_color_8 = ${theme.surface_menu}

vim.g.terminal_color_1 = ${theme.text_red}
vim.g.terminal_color_9 = ${theme.text_orange}

vim.g.terminal_color_2 = ${theme.text_green}
vim.g.terminal_color_10 = ${theme.text_emerald}

vim.g.terminal_color_3 = ${theme.text_amber}
vim.g.terminal_color_11 = ${theme.text_yellow}

vim.g.terminal_color_4 = ${theme.text_blue}
vim.g.terminal_color_12 = ${theme.text_sky}

vim.g.terminal_color_13 = ${theme.text_teal}
vim.g.terminal_color_5 = ${theme.text_cyan}

vim.g.terminal_color_6 = ${theme.text_indigo}
vim.g.terminal_color_14 = ${theme.text_violet}

vim.g.terminal_color_7 = ${theme.text}
vim.g.terminal_color_15 = ${theme.text_dim}

--- }}}

---@param groups {[string]: table}
local function load_colorscheme(groups)
  if type(groups) ~= 'table' then
    error('generate_colorscheme: invalid parameter: expected a table, got ' .. type(groups))
  end

  for group, setting in pairs(groups) do
    vim.api.nvim_set_hl(0, group, setting)
  end
end

load_colorscheme {

  -- Editor {{{

  ColorColumn = { bg = ${theme.surface_amber} }, -- used for the columns set with 'colorcolumn'
  Conceal = { fg = ${theme.text_variant_conceal} }, -- placeholder characters substituted for concealed text (see 'conceallevel')
  Cursor = { fg = ${theme.text}, bg = ${theme.surface}, reverse = true }, -- character under the cursor
  lCursor = { link = 'Cursor' }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
  CursorIM = { link = 'Cursor' }, -- like Cursor, but used when in IME mode |CursorIM|
  CursorColumn = { link = 'CursorLine' },
  CursorLine = { bg = ${theme.surface_cursorline} },
  Directory = { fg = ${theme.text_blue} }, -- directory names (and other special names in listings)
  EndOfBuffer = { fg = ${theme.text_conceal} }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
  ErrorMsg = { fg = ${theme.text_error} }, -- error messages on the command line
  VertSplit = { fg = ${theme.surface} }, -- the column separating vertically split windows
  Folded = { fg = ${theme.on_surface_blue}, bg = ${theme.surface_blue} }, -- line used for closed folds
  FoldColumn = { fg = ${theme.text_variant_dimmer} }, -- 'foldcolumn'
  SignColumn = { fg = ${theme.text_variant_dim} }, -- column where |signs| are displayed
  SignColumnSB = { fg = ${theme.text_variant_dim}, bg = ${theme.surface} }, -- column where |signs| are displayed
  Substitute = { fg = ${theme.on_surface_green}, bg = ${theme.surface_green} }, -- |:substitute| replacement text highlighting
  LineNr = { fg = ${theme.text_variant_dimmer} }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
  CursorLineNr = { fg = ${theme.text_pink} }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line. highlights the number in numberline.
  MatchParen = { fg = ${theme.UNUSED}, bg = ${theme.UNUSED} }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
  ModeMsg = { fg = ${theme.text} }, -- 'showmode' message (e.g., "-- INSERT -- ")
  -- MsgArea = { fg = ${theme.UNUSED} }, -- Area for messages and cmdline, don't set this highlight because of https://github.com/neovim/neovim/issues/17832
  MsgSeparator = { link = 'WinSeparator' }, -- Separator for scrolled messages, `msgsep` flag of 'display'
  MoreMsg = { fg = ${theme.text_blue} }, -- |more-prompt|
  NonText = { link = 'Conceal' }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
  Normal = { fg = ${theme.text}, bg = ${theme.surface} },
  NormalNC = { link = 'Normal' }, -- normal text in non-current windows
  NormalSB = { link = 'Normal' }, -- normal text in non-current windows
  NormalFloat = { link = 'Normal' }, -- normal text in floating windows
  FloatBorder = { fg = ${theme.borders}, bg = 'NONE' },
  FloatTitle = { link = 'Title' }, -- Title of floating windows
  FloatShadow = { fg = 'NONE' },
  Pmenu = { fg = ${theme.text}, bg = ${theme.surface_menu} }, -- Popup menu: normal item.
  PmenuSel = { bg = ${theme.surface_menu_cursorline} }, -- Popup menu: selected item.
  PmenuMatch = { fg = ${theme.text}, bold = true }, -- Popup menu: matching text.
  PmenuMatchSel = { bold = true }, -- Popup menu: matching text in selected item; is combined with |hl-PmenuMatch| and |hl-PmenuSel|.
  PmenuSbar = { bg = ${theme.surface_scrollbar} }, -- Popup menu: scrollbar.
  PmenuThumb = { bg = ${theme.surface_scrollbar_thumb} }, -- Popup menu: Thumb of the scrollbar.
  PmenuExtra = { fg = ${theme.text_dim} }, -- Popup menu: normal item extra text.
  PmenuExtraSel = { fg = ${theme.text_dim}, bg = ${theme.surface_menu_cursorline}, bold = true }, -- Popup menu: selected item extra text.
  ComplMatchIns = { link = 'PreInsert' }, -- Matched text of the currently inserted completion.
  PreInsert = { fg = ${theme.text_dimmer} }, -- Text inserted when "preinsert" is in 'completeopt'.
  ComplHint = { fg = ${theme.text_dim} }, -- Virtual text of the currently selected completion.
  ComplHintMore = { link = 'Question' }, -- The additional information of the virtual text.
  Question = { fg = ${theme.text_blue} }, -- |hit-enter| prompt and yes/no questions
  QuickFixLine = { bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
  Search = { fg = ${theme.on_surface_amber}, bg = ${theme.surface_amber} }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
  IncSearch = { fg = ${theme.on_surface_amber}, bg = ${theme.surface_amber} }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
  CurSearch = { fg = ${theme.on_surface_amber}, bg = ${theme.surface_amber}, standout = true }, -- 'cursearch' highlighting: highlights the current search you're on differently
  SpecialKey = { link = 'NonText' }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' textspace. |hl-Whitespace|
  SpellBad = { sp = ${theme.text_red}, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
  SpellCap = { sp = ${theme.text_yellow}, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
  SpellLocal = { sp = ${theme.text_blue}, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
  SpellRare = { sp = ${theme.text_green}, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
  StatusLine = { fg = ${theme.text_dim}, bg = ${theme.surface_statusline} }, -- status line of current window
  StatusLineNC = { link = 'StatusLine' }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
  TabLine = { fg = ${theme.text_dimmer}, bg = ${theme.surface} }, -- tab pages line, not active tab page label
  TabLineFill = { link = 'TabLine' }, -- tab pages line, where there are no labels
  TabLineSel = { fg = ${theme.text}, bg = ${theme.surface}, bold = true }, -- tab pages line, active tab page label
  TermCursor = { link = 'Cursor' }, -- cursor in a focused terminal
  TermCursorNC = { link = 'Cursor' }, -- cursor in unfocused terminals
  Title = { fg = ${theme.text_title}, bold = true },
  Visual = { fg = ${theme.on_surface_visual}, bg = ${theme.surface_visual} },
  VisualNOS = { link = 'Visual' },
  WarningMsg = { fg = ${theme.text_yellow} }, -- warning messages
  Whitespace = { link = 'Conceal' }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
  WildMenu = { bg = ${theme.UNUSED} }, -- current match in 'wildmenu' completion
  WinBar = { fg = ${theme.UNUSED} },
  WinBarNC = { link = 'WinBar' },
  WinSeparator = { fg = ${theme.text_variant_conceal} },

  -- }}}
  -- Syntax {{{

  Punctuation = { fg = ${theme.text_dimmer} },

  Comment = { fg = ${theme.text_variant_dimmer} },
  SpecialComment = { link = 'Special' }, -- special things inside a comment
  Constant = { fg = ${theme.text_orange} }, -- (preferred) any constant
  String = { fg = ${theme.text_green} }, -- a string constant: "this is a string"
  Character = { fg = ${theme.text_teal} }, --  a character constant: 'c', '\n'
  Number = { fg = ${theme.text_red} }, --   a number constant: 234, 0xff
  Float = { link = 'Number' }, -- a floating point constant: 2.3e10
  Boolean = { fg = ${theme.text_cyan} }, -- a boolean constant: TRUE, false
  Identifier = { fg = ${theme.text} }, -- (preferred) any variable name
  Function = { fg = ${theme.text_function} }, -- function name (also: methods for classes)
  Statement = { fg = ${theme.text}, bold = true }, -- (preferred) any statement
  Conditional = { fg = ${theme.text_indigo} }, --  if, then, else, endif, switch, etc.
  Repeat = { link = 'Conditional' }, --   for, do, while, etc.
  Label = { fg = ${theme.text_sky} }, --    case, default, etc.
  Operator = { link = 'Punctuation' }, -- "sizeof", "+", "*", etc.
  Keyword = { fg = ${theme.text_variant}, bold = true }, --  any other keyword
  Exception = { link = 'Statement' }, --  try, catch, throw

  PreProc = { fg = ${theme.text_pink} }, -- (preferred) generic Preprocessor
  Include = { fg = ${theme.text_indigo} }, --  preprocessor #include
  Define = { link = 'PreProc' }, -- preprocessor #define
  Macro = { fg = ${theme.text_indigo} }, -- same as Define
  PreCondit = { link = 'PreProc' }, -- preprocessor #if, #else, #endif, etc.

  StorageClass = { fg = ${theme.text_amber} }, -- static, register, volatile, etc.
  Structure = { fg = ${theme.text_amber} }, --  struct, union, enum, etc.
  Special = { fg = ${theme.text_pink} }, -- (preferred) any special symbol
  Type = { fg = ${theme.text_amber} }, -- (preferred) int, long, char, etc.
  Typedef = { link = 'Type' }, --  A typedef
  SpecialChar = { link = 'Special' }, -- special character in a constant
  Tag = { fg = ${theme.text_purple}, bold = true }, -- you can use CTRL-] on this
  Delimiter = { link = 'Punctuation' }, -- character that needs attention
  Debug = { link = 'Special' }, -- debugging statements

  Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
  Bold = { bold = true },
  Italic = { italic = true },
  -- ("Ignore", below, may be invisible…)
  -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

  Error = { fg = ${theme.text_error} }, -- (preferred) any erroneous construct
  Todo = { fg = ${theme.text_sky}, bold = true }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
  qfLineNr = { fg = ${theme.text_amber} },
  qfFileName = { fg = ${theme.text_blue} },
  htmlH1 = { fg = ${theme.text_pink}, bold = true },
  htmlH2 = { fg = ${theme.text_blue}, bold = true },
  mkdHeading = { fg = ${theme.text}, bold = true },
  mkdCode = { fg = ${theme.text}, bg = ${theme.surface_dark} },
  mkdCodeDelimiter = { fg = ${theme.text}, bg = ${theme.surface} },
  mkdCodeStart = { fg = ${theme.text_pink}, bold = true },
  mkdCodeEnd = { fg = ${theme.text_pink}, bold = true },
  mkdLink = { fg = ${theme.text_link}, underline = true },

  -- diff
  Added = { fg = ${theme.text_green} },
  Changed = { fg = ${theme.text_blue} },
  diffAdded = { fg = ${theme.text_green} },
  diffRemoved = { fg = ${theme.text_red} },
  diffChanged = { fg = ${theme.text_blue} },
  diffOldFile = { fg = ${theme.text_amber} },
  diffNewFile = { fg = ${theme.text_orange} },
  diffFile = { fg = ${theme.text_blue} },
  diffLine = { fg = ${theme.surface} },
  diffIndexLine = { fg = ${theme.text_teal} },
  DiffAdd = { bg = ${theme.surface_green} }, -- diff mode: Added line |diff.txt|
  DiffChange = { bg = ${theme.surface_blue} }, -- diff mode: Changed line |diff.txt|
  DiffDelete = { bg = ${theme.surface_red} }, -- diff mode: Deleted line |diff.txt|
  DiffText = { bg = ${theme.surface_violet} }, -- diff mode: Changed text within a changed line |diff.txt|

  -- NeoVim
  healthError = { fg = ${theme.text_error} },
  healthSuccess = { fg = ${theme.text_ok} },
  healthWarning = { fg = ${theme.text_warning} },

  -- rainbow
  rainbow1 = { fg = ${theme.text_red} },
  rainbow2 = { fg = ${theme.text_orange} },
  rainbow3 = { fg = ${theme.text_yellow} },
  rainbow4 = { fg = ${theme.text_green} },
  rainbow5 = { fg = ${theme.text_sky} },
  rainbow6 = { fg = ${theme.text_violet} },

  -- markdown
  markdownHeadingDelimiter = { fg = ${theme.text_orange}, bold = true },
  markdownCode = { fg = ${theme.text_rose} },
  markdownCodeBlock = { fg = ${theme.text_rose} },
  markdownLinkText = { fg = ${theme.text_link}, underline = true },
  markdownH1 = { link = 'rainbow1' },
  markdownH2 = { link = 'rainbow2' },
  markdownH3 = { link = 'rainbow3' },
  markdownH4 = { link = 'rainbow4' },
  markdownH5 = { link = 'rainbow5' },
  markdownH6 = { link = 'rainbow6' },

  -- }}}
  -- Diagnostics and LSP {{{

  LspReferenceText = { bg = ${theme.surface_menu} }, -- used for highlighting "text" references
  LspReferenceRead = { bg = ${theme.surface_menu} }, -- used for highlighting "read" references
  LspReferenceWrite = { bg = ${theme.surface_menu} }, -- used for highlighting "write" references
  LspSignatureActiveParameter = { fg = ${theme.text_indigo}, bold = true },
  LspCodeLens = { fg = ${theme.text_variant_dimmer} }, -- virtual text of the codelens
  LspCodeLensSeparator = { link = 'LspCodeLens' }, -- virtual text of the codelens separators
  -- fg of `Comment` and bg of `CursorLine`.
  LspInlayHint = { fg = ${theme.text_variant_dimmer}, bg = ${theme.surface_cursorline} }, -- virtual text of the inlay hints
  LspInfoBorder = { link = 'FloatBorder' },

  DiagnosticOk = { fg = ${theme.text_ok} },
  DiagnosticHint = { fg = ${theme.text_hint} },
  DiagnosticInfo = { fg = ${theme.text_info} },
  DiagnosticWarn = { fg = ${theme.text_warning} },
  DiagnosticError = { fg = ${theme.text_error} },
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
  DiagnosticUnderlineOk = { sp = ${theme.text_ok}, undercurl = true }, -- Used to underline diagnostics
  DiagnosticUnderlineHint = { sp = ${theme.text_hint}, undercurl = true },
  DiagnosticUnderlineInfo = { sp = ${theme.text_info}, undercurl = true },
  DiagnosticUnderlineWarn = { sp = ${theme.text_warning}, undercurl = true },
  DiagnosticUnderlineError = { sp = ${theme.text_error}, undercurl = true },
  DiagnosticVirtualTextOk = { fg = ${theme.on_surface_green}, bg = ${theme.surface_green} }, -- Used as the mantle highlight group. Other Diagnostic highlights link to this by default
  DiagnosticVirtualTextHint = { fg = ${theme.on_surface_violet}, bg = ${theme.surface_violet} },
  DiagnosticVirtualTextInfo = { fg = ${theme.on_surface_blue}, bg = ${theme.surface_blue} },
  DiagnosticVirtualTextWarn = { fg = ${theme.on_surface_amber}, bg = ${theme.surface_amber} },
  DiagnosticVirtualTextError = { fg = ${theme.on_surface_red}, bg = ${theme.surface_red} },

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
  ['@variable'] = { fg = ${theme.text} }, -- Any variable name that does not have another highlight.
  ['@variable.builtin'] = { fg = ${theme.text_purple} }, -- Variable names that are defined by the languages, like this or self.
  ['@variable.parameter'] = { fg = ${theme.text_red}, italic = true }, -- For parameters of a function.
  ['@variable.member'] = { fg = ${theme.text_pink} }, -- For fields.

  ['@constant'] = { link = 'Constant' }, -- For constants
  ['@constant.builtin'] = { fg = ${theme.text_orange} }, -- For constant that are built in the language: nil in Lua.
  ['@constant.macro'] = { link = 'Macro' }, -- For constants that are defined by macros: NULL in C.

  ['@module'] = { fg = ${theme.text_amber}, italic = true }, -- For identifiers referring to modules and namespaces.
  ['@label'] = { link = 'Label' }, -- For labels: label: in C and :label: in Lua.

  -- Literals
  ['@string'] = { link = 'String' }, -- For strings.
  ['@string.documentation'] = { fg = ${theme.text_teal} }, -- For strings documenting code (e.g. Python docstrings).
  ['@string.regexp'] = { fg = ${theme.text_pink} }, -- For regexes.
  ['@string.escape'] = { fg = ${theme.text_pink} }, -- For escape characters within a string.
  ['@string.special'] = { link = 'Special' }, -- other special strings (e.g. dates)
  ['@string.special.path'] = { link = 'Special' }, -- filenames
  ['@string.special.symbol'] = { fg = ${theme.text_pink} }, -- symbols or atoms
  ['@string.special.url'] = { fg = ${theme.text_link}, italic = true, underline = true }, -- urls, links and emails
  ['@punctuation.delimiter.regex'] = { link = '@string.regexp' },

  ['@character'] = { link = 'Character' }, -- character literals
  ['@character.special'] = { link = 'SpecialChar' }, -- special characters (e.g. wildcards)

  ['@boolean'] = { link = 'Boolean' }, -- For booleans.
  ['@number'] = { link = 'Number' }, -- For all numbers
  ['@number.float'] = { link = 'Float' }, -- For floats.

  -- Types
  ['@type'] = { link = 'Type' }, -- For types.
  ['@type.builtin'] = { fg = ${theme.text_purple}, italic = true }, -- For builtin types.
  ['@type.definition'] = { link = 'Type' }, -- type definitions (e.g. `typedef` in C)

  ['@attribute'] = { link = 'Constant' }, -- attribute annotations (e.g. Python decorators)
  ['@property'] = { fg = ${theme.text_function} }, -- For fields, like accessing `bar` property on `foo.bar`. Overriden later for data languages and CSS.

  -- Functions
  ['@function'] = { link = 'Function' }, -- For function (calls and definitions).
  ['@function.builtin'] = { fg = ${theme.text_orange} }, -- For builtin functions: table.insert in Lua.
  ['@function.call'] = { link = 'Function' }, -- function calls
  ['@function.macro'] = { link = 'Macro' }, -- For macro defined functions (calls and definitions): each macro_rules in Rust.

  ['@function.method'] = { link = 'Function' }, -- For method definitions.
  ['@function.method.call'] = { link = 'Function' }, -- For method calls.

  ['@constructor'] = { fg = ${theme.text_amber} }, -- For constructor calls and definitions: = { } in Lua, and Java constructors.
  ['@operator'] = { link = 'Operator' }, -- For any operator: +, but also -> and * in C.

  -- Keywords
  ['@keyword'] = { link = 'Keyword' }, -- For keywords that don't fall in previous categories.
  ['@keyword.modifier'] = { link = 'Keyword' }, -- For keywords modifying other constructs (e.g. `const`, `static`, `public`)
  ['@keyword.type'] = { link = 'Keyword' }, -- For keywords describing composite types (e.g. `struct`, `enum`)
  ['@keyword.coroutine'] = { link = 'Keyword' }, -- For keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
  ['@keyword.function'] = { fg = ${theme.text_indigo} }, -- For keywords used to define a function.
  ['@keyword.operator'] = { fg = ${theme.text_indigo} }, -- For new keyword operator
  ['@keyword.import'] = { link = 'Include' }, -- For includes: #include in C, use or extern crate in Rust, or require in Lua.
  ['@keyword.repeat'] = { link = 'Repeat' }, -- For keywords related to loops.
  ['@keyword.return'] = { fg = ${theme.text_indigo} },
  ['@keyword.debug'] = { link = 'Exception' }, -- For keywords related to debugging
  ['@keyword.exception'] = { link = 'Exception' }, -- For exception related keywords.

  ['@keyword.conditional'] = { link = 'Conditional' }, -- For keywords related to conditionnals.
  ['@keyword.conditional.ternary'] = { link = 'Operator' }, -- For ternary operators (e.g. `?` / `:`)

  ['@keyword.directive'] = { link = 'PreProc' }, -- various preprocessor directives & shebangs
  ['@keyword.directive.define'] = { link = 'Define' }, -- preprocessor definition directives
  ['@keyword.export'] = { fg = ${theme.text_indigo} }, -- JS & derivative

  -- Punctuation
  ['@punctuation.delimiter'] = { link = 'Delimiter' }, -- For delimiters (e.g. `;` / `.` / `,`).
  ['@punctuation.bracket'] = { link = 'Punctuation' }, -- For brackets and parenthesis.
  ['@punctuation.special'] = { link = 'Special' }, -- For special punctuation that does not fall in the categories before (e.g. `{}` in string interpolation).

  -- Comment
  ['@comment'] = { link = 'Comment' },
  ['@comment.documentation'] = { link = 'Comment' }, -- For comments documenting code

  ['@comment.error'] = { fg = ${theme.text_error}, bold = true },
  ['@comment.warning'] = { fg = ${theme.text_warning}, bold = true },
  ['@comment.hint'] = { fg = ${theme.text_hint}, bold = true },
  ['@comment.todo'] = { fg = ${theme.text_info}, bold = true },
  ['@comment.note'] = { link = 'Title' },

  -- Markup
  ['@markup'] = { fg = ${theme.text} }, -- For strings considerated text in a markup language.
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

  ['@markup.link'] = { fg = ${theme.text_link}, underline = true }, -- text references, footnotes, citations, etc.
  ['@markup.link.label'] = { link = '@markup.link' }, -- link, reference descriptions
  ['@markup.link.url'] = { link = '@markup.link' }, -- urls, links and emails

  ['@markup.raw'] = { fg = ${theme.text_green} }, -- used for inline code in markdown and for doc in python (""")

  ['@markup.list'] = { fg = ${theme.text_teal} },
  ['@markup.list.checked'] = { fg = ${theme.text_green} }, -- todo notes
  ['@markup.list.unchecked'] = { fg = ${theme.text_dim} }, -- todo notes

  -- Diff
  ['@diff.plus'] = { link = 'diffAdded' }, -- added text (for diff files)
  ['@diff.minus'] = { link = 'diffRemoved' }, -- deleted text (for diff files)
  ['@diff.delta'] = { link = 'diffChanged' }, -- deleted text (for diff files)

  -- Tags
  ['@tag'] = { fg = ${theme.text_blue} }, -- Tags like HTML tag names.
  ['@tag.builtin'] = { fg = ${theme.text_blue} }, -- JSX tag names.
  ['@tag.attribute'] = { fg = ${theme.text_amber}, italic = true }, -- XML/HTML attributes (foo in foo="bar").
  ['@tag.delimiter'] = { fg = ${theme.text_teal} }, -- Tag delimiter like < > /

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

  ['@string.special.url.html'] = { fg = ${theme.text_green} }, -- Links in href, src attributes.
  ['@markup.link.label.html'] = { fg = ${theme.text} }, -- Text between <a></a> tags.
  ['@character.special.html'] = { fg = ${theme.text_red} }, -- Symbols such as &nbsp;.

  -- CSS
  ['@property.css'] = { fg = ${theme.text_blue} },
  ['@property.scss'] = { fg = ${theme.text_blue} },
  ['@property.id.css'] = { fg = ${theme.text_amber} },
  ['@property.class.css'] = { fg = ${theme.text_amber} },
  ['@type.css'] = { fg = ${theme.text_indigo} },
  ['@type.tag.css'] = { fg = ${theme.text_blue} },
  ['@string.plain.css'] = { fg = ${theme.text} },
  ['@keyword.directive.css'] = { link = 'Keyword' }, -- CSS at-rules: https://developer.mozilla.org/en-US/docs/Web/CSS/At-rule.

  -- Lua
  ['@constructor.lua'] = { link = '@punctuation.bracket' }, -- For constructor calls and definitions: = { } in Lua.

  -- Python
  ['@constructor.python'] = { fg = ${theme.text_sky} }, -- __init__(), __new__().

  -- C/CPP
  ['@keyword.import.c'] = { link = 'Include' },
  ['@keyword.import.cpp'] = { link = 'Include' },

  -- gitcommit
  ['@comment.warning.gitcommit'] = { fg = ${theme.text_warning} },

  -- gitignore
  ['@string.special.path.gitignore'] = { fg = ${theme.text} },

  -- }}}
  -- }}}
  -- StatusLine {{{

  StatusLineFocusedPrimary = { fg = ${theme.text}, bold = true },
  StatusLineFocusedSecondary = { fg = ${theme.text_dim} },

  StatusLineUnfocusedPrimary = { fg = ${theme.text_dim}, bold = true },
  StatusLineUnfocusedSecondary = { fg = ${theme.text_dim} },

  -- }}}
  -- Cmp {{{

  CmpItemAbbr = { fg = ${theme.text_dim} },
  CmpItemAbbrDeprecated = { fg = ${theme.text_dim}, strikethrough = true },
  CmpItemKind = { fg = ${theme.text_blue} },
  CmpItemMenu = { fg = ${theme.text} },
  CmpItemAbbrMatch = { fg = ${theme.text}, bold = true },
  CmpItemAbbrMatchFuzzy = { fg = ${theme.text}, bold = true },

  -- kind support
  CmpItemKindSnippet = { fg = ${theme.text_violet} },
  CmpItemKindKeyword = { fg = ${theme.text_red} },
  CmpItemKindText = { fg = ${theme.text_teal} },
  CmpItemKindMethod = { link = 'Function' },
  CmpItemKindConstructor = { link = 'Function' },
  CmpItemKindFunction = { link = 'Function' },
  CmpItemKindFolder = { link = 'Directory' },
  CmpItemKindModule = { fg = ${theme.text_blue} },
  CmpItemKindConstant = { link = 'Constant' },
  CmpItemKindField = { fg = ${theme.text_green} },
  CmpItemKindProperty = { fg = ${theme.text_green} },
  CmpItemKindEnum = { fg = ${theme.text_green} },
  CmpItemKindUnit = { fg = ${theme.text_green} },
  CmpItemKindClass = { fg = ${theme.text_amber} },
  CmpItemKindVariable = { fg = ${theme.text_pink} },
  CmpItemKindFile = { fg = ${theme.text_blue} },
  CmpItemKindInterface = { fg = ${theme.text_amber} },
  CmpItemKindColor = { fg = ${theme.text_red} },
  CmpItemKindReference = { fg = ${theme.text_red} },
  CmpItemKindEnumMember = { fg = ${theme.text_red} },
  CmpItemKindStruct = { fg = ${theme.text_blue} },
  CmpItemKindValue = { fg = ${theme.text_orange} },
  CmpItemKindEvent = { fg = ${theme.text_blue} },
  CmpItemKindOperator = { fg = ${theme.text_blue} },
  CmpItemKindTypeParameter = { fg = ${theme.text_blue} },
  CmpItemKindCopilot = { fg = ${theme.text_teal} },

  -- }}}
  -- Noice {{{

  NoiceCmdLine = { link = 'Normal' },
  NoiceCmdlinePopupBorder = { link = 'FloatBorder' },
  NoiceCmdLineIcon = { link = 'Normal' },
  NoiceCmdlineIconCmdline = { fg = ${theme.text_emerald} },
  NoiceCmdlineIconLua = { fg = ${theme.text_violet} },
  NoiceConfirmBorder = { fg = ${theme.text_red} },

  -- }}}
  -- render markdown {{{

  RenderMarkdownH1 = { link = 'markdownH1' },
  RenderMarkdownH2 = { link = 'markdownH2' },
  RenderMarkdownH3 = { link = 'markdownH3' },
  RenderMarkdownH4 = { link = 'markdownH4' },
  RenderMarkdownH5 = { link = 'markdownH5' },
  RenderMarkdownH6 = { link = 'markdownH6' },
  RenderMarkdownCode = { bg = ${theme.surface_dark} },
  RenderMarkdownCodeInline = { bg = ${theme.text} },
  RenderMarkdownBullet = { fg = ${theme.text_sky} },
  RenderMarkdownTableHead = { fg = ${theme.text_blue} },
  RenderMarkdownTableRow = { fg = ${theme.text_indigo} },
  RenderMarkdownSuccess = { fg = ${theme.text_ok} },
  RenderMarkdownInfo = { fg = ${theme.text_info} },
  RenderMarkdownHint = { fg = ${theme.text_hint} },
  RenderMarkdownWarn = { fg = ${theme.text_warning} },
  RenderMarkdownError = { fg = ${theme.text_error} },

  -- }}}
  -- Snacks {{{

  SnacksNormal = { link = 'Normal' },
  SnacksWinBar = { link = 'Title' },
  SnacksBackdrop = { link = 'FloatShadow' },
  SnacksNormalNC = { link = 'NormalFloat' },
  SnacksWinBarNC = { link = 'SnacksWinBar' },

  SnacksNotifierInfo = { link = 'DiagnosticInfo' },
  SnacksNotifierIconInfo = { link = 'DiagnosticInfo' },
  SnacksNotifierTitleInfo = { fg = ${theme.text_info}, italic = true },
  SnacksNotifierBorderInfo = { link = 'DiagnosticInfo' },
  SnacksNotifierFooterInfo = { link = 'DiagnosticInfo' },
  SnacksNotifierWarn = { link = 'DiagnosticWarn' },
  SnacksNotifierIconWarn = { link = 'DiagnosticWarn' },
  SnacksNotifierTitleWarn = { fg = ${theme.text_warning}, italic = true },
  SnacksNotifierBorderWarn = { link = 'DiagnosticWarn' },
  SnacksNotifierFooterWarn = { link = 'DiagnosticWarn' },
  SnacksNotifierDebug = { link = 'DiagnosticHint' },
  SnacksNotifierIconDebug = { link = 'DiagnosticHint' },
  SnacksNotifierTitleDebug = { fg = ${theme.text_hint}, italic = true },
  SnacksNotifierBorderDebug = { link = 'DiagnosticHint' },
  SnacksNotifierFooterDebug = { link = 'DiagnosticHint' },
  SnacksNotifierError = { link = 'DiagnosticError' },
  SnacksNotifierIconError = { link = 'DiagnosticError' },
  SnacksNotifierTitleError = { fg = ${theme.text_error}, italic = true },
  SnacksNotifierBorderError = { link = 'DiagnosticError' },
  SnacksNotifierFooterError = { link = 'DiagnosticError' },
  SnacksNotifierTrace = { fg = ${theme.text_fuchsia} },
  SnacksNotifierIconTrace = { fg = ${theme.text_fuchsia} },
  SnacksNotifierTitleTrace = { fg = ${theme.text_fuchsia}, italic = true },
  SnacksNotifierBorderTrace = { fg = ${theme.text_fuchsia} },
  SnacksNotifierFooterTrace = { fg = ${theme.text_fuchsia} },

  SnacksDashboardNormal = { link = 'Normal' },
  SnacksDashboardDesc = { fg = ${theme.text_blue} },
  SnacksDashboardFile = { fg = ${theme.text_indigo} },
  SnacksDashboardDir = { link = 'NonText' },
  SnacksDashboardFooter = { fg = ${theme.text_amber}, italic = true },
  SnacksDashboardHeader = { fg = ${theme.text_blue} },
  SnacksDashboardIcon = { fg = ${theme.text_pink}, bold = true },
  SnacksDashboardKey = { fg = ${theme.text_orange} },
  SnacksDashboardTerminal = { link = 'SnacksDashboardNormal' },
  SnacksDashboardSpecial = { link = 'Special' },
  SnacksDashboardTitle = { link = 'Title' },

  SnacksIndent = { fg = ${theme.surface} },
  SnacksIndentScope = { fg = ${theme.text} },

  SnacksPickerSelected = { fg = ${theme.text_pink}, bg = ${theme.surface}, bold = true },
  SnacksPickerMatch = { fg = ${theme.text_blue} },

  SnacksPicker = { link = 'NormalFloat' },
  SnacksPickerBorder = { link = 'FloatBorder' },
  SnacksPickerDir = { link = 'SnacksPickerDimmed' },
  SnacksPickerDimmed = { fg = ${theme.text_dimmer} },
  SnacksPickerInputBorder = { link = 'SnacksPickerBorder' },
  SnacksPickerInput = { link = 'NormalFloat' },
  SnacksPickerPrompt = { fg = ${theme.text_pink} },
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
  CompileModeCommandOutput = { fg = ${theme.text_blue} },
  CompileModeOutputFile = { link = 'Normal' },
  CompileModeCheckResult = { bold = true },
  CompileModeCheckTarget = { link = 'Normal' },
  CompileModeDirectoryMessage = { link = 'Normal' },
  CompileModeErrorLocus = { link = 'Normal' },

  -- }}}
}
''
