return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()
    vim.keymap.set('n', '<leader>e', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon open GUI' })
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon add Buffer' })
    vim.keymap.set('n', '<C-P>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-N>', function()
      harpoon:list():next()
    end)
  end,
}
