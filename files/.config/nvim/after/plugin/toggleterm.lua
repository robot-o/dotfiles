require('toggleterm').setup {
  insert_mappings = true,
  terminal_mappings = true,
  hide_numbers = false,
  winbar = {
    enabled = false,
  },
  env = {
    ZSH_KEYBIND_MODE = "v",
  },
  size = function(term)
    if term.direction == "horizontal" then
      return 25
    end
    if term.direction == "vertical" then
      return 100
    end
  end,
  float_opts = {
    border = 'curved',
    width = 160,
    height = 40,
  }
}
