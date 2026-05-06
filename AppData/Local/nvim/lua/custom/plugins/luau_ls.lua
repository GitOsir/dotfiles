local rojo_project = vim.fs.root(0, function(name)
  return name:match '.+%.project%.json$'
end)

if rojo_project then
  vim.filetype.add {
    extension = {
      lua = function(path)
        return path:match '%.nvim%.lua$' and 'lua' or 'luau'
      end,
    },
  }
end

return {
  'lopi-py/luau-lsp.nvim',
  config = function()
    -- Configure *server* settings
    vim.lsp.config('luau-lsp', {
      settings = {
        ['luau-lsp'] = {
          ignoreGlobs = { '**/_Index/**', 'node_modules/**' },
          completion = {
            fillCallArguments = false,
            imports = {
              enabled = true,
              ignoreGlobs = { '**/_Index/**', 'node_modules/**' },
            },
          },
        },
      },
    })

    -- We call `require("luau-lsp").setup` instead of `vim.lsp.enable("luau_lsp")` because luau-lsp.nvim will
    -- add extra features to luau-lsp, so we don't need to call the native lsp setup
    --
    -- See https://github.com/lopi-py/luau-lsp.nvim
    require('luau-lsp').setup {
      platform = {
        type = 'roblox',
      },
      plugin = {
        enabled = true,
      },
      fflags = {
        enable_new_solver = true,
      },
    }
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
