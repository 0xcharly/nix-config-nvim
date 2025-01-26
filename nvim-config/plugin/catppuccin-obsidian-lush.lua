-- vi:nowrap

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require('lush')
local hsl = lush.hsl

local MrSuit = {
  rosewater = hsl('#f5e0dc'),
  flamingo = hsl('#f2cdcd'),
  pink = hsl('#f5c2e7'),
  mauve = hsl('#d0aff8'),
  red = hsl('#fe9aa4'),
  maroon = hsl('#eba0ac'),
  peach = hsl('#fab387').desaturate(15),
  yellow = hsl('#f9e2af').desaturate(50),
  green = hsl('#a6e3a1').desaturate(25),
  teal = hsl('#91d7d1'),
  sky = hsl('#89dceb').desaturate(15),
  sapphire = hsl('#74c7ec'),
  blue = hsl('#89b4fa'),
  lavender = hsl('#b4befe'),
  text = hsl('#dde6f4').desaturate(10).lighten(10),
  subtext1 = hsl('#bac2de'),
  subtext0 = hsl('#8fa3bb'),
  overlay2 = hsl('#7a8490'),
  overlay1 = hsl('#45475a'),
  overlay0 = hsl('#23282f'),
  surface2 = hsl('#1d2530'),
  surface1 = hsl('#192029'),
  surface0 = hsl('#1d1f21'),
  base = hsl('#151b23'),
  mantle = hsl('#151b23').darken(15),
  crust = hsl('#0b1215'), -- Obsidian

  title = hsl('#d9e2e4'),
  cursorline = hsl('#303747'),

  surface_red = hsl('#41262e'),
  on_surface_red = hsl('#fe9fa9'),

  surface_orange = hsl('#433027'),
  on_surface_orange = hsl('#fec49a'),

  surface_yellow = hsl('#343637'),
  on_surface_yellow = hsl('#f9e1ae'),

  surface_green = hsl('#243c2e'),
  on_surface_green = hsl('#aff3c0'),

  surface_cyan = hsl('#233a48'),
  on_surface_cyan = hsl('#89dceb'),

  surface_blue = hsl('#203147'),
  on_surface_blue = hsl('#9fcdfe'),

  surface_purple = hsl('#312b41'),
  on_surface_purple = hsl('#cab4f4'),
}

-- Terminal colors.
-- TODO: move this somewhere more appropriate (this is probably going to be
-- dropped during :Shipwright compilation).
local Term = {
  MrSuit.subtext1, -- Black
  MrSuit.red,
  MrSuit.green,
  MrSuit.yellow,
  MrSuit.blue,
  MrSuit.mauve,
  MrSuit.teal,
  MrSuit.text,

  MrSuit.overlay2, -- Bright black
  MrSuit.on_surface_red,
  MrSuit.on_surface_green,
  MrSuit.peach,
  MrSuit.sapphire,
  MrSuit.lavender,
  MrSuit.on_surface_cyan,
  MrSuit.subtext0,
}

for k, v in pairs(Term) do
  vim.g[string.format('terminal_color_%i', k - 1)] = v.hex
