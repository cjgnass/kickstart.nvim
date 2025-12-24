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
}
