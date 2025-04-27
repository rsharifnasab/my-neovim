-- Set <space> as the leader key, must happen before plugins are loaded
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Appearance
vim.g.have_nerd_font = true -- if you have a Nerd Font in the terminal
vim.opt.termguicolors = true
vim.opt.number = true -- Numbering of lines
vim.opt.relativenumber = false -- nima wants
vim.opt.showmode = false -- Don't show the mode (we have in status line)

vim.opt.wrap = true -- break long lines
vim.opt.linebreak = true -- break lines on white space
vim.opt.breakindent = true -- indent line after break

vim.opt.cursorline = false -- highlight current line
vim.opt.scrolloff = 4 -- Lines to keep above and below the cursor while scrolling
vim.opt.sidescrolloff = 5

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.opt.confirm = true

-- Display whitespace
vim.opt.list = true
vim.opt.listchars = {
  tab = '→ ', -- Tab character
  trail = '⋅', -- Trailing spaces
  extends = '›', -- Character for lines that extend beyond the window
  precedes = '‹', -- Character for lines that precede the window
  nbsp = '␣', -- Non-breakable space character
}

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
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
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
-- install python-pynvim
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.ruby_host_prog = '/home/roozbeh/.local/share/gem/ruby/3.0.0/bin/neovim-ruby-host'
vim.g.loaded_perl_provider = 0

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

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-Up>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-Down>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- my keymaps
-- Ctrl-A to select all
vim.api.nvim_set_keymap('n', '<C-a>', '<esc>ggVG<CR>', { noremap = true, silent = true, desc = 'Select all' })
vim.api.nvim_set_keymap('n', '<C-S>', ':update<CR>', { noremap = true, silent = true, desc = 'Ctrl-s to save to disk if needed' })
vim.api.nvim_set_keymap('v', '<C-S>', '<C-C>:update<CR>', { noremap = true, silent = true, desc = 'Ctrl-s to save to disk if needed' })
vim.api.nvim_set_keymap('i', '<C-S>', '<C-O>:update<CR>', { noremap = true, silent = true, desc = 'Ctrl-s to save to disk if needed' })
vim.api.nvim_set_keymap('n', '<C-L>', ':nohlsearch<CR>h<C-L>', { noremap = true, silent = true, desc = 'clear highlighted search result' })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Esc in terminal mode to exit' })

vim.api.nvim_set_keymap('n', ';', ':', { noremap = true, desc = 'simplify command mode entry' })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = true, desc = 'simplify command mode entry' })
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'x', {})

-- Buffer mappings
vim.api.nvim_set_keymap('n', '<C-p>', ':BufferNext<CR>', { noremap = true, silent = true, desc = 'Next opened buffer' })
vim.api.nvim_set_keymap('n', '<C-o>', ':BufferPrevious<CR>', { noremap = true, silent = true, desc = 'Prev opened buffer' })
vim.api.nvim_set_keymap('n', '<C-n>', ':enew<cr>', { noremap = true, silent = true, desc = 'Open new buffer' })
vim.api.nvim_set_keymap('n', '<C-q>', ':bd<CR>', { noremap = true, silent = true, desc = 'close current buffer' })
vim.api.nvim_set_keymap('i', '<C-c>', '<Esc>', { noremap = true, silent = true, desc = 'ctrl-c to exit insert mode' })
vim.api.nvim_set_keymap('n', 'Q', '<nop>', { noremap = true, desc = 'disable Q' })

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
    vim.cmd 'silent! normal! g`"zv'
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

vim.cmd [[
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1
]]

-- [[ Install `lazy.nvim` plugin manager ]]
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ PLUGINS ]]
require('lazy').setup({
  -- Use `opts = {}` to force a plugin to be loaded.
  -- This is equivalent to:
  -- require('Comment').setup({})

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
  require 'plugins.key',
  require 'plugins.lang',
  require 'plugins.misc',
  require 'plugins.debug',

  require 'plugins.ui',
  require 'plugins.color',

  require 'plugins.ai',
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

-- fix nvim-libuv bug
-- https://github.com/stevearc/conform.nvim/issues/173
-- https://github.com/neovim/neovim/issues/21856
-- https://github.com/olimorris/persisted.nvim/issues/84
--
vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
  pattern = '*',
  callback = function()
    vim.cmd.sleep { args = { '1m' } }
  end,
})

vim.cmd('colorscheme ' .. SelectColorschemeName)

-- vim: ts=2 sts=2 sw=2 et
