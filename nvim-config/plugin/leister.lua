local tabline = require('user.tabline')

local state = {
  bufnr = nil,
  winid = nil,
  tab_by_id = {},
  id_by_tab = {},
  next_id = 1,
  ns = vim.api.nvim_create_namespace('leister-tab-manager'),
}

local function get_buffer_name(bufnr)
  local name = vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_get_name(bufnr) or ''
  if name == '' then
    return '-- Empty --'
  end

  if vim.api.nvim_get_option_value('buftype', { buf = bufnr }) == 'terminal' then
    return 'term'
  end

  return vim.fn.fnamemodify(name, ':t')
end

local function array_filter(arr_in, predicate)
  local arr_out = {}
  for _, value in ipairs(arr_in) do
    if predicate(value) then
      table.insert(arr_out, value)
    end
  end

  return arr_out
end

local function tab_buffers(tabnr)
  return array_filter(vim.fn.tabpagebuflist(tabnr), function(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return false
    end
    local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufnr })
    return buftype == '' or buftype == 'file' or buftype == 'terminal'
  end)
end

local function tab_label(tabnr)
  local buflist = tab_buffers(tabnr)

  if #buflist == 0 then
    return '-- Empty --'
  end

  local fname = get_buffer_name(buflist[1])
  if #buflist > 1 then
    fname = fname .. ' (+' .. tostring(#buflist) .. ')'
  end

  return fname
end

local function format_id(id)
  local max_id = math.max(1, state.next_id - 1)
  local width = math.max(3, 1 + math.floor(math.log10(max_id)))
  return string.format('/%0' .. tostring(width) .. 'd', id)
end

local function rebuild_ids(tabpages)
  local new_tab_by_id = {}
  local new_id_by_tab = {}

  for _, tabpage in ipairs(tabpages) do
    local id = state.id_by_tab[tabpage]
    if not id then
      id = state.next_id
      state.next_id = state.next_id + 1
    end
    new_tab_by_id[id] = tabpage
    new_id_by_tab[tabpage] = id
  end

  state.tab_by_id = new_tab_by_id
  state.id_by_tab = new_id_by_tab
end

local function update_virtual_lines(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local tabpages = vim.api.nvim_list_tabpages()
  rebuild_ids(tabpages)
  vim.api.nvim_buf_clear_namespace(bufnr, state.ns, 0, -1)

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for line_index, line in ipairs(lines) do
    local trimmed = vim.trim(line)
    if trimmed ~= '' then
      local id = trimmed:match('^/(%d+)')
      id = id and tonumber(id) or nil
      local tabpage = id and state.tab_by_id[id] or nil
      if tabpage and vim.api.nvim_tabpage_is_valid(tabpage) then
        local tabnr = vim.api.nvim_tabpage_get_number(tabpage)
        local buflist = tab_buffers(tabnr)
        if #buflist > 1 then
          local virt_lines = {}
          for idx = 2, #buflist do
            table.insert(virt_lines, { { '  • ' .. get_buffer_name(buflist[idx]), 'Comment' } })
          end
          vim.api.nvim_buf_set_extmark(bufnr, state.ns, line_index - 1, 0, {
            virt_lines = virt_lines,
          })
        end
      end
    end
  end
end

local function render_buffer(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local tabpages = vim.api.nvim_list_tabpages()
  rebuild_ids(tabpages)

  local lines = {}
  for _, tabpage in ipairs(tabpages) do
    local tabnr = vim.api.nvim_tabpage_get_number(tabpage)
    local id = state.id_by_tab[tabpage]
    local label = tab_label(tabnr)
    table.insert(lines, format_id(id) .. ' ' .. label)
  end

  vim.bo[bufnr].modifiable = true
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.bo[bufnr].modifiable = true
  vim.bo[bufnr].modified = false

  update_virtual_lines(bufnr)
end

local function parse_lines(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local desired = {}
  local seen = {}

  for _, line in ipairs(lines) do
    local trimmed = vim.trim(line)
    if trimmed ~= '' then
      local id = trimmed:match('^/(%d+)')
      id = id and tonumber(id) or nil
      if id and state.tab_by_id[id] and vim.api.nvim_tabpage_is_valid(state.tab_by_id[id]) then
        if not seen[id] then
          table.insert(desired, { id = id, tabpage = state.tab_by_id[id], existing = true })
          seen[id] = true
        end
      else
        table.insert(desired, { id = nil, tabpage = nil, existing = false })
      end
    end
  end

  return desired
end

local function delete_tabs(desired)
  local desired_ids = {}
  for _, entry in ipairs(desired) do
    if entry.id then
      desired_ids[entry.id] = true
    end
  end

  local tabpages = vim.api.nvim_list_tabpages()
  local tab_index = {}
  for i, tabpage in ipairs(tabpages) do
    tab_index[tabpage] = i
  end

  local tabs_to_delete = {}
  for _, tabpage in ipairs(tabpages) do
    local id = state.id_by_tab[tabpage]
    if id and not desired_ids[id] then
      table.insert(tabs_to_delete, tabpage)
    end
  end

  table.sort(tabs_to_delete, function(a, b)
    return (tab_index[a] or 0) > (tab_index[b] or 0)
  end)

  if #tabpages - #tabs_to_delete < 1 then
    table.remove(tabs_to_delete, #tabs_to_delete)
  end

  for _, tabpage in ipairs(tabs_to_delete) do
    if vim.api.nvim_tabpage_is_valid(tabpage) then
      local idx = tab_index[tabpage]
      if idx then
        vim.cmd.tabclose({ args = { tostring(idx) }, mods = { emsg_silent = true } })
      else
        vim.api.nvim_set_current_tabpage(tabpage)
        vim.cmd.tabclose({ mods = { emsg_silent = true } })
      end
    end
  end
end

local function create_tabs(desired)
  for _, entry in ipairs(desired) do
    if not entry.existing then
      vim.cmd.tabnew()
      local tabpage = vim.api.nvim_get_current_tabpage()
      local id = state.next_id
      state.next_id = state.next_id + 1
      state.tab_by_id[id] = tabpage
      state.id_by_tab[tabpage] = id
      entry.id = id
      entry.tabpage = tabpage
      entry.existing = true
    end
  end
end

local function reorder_tabs(desired)
  for target_index, entry in ipairs(desired) do
    local tabpage = entry.tabpage
    if tabpage and vim.api.nvim_tabpage_is_valid(tabpage) then
      vim.api.nvim_set_current_tabpage(tabpage)
      vim.cmd.tabmove({ args = { tostring(target_index - 1) } })
    end
  end
end

local function apply_changes(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  vim.bo[bufnr].modified = false
  local desired = parse_lines(bufnr)
  local previous_tab = vim.api.nvim_get_current_tabpage()

  delete_tabs(desired)
  create_tabs(desired)
  reorder_tabs(desired)

  if previous_tab and vim.api.nvim_tabpage_is_valid(previous_tab) then
    vim.api.nvim_set_current_tabpage(previous_tab)
  end

  render_buffer(bufnr)
  vim.schedule(function()
    if tabline and tabline.RefreshTabLine then
      tabline.RefreshTabLine()
    else
      vim.cmd.redrawtabline()
    end
  end)
end

local function ensure_syntax(bufnr)
  vim.api.nvim_buf_call(bufnr, function()
    vim.cmd.syntax('clear')
    vim.cmd.syntax([[match TabManagerId /^\/\d\+\s/ conceal]])
  end)
end

local function open_tab_manager()
  if state.bufnr and vim.api.nvim_buf_is_valid(state.bufnr) then
    if state.winid and vim.api.nvim_win_is_valid(state.winid) then
      vim.api.nvim_set_current_win(state.winid)
      return
    end
  else
    state.bufnr = vim.api.nvim_create_buf(true, false)
    vim.bo[state.bufnr].buftype = 'acwrite'
    vim.bo[state.bufnr].bufhidden = 'wipe'
    vim.bo[state.bufnr].swapfile = false
    vim.bo[state.bufnr].filetype = 'tabmanager'
    vim.bo[state.bufnr].undofile = false
    vim.bo[state.bufnr].modifiable = true
    vim.api.nvim_buf_set_name(state.bufnr, 'tab-manager')

    vim.api.nvim_create_autocmd('BufWriteCmd', {
      buffer = state.bufnr,
      callback = function()
        apply_changes(state.bufnr)
      end,
    })

    vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI', 'TextChangedP' }, {
      buffer = state.bufnr,
      callback = function()
        update_virtual_lines(state.bufnr)
      end,
    })

    vim.api.nvim_create_autocmd({ 'TabNew', 'TabClosed', 'TabEnter' }, {
      callback = function()
        if state.bufnr and vim.api.nvim_buf_is_valid(state.bufnr) and not vim.bo[state.bufnr].modified then
          render_buffer(state.bufnr)
        end
      end,
    })
  end

  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.3)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  state.winid = vim.api.nvim_open_win(state.bufnr, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  vim.wo[state.winid].number = true
  vim.wo[state.winid].relativenumber = false
  vim.wo[state.winid].conceallevel = 2
  vim.wo[state.winid].concealcursor = 'nvic'
  ensure_syntax(state.bufnr)
  render_buffer(state.bufnr)
end

vim.keymap.set('n', '<leader>t', open_tab_manager, { silent = true })
