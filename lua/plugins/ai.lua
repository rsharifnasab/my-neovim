return {
  'frankroeder/parrot.nvim',
  dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim', 'rcarriga/nvim-notify' },

  config = function()
    require('parrot').setup {
      -- the prefix used for all commands
      cmd_prefix = 'Parrot',
      toggle_target = 'tabnew',

      providers = {
        custom = {
          style = 'openai',
          api_key = os.getenv 'OPENROUTER_API_KEY',
          endpoint = 'https://openrouter.ai/api/v1/chat/completions',
          models = {
            'openai/gpt-4o-mini',
            'openai/gpt-4o',
            'anthropic/claude-3.5-haiku',
            'anthropic/claude-3.5-sonnet',
            'anthropic/claude-3.7-sonnet',
            'openai/o3-mini',
          },
          -- parameters to summarize chat
          topic = {
            model = 'openai/gpt-4o-mini',

            params = { max_completion_tokens = 64 },
          },
          -- default parameters
          params = {
            chat = { temperature = 1.1, top_p = 1 },
            command = { temperature = 1.1, top_p = 1 },
          },
        },
      },
    }
  end,
}
