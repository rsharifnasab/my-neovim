return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = lint.linters_by_ft or {}
      lint.linters_by_ft['markdown'] = { 'markdownlint' }
      lint.linters_by_ft['dockerfile'] = { 'hadolint' }
      lint.linters_by_ft['json'] = { 'jsonlint' }
      lint.linters_by_ft['go'] = { 'golangcilint' }
      lint.linters_by_ft['sh'] = nil -- use bashls instead { 'shellcheck' }
      lint.linters_by_ft['bash'] = { 'shellcheck' }
      lint.linters_by_ft['yaml'] = { 'yamllint' }
      lint.linters_by_ft['py'] = { 'ruff', 'pyright', 'pylint', 'flake8' }
      lint.linters_by_ft['clojure'] = nil
      lint.linters_by_ft['inko'] = nil
      lint.linters_by_ft['janet'] = nil
      lint.linters_by_ft['rst'] = nil
      lint.linters_by_ft['ruby'] = nil
      lint.linters_by_ft['terraform'] = nil
      lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint()
        end,
      })

      vim.diagnostic.config {
        virtual_text = {
          prefix = '', -- Could be '●', '▎', 'x'
          spacing = 4,
        },
        signs = true,
        underline = true,
        severity_sort = true,
      }
      -- TODO: https://github.com/1995parham/elievim/blob/a683ce41ff14b374f18eb89f609257b1f1c1dd22/lua/modules/completion/config.lua#L8

      -- Show diagnostics in a floating window on hover
      vim.api.nvim_create_autocmd({ 'CursorHold' }, {
        callback = function()
          local opts = {
            focusable = false,
            close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
          }
          vim.diagnostic.open_float(nil, opts)
        end,
      })

      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap = true, silent = true, desc = 'Show diagnostics in floating windows' })
    end,
  },
}
