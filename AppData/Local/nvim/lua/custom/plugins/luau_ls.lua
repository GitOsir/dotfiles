local function rojo_project()
  return vim.fs.root(0, function(name)
    return name:match '.+%.project%.json$'
  end)
end

if rojo_project() then
  vim.filetype.add {
    extension = {
      lua = function(path)
        return path:match '%.nvim%.lua$' and 'lua' or 'luau'
      end,
    },
  }
end
local settings = {
  ['luau-lsp'] = {
    completion = {
      enabled = true,
      imports = { enabled = true },
      autocompleteEnd = true,
    },
    hover = {
      strictDatamodelTypes = false,
    },
    diagnostics = {
      strictDatamodelTypes = false,
    },
    fflags = {
      enableByDefault = false,
    },
  },
}
return {
  'lopi-py/luau-lsp.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function(_, opts)
    vim.lsp.config('luau-lsp', {
      settings = settings,
    })

    require('luau-lsp').setup {
      platform = { type = 'roblox' },
      sourcemap = { enabled = true, generator_cmd = 'rojo sourcemap --watch default.project.json --output sourcemap.json' },
    }
  end,
}
