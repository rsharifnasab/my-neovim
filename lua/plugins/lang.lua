return {
  {
    'qvalentin/helm-ls.nvim',
    ft = 'helm',
    opts = {
      conceal_templates = {
        -- enable the replacement of templates with virtual text of their current values
        -- note: for better wrapping support, set `vim.opt.conceallevel = 2`
        enabled = false, -- this might change to false in the future
      },
      indent_hints = {
        -- enable hints for indent and nindent functions
        enabled = true,
        -- show the hints only for the line the cursor is on
        only_for_current_line = true,
      },
      action_highlight = {
        -- enable highlighting of the current block
        enabled = true,
      },
    },
  },
  -- 'towolf/vim-helm',
  --{
  --  'mrcjkb/rustaceanvim',
  --  version = '^5',
  --  lazy = false, -- This plugin is already lazy
  --},
}
