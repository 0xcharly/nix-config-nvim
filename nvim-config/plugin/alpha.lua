local dashboard = require('alpha.themes.dashboard')
dashboard.section.buttons.val = {}
dashboard.section.header.val = [[
        _                ___       _.--.
        \`.|\..----...-'`   `-._.-'_.-'`
        /  ' `         ,       __.--'
        )/' _/     \   `-_,   /
        `-'" `"\_  ,_.-;_.-\_ ',
            _.-'_./   {_.'   ; /
bug.       {_.-``-'         {_/
]]

require('alpha').setup(dashboard.opts)
