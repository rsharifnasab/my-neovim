return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',

  config = function()
    local treesitter = require 'nvim-treesitter'

    -- Configure nvim-treesitter
    treesitter.setup()

    -- Parsers to install
    local ensure_installed = {
      'bash',
      'c',
      'go',
      'yaml',
      'python',
      'rust',
      'java',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'vim',
      'vimdoc',
      'make',
      'query',
      'diff',
      'git_rebase',
      'gitcommit',
      'helm',
      'regex',
    }

    treesitter.install(ensure_installed)

    -- Enable Treesitter features for buffers
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype

        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
          return
        end

        -- Start Treesitter highlighting
        pcall(vim.treesitter.start, buf, lang)

        -- Treesitter indentation
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        -- Treesitter folding
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
      end,
    })
  end,
}
