local spec = {
  ------------------
  -- colorschemes --
  ------------------
  {
    'rmehri01/onenord.nvim',
    lazy = true,
    name = 'colors_onenord',
    config = function()
      require('onenord').setup {
        theme = 'dark', -- "dark" or "light".
        borders = true, -- Split window borders
        fade_nc = true, -- Fade non-current windows
        styles = {
          diagnostics = 'underline',
        },
        disable = {
          background = false, -- Disable setting the background color
          float_background = false, -- Disable setting the background color for floating windows
          cursorline = false, -- Disable the cursorline
          eob_lines = true, -- Hide the end-of-buffer lines
        },
        -- Inverse highlight for different groups
        inverse = {
          match_paren = false,
        },
      }
    end,
  },
  {
    'ribru17/bamboo.nvim',
    name = 'colors_bamboo',
    lazy = true,
    config = function()
      require('bamboo').setup {
        transparent = false, -- Show/hide background
        dim_inactive = false, -- Dim inactive windows/buffers
        code_style = {
          comments = { italic = true },
          conditionals = { italic = true },
          keywords = {},
          functions = {},
          namespaces = { italic = true },
          parameters = { italic = true },
          strings = {},
          variables = {},
        },
      }
      require('bamboo').load()
    end,
  },
  {
    'AhmedAbdulrahman/vim-aylin',
    name = 'colors_aylin',
    lazy = true,
  },
  {
    'arzg/vim-colors-xcode',
    name = 'colors_xcode',
    lazy = true,
  },
  {
    'marko-cerovac/material.nvim',
    name = 'colors_material',
    lazy = true,
    config = function()
      require('material').setup {
        disable = {
          colored_cursor = false, -- Disable the colored cursor
          borders = false, -- Disable borders between verticaly split windows
          --eob_lines = false, -- Hide the end-of-buffer lines
        },
      }
    end,
  },
  {
    'tanvirtin/monokai.nvim',
    lazy = true,
    name = 'colors_monokai',
    config = function()
      require('monokai').setup {}
      -- require('monokai').setup { palette = require('monokai').pro }
      -- require('monokai').setup { palette = require('monokai').soda }
      -- require('monokai').setup { palette = require('monokai').ristretto }
    end,
  },
  {
    'oxfist/night-owl.nvim',
    lazy = true,
    name = 'colors_night_owl',
    config = function()
      require('night-owl').setup()
      vim.cmd.colorscheme 'night-owl'
    end,
  },
}

vim.keymap.set('n', '<leader>uu', function() --> Show all custom colors in telescope...
  for _, color in ipairs(spec) do --> Load all colors in spec....
    print(color)
    vim.cmd('Lazy load ' .. color.name) --> vim colorschemes cannot be required...
  end

  vim.schedule(function() --> Needs to be scheduled:
    local builtins = {
      'zellner',
      'torte',
      'slate',
      'shine',
      'ron',
      'quiet',
      'peachpuff',
      'pablo',
      'murphy',
      'lunaperche',
      'koehler',
      'industry',
      'evening',
      'elflord',
      'desert',
      'delek',
      'default',
      'darkblue',
      'blue',
    }

    local completion = vim.fn.getcompletion
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.fn.getcompletion = function() --> override
      return vim.tbl_filter(function(color)
        return not vim.tbl_contains(builtins, color) --
      end, completion('', 'color'))
    end

    vim.cmd 'Telescope colorscheme enable_preview=true'
    vim.fn.getcompletion = completion --> restore
  end)
end, { desc = 'Telescope custom colors', silent = true })

return spec
