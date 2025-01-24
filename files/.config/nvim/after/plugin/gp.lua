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
      name = "chat-deepseek-r1-14b",
      chat = true,
      command = false,
      model = {
        model = "deepseek-r1:14b",
        temperature = 0.6,
        top_p = 1,
        min_p = 0.05,
      },
      system_prompt = "You are a general AI assistant serving as part of a code editor.",
    },
    {
      provider = "ollama",
      name = "code-deepseek-r1-14b",
      chat = false,
      command = true,
      model = {
        model = "deepseek-r1:14b",
        temperature = 0.4,
        top_p = 1,
        min_p = 0.05,
      },
      system_prompt = require("gp.defaults").code_system_prompt,
    },
    {
      provider = "ollama",
      name = "chat-llama3.1",
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
      name = "code-llama3.1",
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
  default_chat_agent = "chat-deepseek-r1-14b",
  default_command_agent = "code-deepseek-r1-14b",
  chat_dir = vim.fn.expand('$HOME/Documents/ollama/nvim'),
})
