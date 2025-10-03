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
