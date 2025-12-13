return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = lint.linters_by_ft or {}
      lint.linters_by_ft['markdown'] = {} -- 'markdownlint' }
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
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })

      vim.diagnostic.config {
        virtual_text = false, -- no inline text clutter
        signs = true, -- keep gutter signs
        underline = true, -- subtle underline
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'if_many', -- linter/LSP name
          header = '',
          prefix = '',
        },
      }

      vim.api.nvim_create_autocmd('CursorHold', {
        callback = function()
          vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
            border = 'rounded',
            source = 'if_many',
            prefix = '',
            scope = 'cursor',
          })
        end,
      })

      -- Show diagnostics in a floating window (like Zed hover)
      vim.keymap.set('n', '<leader>e', function()
        vim.diagnostic.open_float(nil, { border = 'rounded', scope = 'cursor' })
      end, { noremap = true, silent = true, desc = 'Show diagnostics at cursor' })

      -- Open the diagnostics list (location list)
      local function focus_diag_loclist()
        -- Check if loclist window is already open → focus it
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local info = vim.fn.getwininfo(win)[1]
          if info.loclist == 1 then
            vim.api.nvim_set_current_win(win)
            return
          end
        end

        -- Open diagnostics location list
        vim.diagnostic.setloclist { open = true }

        -- Find the loclist window
        local loclist_win
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local info = vim.fn.getwininfo(win)[1]
          if info.loclist == 1 then
            loclist_win = win
            break
          end
        end
        if not loclist_win then
          return
        end

        -- Apply custom settings
        vim.api.nvim_win_call(loclist_win, function()
          vim.cmd [[
      wincmd L
      "setlocal winfixwidth
      setlocal nowrap
      setlocal number
      setlocal signcolumn=no
      setlocal cursorline
      setlocal nobuflisted
    ]]
        end)

        -- Adjust width dynamically based on content
        local width = 10
        local max_len = 0
        local items = vim.fn.getloclist(0)
        for _, item in ipairs(items) do
          if item.text then
            max_len = math.max(max_len, #item.text)
          end
        end

        -- Limit to at most 10 columns (for narrow lists)
        width = math.min(math.max(10, max_len), 80)

        vim.api.nvim_win_set_width(loclist_win, width)
      end
      vim.keymap.set('n', '<leader>q', focus_diag_loclist, { noremap = true, silent = true, desc = 'Focus diagnostics list if open' })

      -- Define clean diagnostic signs
      local signs = { Error = '✘ ', Warn = '▲ ', Hint = '⚑ ', Info = ' ' }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
      end
    end,
  },
}
