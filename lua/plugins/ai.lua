return {
  {
    'xTacobaco/cursor-agent.nvim',
    config = function()
      -- Toggle the agent terminal
      vim.keymap.set('n', '<leader>ai', ':CursorAgent<CR>', { desc = 'Cursor Agent: Toggle terminal' })
    end,
  },
}
