---@mod user.lsp
---
---@brief [[
---LSP related functions
---@brief ]]

local M = {}

local codelens = require('user.lsp.codelens')

---Gets a 'ClientCapabilities' object, describing the LSP client capabilities
---Extends the object with capabilities provided by plugins.
---@return lsp.ClientCapabilities
function M.make_client_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- Add com_nvim_lsp capabilities.
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  capabilities = require('lsp-selection-range').update_capabilities(capabilities)
  -- Enable preliminary support for workspace/didChangeWatchedFiles.
  capabilities = vim.tbl_deep_extend('keep', capabilities, {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
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

-- { error = '󰅗 󰅙 󰅘 󰅚 󱄊 ', warn = '󰀨 󰗖 󱇎 󱇏 󰲼 ', info = '󰋽 󱔢 ', hint = '󰲽 ' },
M.diagnostic_signs = {
  Error = '󰅚 ',
  Warn = '󰗖 ',
  Info = '󰋽 ',
  Hint = '󰲽 ',
}

local preview_location_callback = function(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  local buf, _ = vim.lsp.util.preview_location(result[1], {})
  if buf then
    local cur_buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].filetype = vim.bo[cur_buf].filetype
  end
end

local peek_definition = function()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

local peek_type_definition = function()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/typeDefinition', params, preview_location_callback)
end

local keymap = vim.keymap

-- require 'fidget'.setup {}

local default_on_codelens = vim.lsp.codelens.on_codelens
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.codelens.on_codelens = function(err, lenses, ctx, _)
  if err or not lenses or not next(lenses) then
    return default_on_codelens(err, lenses, ctx, _)
  end
  for _, lens in pairs(lenses) do
    if lens and lens.command and lens.command.title then
      lens.command.title = ' ' .. lens.command.title
    end
  end
  return default_on_codelens(err, lenses, ctx, _)
end

local code_action = function()
  return require('actions-preview').code_actions()
  -- return vim.lsp.buf.code_action()
end

local go_to_first_import = function()
  vim.lsp.buf.document_symbol {
    on_list = function(lst)
      for _, results in pairs(lst) do
        if type(results) ~= 'table' then
          goto Skip
        end
        for _, result in ipairs(results) do
          if result.kind == 'Module' then
            local lnum = result.lnum
            vim.api.nvim_input("m'")
            vim.api.nvim_win_set_cursor(0, { lnum, 0 })
            return
          end
        end
      end
      ::Skip::
      vim.notify('No imports found.', vim.log.levels.WARN)
    end,
  }
end

---@param filter 'Function' | 'Module' | 'Struct'
local filtered_document_symbol = function(filter)
  vim.lsp.buf.document_symbol()
  vim.cmd.Cfilter(('[[%s]]'):format(filter))
end

local document_functions = function()
  filtered_document_symbol('Function')
end

local document_modules = function()
  filtered_document_symbol('Module')
end

local document_structs = function()
  filtered_document_symbol('Struct')
end

-- Bordered popups.
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

M.on_attach = function(client, bufnr)
  vim.cmd.setlocal('signcolumn=yes')

  local function buf_set_var(...)
    vim.api.nvim_buf_set_var(bufnr, ...)
  end

  vim.bo[bufnr].bufhidden = 'hide'

  buf_set_var('lsp_client_id', client.id)

  local function desc(description)
    return { noremap = true, silent = true, buffer = bufnr, desc = description }
  end

  -- Mappings.
  keymap.set('n', 'gD', vim.lsp.buf.declaration, desc('lsp: go to [D]eclaration'))
  keymap.set('n', 'gd', vim.lsp.buf.definition, desc('lsp: go to [d]efinition'))
  keymap.set('n', '<Leader>gt', vim.lsp.buf.type_definition, desc('lsp: go to [t]ype definition'))
  -- keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- overridden by nvim-ufo
  keymap.set('n', '<Leader>pd', peek_definition, desc('lsp: [p]eek [d]efinition')) -- overridden by nvim-ufo
  keymap.set('n', '<Leader>pt', peek_type_definition, desc('lsp: [p]eek [t]ype definition')) -- overridden by nvim-ufo
  keymap.set('n', 'gi', vim.lsp.buf.implementation, desc('lsp: go to [i]mplementation'))
  keymap.set('n', '<Leader>gi', go_to_first_import, desc('lsp: [g]o to fist [i]mport'))
  keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, desc('lsp: signature help'))
  keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, desc('lsp: [w]orkspace folder [a]dd'))
  keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, desc('lsp: [w]orkspace folder [r]emove'))
  keymap.set('n', '<Leader>wl', function()
    -- TODO: Replace this with a Telescope extension?
    vim.print(vim.lsp.buf.list_workspace_folders())
  end, desc('lsp: [w]orkspace folders [l]'))
  keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, desc('lsp: [r]e[n]ame'))
  keymap.set('n', '<Leader>wq', vim.lsp.buf.workspace_symbol, desc('lsp: [w]orkspace symbol [q]uery'))
  keymap.set('n', '<Leader>dd', vim.lsp.buf.document_symbol, desc('lsp: [dd]ocument symbol'))
  keymap.set('n', '<Leader>df', document_functions, desc('lsp: [d]ocument [f]unctions'))
  keymap.set('n', '<Leader>ds', document_structs, desc('lsp: [d]ocument [s]tructs'))
  keymap.set('n', '<Leader>di', document_modules, desc('lsp: [d]ocument modules/[i]mports'))
  if client.name == 'rust-analyzer' then
    keymap.set('n', '<M-CR>', function()
      vim.cmd.RustLsp('codeAction')
    end, desc('rust: code action'))
  else
    keymap.set('n', '<M-CR>', code_action, desc('lsp: code action'))
  end
  keymap.set('n', '<M-l>', vim.lsp.codelens.run, desc('lsp: run code lens'))
  keymap.set('n', '<Leader>cr', vim.lsp.codelens.refresh, desc('lsp: [r]efresh [c]ode lenses'))
  keymap.set('n', '[l', codelens.goto_prev, desc('lsp: previous code[l]ens'))
  keymap.set('n', ']l', codelens.goto_next, desc('lsp: next code[l]ens'))
  keymap.set('n', 'gr', vim.lsp.buf.references, desc('lsp: [g]et [r]eferences'))
  keymap.set({ 'n', 'v' }, '<Leader>f', function()
    vim.lsp.buf.format { async = true }
  end, desc('lsp: [f]ormat buffer'))
  keymap.set('n', 'vv', function()
    require('lsp-selection-range').trigger()
  end, desc('lsp: trigger selection range'))
  keymap.set('v', 'vv', function()
    require('lsp-selection-range').expand()
  end, desc('lsp: expand selection range'))

  -- Autocomplete signature hints
  require('lsp_signature').on_attach()

  if client.server_capabilities.inlayHintProvider then
    keymap.set('n', '<space>h', function()
      local current_setting = vim.lsp.inlay_hint.is_enabled(bufnr)
      vim.lsp.inlay_hint.enable(bufnr, not current_setting)
    end, desc('lsp: toggle inlay [h]ints'))
  end

  local function get_active_clients(buf)
    -- TODO: use `vim.lsp.get_clients` when it's available (i.e. when updated to 10.x).
    return vim.lsp.get_active_clients { bufnr = buf, name = client.name }
  end
  local function buf_refresh_codeLens()
    vim.schedule(function()
      for _, c in pairs(get_active_clients(bufnr)) do
        if c.server_capabilities.codeLensProvider then
          vim.lsp.codelens.refresh()
          return
        end
      end
    end)
  end
  local group = vim.api.nvim_create_augroup(string.format('lsp-%s-%s', bufnr, client.id), {})
  if client.server_capabilities.codeLensProvider then
    vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost', 'TextChanged' }, {
      group = group,
      callback = buf_refresh_codeLens,
      buffer = bufnr,
    })
    buf_refresh_codeLens()
  end
