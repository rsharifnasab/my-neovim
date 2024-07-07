local color_scheme_list = {
  ------------------
  -- colorschemes --
  ------------------
  {
    -- https://github.com/ThemerCorp/themer.lua
    'themercorp/themer.lua',
    name = 'themer',
    setup = function()
      require('themer').setup {
        --colorscheme = 'kanagawa',
        colorscheme = 'doom_one',
        transparent = false,
        lugins = {
          treesitter = true,
          indentline = true,
          barbar = true,
          bufferline = true,
          cmp = true,
          gitsigns = true,
          lsp = true,
          telescope = true,
        },
        styles = {
          ['function'] = { style = 'italic' },
          functionbuiltin = { style = 'italic' },
          variable = { style = 'italic' },
          variableBuiltIn = { style = 'italic' },
          parameter = { style = 'italic' },
        },
      }
      -- Select themes:
      -- :COLORSCROLL (only themer)
      -- <space>cc

      -- export to kitty:
      -- :lua require("themer.modules.export.kitty").write_config()
      -- :w  ~/.config/kitty/nvim-color.conf
    end,
  },
  {
    'rmehri01/onenord.nvim',
    lazy = true,
    name = 'onenord',
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
    name = 'bamboo',
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
    name = 'aylin',
    lazy = true,
  },
  {
    'lunacookies/vim-colors-xcode',
    name = 'xcode',
    lazy = true,
  },
  {
    'NTBBloodbath/doom-one.nvim',
    name = 'doom-one',
    lazy = true,
  },
  {
    'tyrannicaltoucan/vim-deep-space',
    name = 'deep-space',
    lazy = true,
  },
  {
    'marko-cerovac/material.nvim',
    name = 'material',
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
    name = 'monokai',
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
    name = 'night-owl',
    config = function()
      require('night-owl').setup()
      vim.cmd.colorscheme 'night-owl'
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
    name = 'nightfox',
    config = function()
      require('nightfox').setup {}
    end,
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = true,
    name = 'nordic',
    config = function()
      require('nordic').load()
    end,
  },
  {
    'uloco/bluloco.nvim',
    lazy = true,
    name = 'bluloco',
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      require('bluloco').setup {
        style = 'dark', -- "auto" | "dark" | "light"
        transparent = false,
        terminal = vim.fn.has 'gui_running' == 1, -- bluoco colors are enabled in gui terminals per default.
        guicursor = true,
      }
    end,
  },
  {
    -- like ayu and gruvbox and papercolor
    'savq/melange-nvim',
    lazy = true,
    name = 'melange',
    config = function()
      vim.cmd.colorscheme 'melange'
    end,
  },
}

vim.keymap.set('n', '<leader>cc', function() --> Show all custom colors in telescope...
  for _, color in ipairs(color_scheme_list) do --> Load all colors in spec....
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
        return not vim.tbl_contains(builtins, color)
      end, completion('', 'color'))
    end

    vim.cmd 'Telescope colorscheme enable_preview=true'
    vim.fn.getcompletion = completion --> restore
  end)
end, { desc = 'Select [C]olors[C]heme', silent = true })

-- https://github.com/folke/lazy.nvim/discussions/1167
-- 'deep-space'
-- 'OceanicNext'
-- 'onedark'
SelectColorschemeName = 'nordic'

if SelectColorschemeName and SelectColorschemeName ~= '' then
  for _, cs in ipairs(color_scheme_list) do
    if cs.name == SelectColorschemeName then
      cs.lazy = false
      cs.priority = 1000
    else
      cs.lazy = true
    end
  end
end

return color_scheme_list
