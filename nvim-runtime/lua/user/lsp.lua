--- @mod user.lsp

local M = {}

-- { error = '󰅗 󰅙 󰅘 󰅚 󱄊 ', warn = '󰀨 󰗖 󱇎 󱇏 󰲼 ', info = '󰋽 󱔢 ', hint = '󰲽 ' },
M.diagnostic_signs = {
  Error = '󰅚 ',
  Warn = '󰗖 ',
  Info = '󰋽 ',
  Hint = '󰲽 ',
}

--- Gets a 'ClientCapabilities' object, describing the LSP client capabilities
--- Extends the object with capabilities provided by plugins.
--- @return lsp.ClientCapabilities
function M.make_client_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- Add cmp_nvim_lsp capabilities.
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  -- Enable preliminary support for workspace/didChangeWatchedFiles.
  capabilities = vim.tbl_deep_extend('keep', capabilities, {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
      configuration = true,
    },
  })
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  -- Add any additional plugin capabilities here.
  -- Make sure to follow the instructions provided in the plugin's docs.
  return capabilities
end

-- Bordered popups.
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

    -- Find references for the word under your cursor.
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('<M-CR>', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- The following code creates a keymap to toggle inlay hints in your code,
    -- if the language server you are using supports them
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map('<leader>h', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- NOTE: Wasted a bunch of time trying to figure out why `gq` was not working in
-- Rust files after enabling LSP formatting for that language. Turns out it also
-- didn't work in Lua files, and possibly other languages for which the LSP
-- supports 'textDocument/rangeFormatting'.
--
-- There's multiple reasons for this:
--
--   1. https://github.com/neovim/neovim/pull/19677 changes Neovim's LSP
--      behavior to set `formatexpr` to `v:lua.vim.lsp.formatexpr()` which calls
--      into the LSP to format the selected text.
--   2. https://github.com/neovim/neovim/pull/23681 adds support for a new
--      handler `client/registerCapability` which sets the same defaults
--      as (1) and therefore also overrides `formatexpr`.
--
-- While (1) can be worked around by wrapping `on_attach(…)` and restoring the
-- `formatexpr` value after Neovim's LSP code changes should work so that the
-- config can be fine-tuned by language, (2) reintroduces the issue when the LSP
-- is first initialized. This means that the first buffer in that language (the
-- one that spawns the LSP server for that language), will have `formatexpr =
-- "v:lua.vim.lsp.formatexpr()"` while any successive buffer will not -- because
-- the code involved in (2) is only called when initializing the LSP server.
--
-- A solution for (2) is to wrap the 'client/registerCapability' and restore
-- `formatexpr`, much like `on_attach`. Unlike `on_attach`, this is a global
-- handler and we need to explicitely check for the languages/LSP servers that
-- do not support 'textDocument/rangeFormatting' the way we want (e.g. ignore
-- comments).
--
-- At this point, the solution involves too much workaround code that I care to
-- maintain. It also appears that `:h gw` is equivalent to `:h gq`, but ignores
-- `formatexpr` which seems to imply that I was abusing `gq` when what I really
-- wanted was `gw`, and that it all boils down to a skill issue.
--
-- Conclusion: I gave up on working around the default behavior, and decided to
-- "git gud". I'll keep the code below commented for documentation purposes.

--[[
M.on_attach = function(...)
  lsp.on_attach(...)

  -- Fixes `gq` being borked: https://github.com/neovim/neovim/pull/19677.
  -- rust-analyzer does not support formatting lines with `gq`.
  vim.bo[bufnr].formatexpr = nil

  -- NOTE: but it actually doesn't… read on.
end

-- https://github.com/neovim/neovim/pull/23681 introduces a regression for LSP
-- calling into the `client/registerCapability` handler which unconditionally
-- calls `vim.lsp._set_defaults(…)` without giving users a chance to negate its
-- effects:
-- https://github.com/neovim/neovim/blob/b7e896671500a6e9a0c773bc6bac2d073e588eba/runtime/lua/vim/lsp/handlers.lua#L118
local client_registerCapability = vim.lsp.handlers['client/registerCapability']
vim.lsp.handlers['client/registerCapability'] = function(_, __, ctx)
  client_registerCapability(_, __, ctx)

  local client_id = ctx.client_id
  local client = assert(vim.lsp.get_client_by_id(client_id))

  for bufnr, _ in pairs(client.attached_buffers) do
    vim.bo[bufnr].formatexpr = nil
  end
end
--]]

return M
