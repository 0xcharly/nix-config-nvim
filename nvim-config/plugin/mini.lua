-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
require('mini.surround').setup {}

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-hipatterns.md
local hipatterns = require('mini.hipatterns')
hipatterns.setup {
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'.
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = '@comment.error' },
    hack = { pattern = '%f[%w]()HACK()%f[%W]', group = '@comment.warning' },
    todo = { pattern = '%f[%w]()TODO()%f[%W]', group = '@comment.todo' },
    note = { pattern = '%f[%w]()NOTE()%f[%W]', group = '@comment.note' },

    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
}
