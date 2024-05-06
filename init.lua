-- Set <space> as the leader key, must happen before plugins are loaded
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Appearance
vim.g.have_nerd_font = true -- if you have a Nerd Font in the terminal
vim.opt.termguicolors = true
vim.opt.number = true -- Numbering of lines
vim.opt.relativenumber = false
vim.opt.showmode = false -- Don't show the mode (we have in status line)

vim.opt.wrap = true -- break long lines
vim.opt.linebreak = true -- break lines on white space
vim.opt.breakindent = true -- indent line after break

vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 10 -- Lines to keep above and below the cursor while scrolling
vim.opt.sidescrolloff = 5

-- Display whitespace
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- FIND and REPLACE
vim.opt.ignorecase = true -- case insensetive
vim.opt.smartcase = true -- case insensetive unless uppercase
vim.opt.incsearch = true -- search as soon as you type
vim.opt.gdefault = true -- global find and replace by default
vim.opt.inccommand = 'nosplit' -- Preview substitutions in the same window
vim.opt.hlsearch = false -- highlight on search, clear on pressing <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Behavior
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.
vim.opt.undofile = true -- Save undo history
vim.opt.lazyredraw = false -- set this to true to "not update screen on macros"

vim.opt.synmaxcol = 500 -- highlight up to 500 char per line

vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- if this ms passes without change, write swao
vim.opt.timeoutlen = 900 -- Displays which-key popup sooner (ms)

-- New splits location
vim.opt.splitright = true
vim.opt.splitbelow = false

-- FOLD
vim.opt.foldmethod = 'indent'
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 5

-- INDENT
-- NOTE: may break vim-suelth
-- vim.opt.shiftwidth = 4
-- vim.opt.tabstop = 4
-- vim.opt.smarttab = true
-- vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = false

-- FILE
-- vim.opt.autochdir = true
vim.opt.autoread = true -- auto reload file changed elsewhere
vim.opt.autowriteall = true -- write file before run commands
vim.opt.swapfile = false -- not create swap/backup file
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.hidden = true -- keep undo history on buffer change (?)

-- < and > can change line
vim.o.whichwrap = vim.o.whichwrap .. '<,>,[,]'
vim.o.backspace = 'indent,eol,start' -- Fix backspace behavior

-- EXTERNAL
vim.g.python3_host_prog = '/home/roozbeh/.pyenv/versions/nvim/bin/python3'
vim.g.ruby_host_prog = '/home/roozbeh/.local/share/gem/ruby/3.0.0/bin/neovim-ruby-host'

vim.o.wildmenu = true -- autocomplete vim commands with tab
vim.o.wildmode = 'list:longest' -- set wildmode to list:longest
vim.o.path = vim.o.path .. '**' -- search file with :find (same as FZF)

-- persistent undo
if vim.fn.has 'persistent_undo' == 1 then
  vim.opt.undofile = true
  local undodir = '/tmp/my-nvim-undo'

  local exists = vim.fn.isdirectory(undodir)
  if exists == 0 then
    vim.fn.mkdir(undodir, 'p')
  end
  vim.opt.undodir = undodir
end

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-Up>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-Down>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking  text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  pattern = { '*' },
  callback = function()
    vim.api.nvim_exec('silent! normal! g`"zv', false)
  end,
})

-- templates:
-- TODO: rewrite
vim.cmd [[
autocmd BufNewFile *.sh 0r ~/Templates/a.sh
autocmd BufNewFile *.py 0r ~/Templates/a.py
autocmd BufNewFile *.c 0r ~/Templates/main.c
autocmd BufNewFile algorithm.cpp 0r ~/Templates/algorithm.cpp
autocmd BufNewFile tester.cpp 0r ~/Templates/tester.cpp
]]

-- [[ Install `lazy.nvim` plugin manager ]]
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ PLUGINS ]]
--    :Lazy
--  To Sync plugins you can run
--    :Lazy sync
require('lazy').setup({
  -- Use `opts = {}` to force a plugin to be loaded.
  --  This is equivalent to:
  --    require('Comment').setup({})

  require 'plugins.debug',
  -- require 'plugins.autopairs',
  require 'plugins.telescope',
  require 'plugins.lint',
  require 'plugins.tree',
  require 'plugins.gitsigns',
  require 'plugins.dashboard',

  require 'plugins.ts',
  require 'plugins.lsp',
  require 'plugins.autocomplete',
  require 'plugins.autoformat',
  require 'plugins.color',
  require 'plugins.key',
  require 'plugins.lang',
  require 'plugins.misc',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
