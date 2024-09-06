require("gp").setup({
  -- configuration reference: https://github.com/Robitx/gp.nvim/blob/main/lua/gp/config.lua
  providers = {
    openai = {}, -- disabling because it's on by default
    ollama = {
      disable = false,
      endpoint = "http://localhost:11434/v1/chat/completions",
    },
  },
  agents = {
    {
      provider = "ollama",
      name = "chat-ollama-llama3.1",
      chat = true,
      command = false,
      model = {
        model = "llama3.1:latest",
        temperature = 0.6,
        top_p = 1,
        min_p = 0.05,
      },
      system_prompt = "You are a general AI assistant.",
    },
    {
      provider = "ollama",
      name = "code-ollama-llama3.1",
      chat = false,
      command = true,
      model = {
        model = "llama3.1:latest",
        temperature = 0.4,
        top_p = 1,
        min_p = 0.05,
      },
      system_prompt = require("gp.defaults").code_system_prompt,
    },
  },
  whisper = { disable = true, },
  image = { disable = true, },
  default_chat_agent = "chat-ollama-llama3.1",
  default_command_agent = "code-ollama-llama3.1",
  chat_dir = vim.fn.expand('$HOME/Documents/ollama/nvim'),
})

