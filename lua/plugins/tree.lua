-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
    { '<C-f>', ':Neotree toggle<CR>', { desc = 'NeoTree toggle' } },
  },
  opts = {
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,
    open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' }, -- do not use windows containing these filetypes
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = { -- why people use macOS?
          '.git',
          '.DS_Store',
          'thumbs.db',
        },
      },
      hijack_netrw_behavior = 'open_current',
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['<C-f>'] = 'close_window',
        },
      },
    },
  },
}
