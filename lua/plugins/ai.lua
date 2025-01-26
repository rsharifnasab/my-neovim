return {
  'frankroeder/parrot.nvim',
  dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim', 'rcarriga/nvim-notify' },

  config = function()
    require('parrot').setup {
      -- the prefix used for all commands
      cmd_prefix = 'Prt',

      providers = {
        openai = {
          api_key = os.getenv 'OPENAI_API_KEY',
          endpoint = 'https://openrouter.ai/api/v1',
          topic = {
            model = 'deepseek/deepseek-chat:',
            params = { max_tokens = 32 },
          },
        },
      },
    }
  end,
}
