-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- Indentation settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
-- Toggle Neo-tree with <leader>e
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })
-- Buffer keymaps
vim.keymap.set('n', '<leader>n', ':bn<cr>')
vim.keymap.set('n', '<leader>p', ':bp<cr>')
vim.keymap.set('n', '<leader>x', ':bd<cr>')
-- Toggle diagnostics
local diagnostics_active = true

vim.keymap.set('n', '<leader>td', function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end, { desc = 'Toggle diagnostics' })
-- Toggle autocomplete
vim.g.completion_enabled = true

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function(args)
    vim.b[args.buf].completion = vim.g.completion_enabled
  end,
})

vim.keymap.set('n', '<leader>ta', function()
  vim.g.completion_enabled = not vim.g.completion_enabled
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      vim.b[buf].completion = vim.g.completion_enabled
    end
  end
  if vim.g.completion_enabled then
    print 'Autocomplete: ON'
  else
    print 'Autocomplete: OFF'
  end
end, { desc = 'Toggle autocomplete' })
-- Toggle center cursor
local centered = false
local group_name = 'KeepCentered'

local function enable()
  if centered then
    print 'Centering: already ON'
    return
  end
  centered = true
  vim.api.nvim_create_augroup(group_name, { clear = true })
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'WinEnter', 'BufWinEnter', 'VimResized' }, {
    group = group_name,
    callback = function()
      vim.cmd 'silent! normal! zz'
    end,
  })
  print 'Centering: ON'
end

local function disable()
  if not centered then
    print 'Centering: already OFF'
    return
  end
  centered = false
  pcall(vim.api.nvim_del_augroup_by_name, group_name)
  print 'Centering: OFF'
end

local function toggle()
  if centered then
    disable()
  else
    enable()
  end
end
vim.keymap.set('n', '<leader>z', toggle, { desc = 'Toggle cursor centering' })
-- Custom plugins
return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('bufferline').setup {}
    end,
  },
  {
    'brianhuster/live-preview.nvim',
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
}