end

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
    -- groups, mostly used for styling UI elements.
    -- Comment them out and add your own properties to override the defaults.
    -- An empty definition `{}` will clear all styling, leaving elements looking
    -- like the 'Normal' group.
    -- To be able to link to a group, it must already be defined, so you may have
    -- to reorder items as you go.
    --
    -- See :h highlight-groups
    --
    Conceal { fg = MrSuit.overlay2 }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor { fg = MrSuit.subtext0 }, -- Character under the cursor
    FloatBorder { fg = MrSuit.overlay1 },
    NonText { Conceal }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal { fg = MrSuit.text, bg = MrSuit.base }, -- Normal text
    NormalFloat { Normal, bg = MrSuit.overlay0 }, -- Normal text in floating windows.
    NormalNC { Normal }, -- normal text in non-current windows
    NormalSB { Normal }, -- normal text in non-current windows
    WinBar { bg = MrSuit.base },
    WinBarNC { bg = MrSuit.base },
    lCursor { Cursor }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM { Cursor }, -- Like Cursor, but used when in IME mode |CursorIM|
    CursorLine { bg = MrSuit.cursorline }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorColumn { CursorLine }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    ColorColumn { CursorLine }, -- Columns set with 'colorcolumn'
    File { fg = MrSuit.text }, -- Directory names (and other special names in listings)
    Directory { fg = MrSuit.sapphire }, -- Directory names (and other special names in listings)
    DiffAdd { fg = MrSuit.on_surface_green, bg = MrSuit.surface_green }, -- Diff mode: Added line |diff.txt|
    DiffChange { fg = MrSuit.on_surface_purple, bg = MrSuit.surface_purple }, -- Diff mode: Changed line |diff.txt|
    DiffDelete { fg = MrSuit.on_surface_red, bg = MrSuit.surface_red }, -- Diff mode: Deleted line |diff.txt|
    DiffText { fg = MrSuit.subtext0 }, -- Diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer { NonText }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    -- TermCursor   { }, -- Cursor in a focused terminal
    -- TermCursorNC { }, -- Cursor in an unfocused terminal
    VertSplit { FloatBorder }, -- Column separating vertically split windows
    Folded { fg = MrSuit.overlay2, gui = 'italic' }, -- Line used for closed folds
    FoldColumn { bg = MrSuit.base }, -- 'foldcolumn'
    SignColumn { bg = MrSuit.base }, -- Column where |signs| are displayed
    SignColumnSB { SignColumn }, -- Column where |signs| are displayed
    Search { fg = MrSuit.on_surface_yellow, bg = MrSuit.surface_yellow, gui = 'bold' }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    IncSearch { Search }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Substitute { fg = MrSuit.on_surface_cyan, bg = MrSuit.surface_cyan, gui = 'bold' }, -- |:substitute| replacement text highlighting
    LineNr { Conceal }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr { fg = MrSuit.subtext1 }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen { fg = MrSuit.title }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg { fg = MrSuit.text, gui = 'bold' }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea { fg = MrSuit.text }, -- Area for messages and cmdline
    -- MsgSeparat or { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg { fg = MrSuit.on_surface_cyan, bg = MrSuit.surface_cyan }, -- |more-prompt|
    Pmenu { fg = MrSuit.text, bg = MrSuit.overlay0 }, -- Popup menu: Normal item.
    PmenuSel { fg = MrSuit.on_surface_blue, bg = MrSuit.surface_blue }, -- Popup menu: Selected item.
    PmenuSbar { bg = MrSuit.overlay0 }, -- Popup menu: Scrollbar.
    PmenuThumb { bg = MrSuit.overlay2 }, -- Popup menu: Thumb of the scrollbar.
    Question { fg = MrSuit.green }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine { bg = MrSuit.surface1, gui = 'bold' }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    SpecialKey { fg = MrSuit.subtext0 }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    StatusLine { fg = MrSuit.text, bg = MrSuit.mantle }, -- Status line of current window
    StatusLineNC { StatusLine, fg = MrSuit.subtext0 }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine { Normal, fg = MrSuit.subtext1 }, -- Tab pages line, not active tab page label
    TabLineFill { Normal }, -- Tab pages line, where there are no labels
    TabLineSel { PmenuSel }, -- Tab pages line, active tab page label
    Title { fg = MrSuit.title, gui = 'bold' }, -- Titles for output from ":set all", ":autocmd" etc.
    Visual { CursorLine }, -- Visual mode selection
    VisualNOS { Visual }, -- Visual mode selection when vim is "Not Owning the Selection".
    Whitespace { NonText }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    Winseparator { VertSplit }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    WildMenu { bg = MrSuit.overlay0 }, -- Current match in 'wildmenu' completion

    Todo { fg = MrSuit.on_surface_blue, bg = MrSuit.surface_blue, gui = 'italic' }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX
    Success { fg = MrSuit.green },
    Warning { fg = MrSuit.yellow },
    Error { fg = MrSuit.red },

    -- Healthcheck.
    healthSuccess { Success },
    healthWarning { Warning },
    healthError { Error },

    WarningMsg { Warning }, -- Warning messages
    ErrorMsg { Error }, -- Error messages

    -- Terminal colors.
    TerminalColor0 { fg = Term[1] },
    TerminalColor1 { fg = Term[2] },
    TerminalColor2 { fg = Term[3] },
    TerminalColor3 { fg = Term[4] },
    TerminalColor4 { fg = Term[5] },
    TerminalColor5 { fg = Term[6] },
    TerminalColor6 { fg = Term[7] },
    TerminalColor7 { fg = Term[8] },
    TerminalColor8 { fg = Term[9] },
    TerminalColor9 { fg = Term[10] },
    TerminalColor10 { fg = Term[11] },
    TerminalColor11 { fg = Term[12] },
    TerminalColor12 { fg = Term[13] },
    TerminalColor13 { fg = Term[14] },
    TerminalColor14 { fg = Term[15] },
    TerminalColor15 { fg = Term[16] },

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    FuzzyMatch { fg = MrSuit.yellow },
    Punctuation { fg = MrSuit.subtext0 },
    Comment { fg = MrSuit.overlay2 }, -- Any comment

    Constant { fg = MrSuit.peach }, -- (*) Any constant
    String { fg = MrSuit.green }, --   A string constant: "this is a string"
    Character { fg = MrSuit.peach }, --   A character constant: 'c', '\n'
    Number { fg = MrSuit.sapphire }, --   A number constant: 234, 0xff
    Boolean { fg = MrSuit.pink }, --   A boolean constant: TRUE, false
    Float { fg = MrSuit.pink }, --   A floating point constant: 2.3e10
    URI { fg = MrSuit.teal, gui = 'underline' },
    Identifier { fg = MrSuit.lavender }, -- (*) Any variable name
    Function { fg = MrSuit.blue }, --   Function name (also: methods for classes)

    Statement { fg = MrSuit.lavender }, -- (*) Any statement
    Conditional { Statement }, --   if, then, else, endif, switch, etc.
    Repeat { Statement }, --   for, do, while, etc.
    Label { Statement }, --   case, default, etc.
    Operator { Punctuation }, --   "sizeof", "+", "*", etc.
    Keyword { fg = MrSuit.subtext1, gui = 'bold' }, --   any other keyword
    Exception { Statement }, --   try, catch, throw

    PreProc { fg = MrSuit.flamingo }, -- (*) Generic Preprocessor
    Include { fg = MrSuit.teal }, --   Preprocessor #include
    Define { Include }, --   Preprocessor #define
    Macro { Include }, --   Same as Define
    PreCondit { PreProc }, --   Preprocessor #if, #else, #endif, etc.

    Type { fg = MrSuit.yellow }, -- (*) int, long, char, etc.
    StorageClass { fg = MrSuit.lavender }, --   static, register, volatile, etc.
    Structure { Type }, --   struct, union, enum, etc.
    Typedef { Type }, --   A typedef

    Special { fg = MrSuit.pink }, -- (*) Any special symbol
    SpecialChar { Special }, --   Special character in a constant
    Tag { Special }, --   You can use CTRL-] on this
    Delimiter { Punctuation }, --   Character that needs attention
    SpecialComment { fg = MrSuit.pink }, --   Special things inside a comment (e.g. '\n')
    Debug { fg = MrSuit.on_surface_orange, bg = MrSuit.surface_orange }, --   Debugging statements

    Underlined { gui = 'underline' }, -- Text that stands out, HTML links
    Bold { gui = 'bold' },
    Italic { gui = 'italic' },
    -- ("Ignore", below, may be invisible...)
    -- Ignore         { }, -- Left blank, hidden |hl-Ignore|.

    -- diff
    diffAdded { DiffAdd },
    diffChanged { DiffChange },
    diffRemoved { DiffDelete },
    diffOldFile { fg = MrSuit.subtext0 },
    diffNewFile { fg = MrSuit.blue },
    diffFile { fg = MrSuit.lavender },
    diffLine { DiffText },
    diffIndexLine { fg = MrSuit.lavender },

    -- GitSigns
    GitSignsAdd { fg = MrSuit.green }, -- diff mode: Added line |diff.txt|
    GitSignsChange { fg = MrSuit.lavender }, -- diff mode: Changed line |diff.txt|
    GitSignsDelete { fg = MrSuit.red }, -- diff mode: Deleted line |diff.txt|

    -- GitGutter
    GitGutterAdd { GitSignsAdd }, -- diff mode: Added line |diff.txt|
    GitGutterChange { GitSignsChange }, -- diff mode: Changed line |diff.txt|
    GitGutterDelete { GitSignsDelete }, -- diff mode: Deleted line |diff.txt|

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    LspReferenceText { fg = MrSuit.on_surface_blue, bg = MrSuit.surface_blue }, -- Used for highlighting "text" references
    LspReferenceRead { LspReferenceText }, -- Used for highlighting "read" references
    LspReferenceWrite { LspReferenceText }, -- Used for highlighting "write" references
    LspCodeLens { fg = MrSuit.overlay2, gui = 'italic' }, -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { }, -- Used to color the seperator between two or more code lens.
    LspInlayHint { LspCodeLens }, -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspSignatureActiveParameter { }, -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.
    LspParameter { fg = MrSuit.flamingo, gui = 'italic' }, -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    DiagnosticError { Error }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarn { Warning }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInfo { fg = MrSuit.teal }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint { fg = MrSuit.subtext1 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticVirtualTextError { fg = MrSuit.on_surface_red, bg = MrSuit.surface_red }, -- Used for "Error" diagnostic virtual text.
    DiagnosticVirtualTextWarn { fg = MrSuit.on_surface_yellow, bg = MrSuit.surface_yellow }, -- Used for "Warn" diagnostic virtual text.
    DiagnosticVirtualTextInfo { fg = MrSuit.on_surface_cyan, bg = MrSuit.surface_cyan }, -- Used for "Info" diagnostic virtual text.
    DiagnosticVirtualTextHint { fg = MrSuit.subtext1, bg = MrSuit.surface1 }, -- Used for "Hint" diagnostic virtual text.
    DiagnosticUnderlineError { gui = 'underdotted', sp = DiagnosticError.fg }, -- Used to underline "Error" diagnostics.
    DiagnosticUnderlineWarn { gui = 'underdotted', sp = DiagnosticWarn.fg }, -- Used to underline "Warn" diagnostics.
    DiagnosticUnderlineInfo { gui = 'underdotted', sp = DiagnosticInfo.fg }, -- Used to underline "Info" diagnostics.
    DiagnosticUnderlineHint { gui = 'underdotted', sp = DiagnosticHint.fg }, -- Used to underline "Hint" diagnostics.
    DiagnosticFloatingError { DiagnosticError }, -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    DiagnosticFloatingWarn { DiagnosticWarn }, -- Used to color "Warn" diagnostic messages in diagnostics float.
    DiagnosticFloatingInfo { DiagnosticInfo }, -- Used to color "Info" diagnostic messages in diagnostics float.
    DiagnosticFloatingHint { DiagnosticHint }, -- Used to color "Hint" diagnostic messages in diagnostics float.
    DiagnosticSignError { DiagnosticError }, -- Used for "Error" signs in sign column.
    DiagnosticSignWarn { DiagnosticWarn }, -- Used for "Warn" signs in sign column.
    DiagnosticSignInfo { DiagnosticInfo }, -- Used for "Info" signs in sign column.
    DiagnosticSignHint { DiagnosticHint }, -- Used for "Hint" signs in sign column.

    LspDiagnosticsDefaultError { DiagnosticError }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline).
    LspDiagnosticsDefaultWarning { DiagnosticWarn }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline).
    LspDiagnosticsDefaultInformation { DiagnosticInfo }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline).
    LspDiagnosticsDefaultHint { DiagnosticHint }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline).
    LspDiagnosticsVirtualTextError { DiagnosticVirtualTextError }, -- Used for "Error" diagnostic virtual text.
    LspDiagnosticsVirtualTextWarning { DiagnosticVirtualTextWarn }, -- Used for "Warn" diagnostic virtual text.
    LspDiagnosticsVirtualTextInformation { DiagnosticVirtualTextInfo }, -- Used for "Info" diagnostic virtual text.
    LspDiagnosticsVirtualTextHint { DiagnosticVirtualTextHint }, -- Used for "Hint" diagnostic virtual text.
    LspDiagnosticsUnderlineError { DiagnosticUnderlineError }, -- Used to underline "Error" diagnostics.
    LspDiagnosticsUnderlineWarning { DiagnosticUnderlineWarn }, -- Used to underline "Warn" diagnostics.
    LspDiagnosticsUnderlineInformation { DiagnosticUnderlineInfo }, -- Used to underline "Info" diagnostics.
    LspDiagnosticsUnderlineHint { DiagnosticUnderlineHint }, -- Used to underline "Hint" diagnostics.
    LspDiagnosticsFloatingError { DiagnosticFloatingError }, -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    LspDiagnosticsFloatingWarning { DiagnosticFloatingWarn }, -- Used to color "Warn" diagnostic messages in diagnostics float.
    LspDiagnosticsFloatingInfo { DiagnosticFloatingInfo }, -- Used to color "Info" diagnostic messages in diagnostics float.
    LspDiagnosticsFloatingHint { DiagnosticFloatingHint }, -- Used to color "Hint" diagnostic messages in diagnostics float.
    LspDiagnosticsSignError { DiagnosticSignError }, -- Used for "Error" signs in sign column.
    LspDiagnosticsSignWarning { DiagnosticSignWarn }, -- Used for "Warn" signs in sign column.
    LspDiagnosticsSignInformation { DiagnosticSignInfo }, -- Used for "Info" signs in sign column.
    LspDiagnosticsSignHint { DiagnosticSignHint }, -- Used for "Hint" signs in sign column.

    -- Spell-checker.
    SpellBad { DiagnosticUnderlineError, gui = 'undercurl' }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap { DiagnosticUnderlineWarn, gui = 'undercurl' }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal { DiagnosticUnderlineInfo, gui = 'undercurl' }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare { DiagnosticUnderlineHint, gui = 'undercurl' }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.

    -- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups.

    sym('@text') {}, -- Comment
    sym('@text.strong') { Bold },
    sym('@text.emphasis') { Italic },
    sym('@text.underline') { gui = 'underline' },
    sym('@text.strike') { gui = 'strikethrough' },
    sym('@text.literal') {}, -- literal or verbatim text (e.g., inline code)
    sym('@text.quote') { fg = MrSuit.subtext0, gui = 'italic' }, -- Comment
    sym('@text.reference') { Identifier }, -- Identifier
    sym('@text.title') { Title }, -- Title
    sym('@text.uri') { URI },
    sym('@text.math') { sym('@text.literal') },
    sym('@text.environment') {}, -- text environments of markup languages
    sym('@text.environment.name') {}, -- text indicating the type of an environment
    sym('@text.reference') {}, -- text references, footnotes, citations, etc.
    sym('@text.todo') { Todo }, -- Todo
    sym('@text.note') { gui = 'underline' },
    sym('@text.warning') { Warning },
    sym('@text.danger') { Error },
    sym('@text.diff.add') { GitSignsAdd },
    sym('@text.diff.delete') { GitSignsDelete },
    sym('@comment') { Comment }, -- Comment
    sym('@error') { Error },
    sym('@none') {},
    sym('@punctuation') { Delimiter }, -- Delimiter
    sym('@constant') { Constant }, -- Constant
    sym('@constant.builtin') { Special }, -- Special
    sym('@constant.macro') { Define }, -- Define
    sym('@define') { Define }, -- Define
    sym('@macro') { Macro }, -- Macro
    sym('@string') { String }, -- String
    sym('@string.regex') { String }, -- String
    sym('@string.escape') { SpecialChar }, -- SpecialChar
    sym('@string.special') { SpecialChar }, -- SpecialChar
    sym('@character') { Character }, -- Character
    sym('@character.special') { SpecialChar }, -- SpecialChar
    sym('@number') { Number }, -- Number
    sym('@boolean') { Boolean }, -- Boolean
    sym('@float') { Float }, -- Float
    sym('@function') { Function }, -- Function
    sym('@function.builtin') { fg = MrSuit.peach }, -- Special
    sym('@function.call') { Function }, -- Macro
    sym('@function.macro') { Macro }, -- Macro
    sym('@parameter') { Identifier }, -- Identifier
    sym('@method') { Function }, -- Function
    sym('@method.call') { Function }, -- Function
    sym('@field') { Identifier }, -- Identifier
    sym('@property') { Identifier }, -- Identifier
    sym('@constructor') {}, -- Special
    sym('@conditional') { Conditional }, -- Conditional
    sym('@conditional.ternary') { Operator }, -- Conditional
    sym('@repeat') { Repeat }, -- Repeat
    sym('@label') {}, -- Label
    sym('@operator') { Operator }, -- Operator
    sym('@keyword') { Keyword }, -- various keywords
    sym('@keyword.directive') { PreProc },
    sym('@keyword.function') { sym('@keyword') }, -- keywords that define a function (e.g. `func` in Go, `def` in Python)
    sym('@keyword.operator') { sym('@keyword') }, -- operators that are English words (e.g. `and` / `or`)
    sym('@keyword.return') { sym('@keyword') }, -- keywords like `return` and `yield`
    sym('@exception') { Exception }, -- Exception
    sym('@variable') {}, -- Identifier
    sym('@variable.builtin') { fg = MrSuit.red }, -- Identifier
    sym('@variable.parameter') { fg = MrSuit.maroon }, -- Identifier
    sym('@type') { Type }, -- Type
    sym('@type.builtin') { Type },
    sym('@type.definition') { Typedef }, -- Typedef
    sym('@type.qualifier') { fg = MrSuit.red },
    sym('@storageclass') { StorageClass }, -- StorageClass
    sym('@structure') { Structure }, -- Structure
    sym('@namespace') { fg = MrSuit.red }, -- Identifier
    sym('@symbol') {}, -- symbols or atoms
    sym('@include') { Keyword }, -- Include
    sym('@attribute') { PreProc },
    sym('@preproc') { PreProc }, -- PreProc
    sym('@debug') { Debug }, -- Debug
    sym('@tag') { Tag }, -- XML tag names
    sym('@tag.attribute') { Identifier }, -- XML tag attributes
    sym('@tag.delimiter') { Punctuation }, -- XML tag delimiters
    sym('@punctuation.delimiter') { Punctuation }, -- delimiters (e.g. `;` / `.` / `,`)
    sym('@punctuation.bracket') { sym('@punctuation.delimiter') }, -- brackets (e.g. `()` / `{}` / `[]`)
    sym('@punctuation.special') { SpecialChar }, -- special symbols (e.g. `{}` in string interpolation)
    sym('@punctuation.special.rust') { PreProc },
    sym('@conceal') { Conceal },
    sym('@scope') {}, -- scope block
    sym('@reference') {}, -- scope block
    sym('@inlay.hint') { LspInlayHint }, -- identifier reference

    -- Locals
    sym('@definition') {}, -- various definitions
    sym('@definition.constant') { sym('@constant') }, -- constants
    sym('@definition.function') { sym('@function') }, -- functions
    sym('@definition.method') { sym('@method') }, -- methods
    sym('@definition.var') { fg = t.cyan0 }, -- variables
    sym('@definition.parameter') { sym('@parameter') }, -- parameters
    sym('@definition.macro') { sym('@function.macro') }, -- preprocessor macros
    sym('@definition.type') { Type }, -- types or classes
    sym('@definition.field') { sym('@definition') }, -- fields or properties
    sym('@definition.enum') { sym('@definition') }, -- enumerations
    sym('@definition.namespace') { sym('@namespace') }, -- modules or namespaces
    sym('@definition.import') { sym('@definition') }, -- imported names
    sym('@definition.associated') { sym('@definition') }, -- the associated type of a variable

    -- LSP
    sym('@lsp.mod.declaration.c') {},
    sym('@lsp.mod.definition.c') {},
    sym('@lsp.mod.globalScope.c') {},

    sym('@lsp.type.interface') { fg = MrSuit.flamingo },
    sym('@lsp.type.interface.rust') { Constant },
    sym('@lsp.typemod.function.defaultLibrary.lua') { sym('@function.builtin') },
    sym('@module.rust') { gui = 'italic' },
    sym('@punctuation.special.rust') { Punctuation },

    -- Quickfix window.
    qfFileName { Directory },
    qfSeparator { Delimiter },
    qfLineNr { LineNr },
    qfError { Error },

    -- Vim Help Highlighting
    helpCommand { fg = MrSuit.text, bg = MrSuit.surface1 },
    helpExample { fg = MrSuit.subtext0 },
    helpHeader { Title },
    helpSectionDelim { Punctuation },
    helpHyperTextJump { URI },

    -- mkdCode = { bg = c.bg2, fg = c.fg },
    -- mkdHeading = { fg = c.orange, style = "bold" },
    mkdCodeDelimiter { Punctuation },
    mkdCodeStart { Normal, gui = 'bold' },
    mkdCodeEnd { mkdCodeStart },
    mkdLink { URI },
    markdownHeadingDelimiter { Punctuation },
    markdownH1 { Title },
    markdownH2 { markdownH1 },
    markdownH3 { markdownH1 },
    markdownLinkText { URI },
    markdownUrl { URI },

    debugPC { CursorLine }, -- used for highlighting the current line in terminal-debug
    debugBreakpoint { Debug }, -- used for breakpoint colors in terminal-debug
  }
end)

-- Return our parsed theme for extension or use elsewhere.
return theme
