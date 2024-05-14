return {
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
    config = function()
      local hooks = require 'ibl.hooks'
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
      end)
      require('ibl').setup {
        indent = {
          highlight = {
            'RainbowRed',
            'RainbowYellow',
            'RainbowBlue',
            'RainbowOrange',
            'RainbowGreen',
            'RainbowViolet',
            'RainbowCyan',
          },
          -- check: :h ibl.config.indent.char
          char = { '│' },
          tab_char = { '│' },
        },
        scope = {
          enabled = false,
          show_start = false,
          show_end = false,
        },
        exclude = {
          filetypes = {
            'dashboard',
          },
        },
      }
    end,
  },

  -- colorschemes
  {
    'rmehri01/onenord.nvim',
    lazy = true,
    config = function()
      require('onenord').setup {
        theme = 'dark', -- "dark" or "light".
        borders = true, -- Split window borders
        fade_nc = true, -- Fade non-current windows
        styles = {
          comments = 'NONE',
          strings = 'NONE',
          keywords = 'NONE',
          functions = 'NONE',
          variables = 'NONE',
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
        custom_highlights = {},
        custom_colors = {},
      }
    end,
  },
  {
    'ribru17/bamboo.nvim',
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
      --require('bamboo').load()
    end,
  },
  'rafi/awesome-vim-colorschemes',
  'AhmedAbdulrahman/vim-aylin',
  'arzg/vim-colors-xcode',
  {
    -- https://github.com/ThemerCorp/themer.lua
    'themercorp/themer.lua',
    priority = 1000,
    init = function()
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
      require('telescope').load_extension 'themes'
      -- Select themes:
      -- :Telescope themes
      -- :COLORSCROLL
      -- export to kitty:
      -- :lua require("themer.modules.export.kitty").write_config()
      -- :w  ~/.config/kitty/nvim-color.conf
    end,
  },
}