end

M.on_dap_attach = function(bufnr)
  local dap = require('dap')
  local dap_widgets = require('dap.ui.widgets')
  local dap_utils = require('dap.utils')
  local dapui = require('dapui')
  local function desc(description)
    return { noremap = true, silent = true, buffer = bufnr, desc = description }
  end
  keymap.set('n', '<leader>dS', dap.stop, desc('[d]ap: [S]top'))
  -- keymap.set('n', '<Up>', dap.step_out, desc('dap: step out'))
  -- keymap.set('n', '<Down>', dap.step_into, desc('dap: sep into'))
  -- keymap.set('n', '<Right>', dap.step_over, desc('dap: step over'))
  keymap.set('n', '<space>dC', dap.continue, desc('[d]ap: [C]ontinue'))
  keymap.set('n', '<leader>b', dap.toggle_breakpoint, desc('dap: toggle [b]reakpoint'))
  -- keymap.set('n', '<leader>B', dap.toggle_conditional_breakpoint, opts) -- FIXME
  keymap.set('n', '<leader>dr', function()
    dap.repl.toggle { height = 15 }
  end, desc('[d]ap: toggl [r]epl'))
  keymap.set('n', '<leader>dl', dap.run_last, desc('[d]ap: run [l]ast debug session'))
  keymap.set('n', '<leader>dS', function()
    dap_widgets.centered_float(dap_widgets.frames)
  end, desc('[d]ap: centered floating widget (frames) [S]'))
  keymap.set('n', '<leader>ds', function()
    dap_widgets.centered_float(dap_widgets.scopes)
  end, desc('[d]ap: centered floating widget ([s]copes)'))
  keymap.set('n', '<leader>dh', dap_widgets.hover, desc('[d]ap: [h]over'))
  keymap.set('v', '<leader>dh', function()
    dap_widgets.hover(dap_utils.get_visual_selection_text)
  end, desc('[d]ap: [h]over'))
  keymap.set('v', '<leader>de', dapui.eval, desc('[d]ap: [e]valuate'))
  keymap.set('v', '<M-k>', dapui.float_element, desc('dap: show element in floating window'))
  keymap.set('n', '<leader>du', dapui.toggle, desc('[d]ap: toggle [u]i'))
end

vim.api.nvim_create_autocmd('LspDetach', {
  group = vim.api.nvim_create_augroup('lsp-detach', {}),
  callback = function(args)
    local group = vim.api.nvim_create_augroup(string.format('lsp-%s-%s', args.buf, args.data.client_id), {})
    pcall(vim.api.nvim_del_augroup_by_name, group)
  end,
})

vim.api.nvim_create_user_command('LspStop', function(kwargs)
  local name = kwargs.fargs[1]
  for _, client in pairs(vim.lsp.get_clients()) do
    if client.name == name then
      vim.lsp.stop_client(client.id)
    end
  end
end, {
  nargs = 1,
  complete = function()
    return vim.tbl_map(function(c)
      return c.name
    end, vim.lsp.get_clients())
  end,
})

return M
