-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
require('mini.ai').setup {}

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-operators.md
require('mini.operators').setup {}

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
require('mini.surround').setup {}

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
require('mini.move').setup {
  mappings = {
    -- Move visual selection in Visual mode. Defaults are Meta + hjkl.
    left = '<C-S-h>',
    right = '<C-S-l>',
    down = '<S-j>',
    up = '<S-k>',

    -- Move current line in Normal mode
    line_left = '<C-S-h>',
    line_right = '<C-S-l>',
    line_down = '<S-j>',
    line_up = '<S-k>',
  },
}
