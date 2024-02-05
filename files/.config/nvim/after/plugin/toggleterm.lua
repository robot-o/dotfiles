require('toggleterm').setup {
  insert_mappings = true,
  terminal_mappings = true,
  hide_numbers = false,
  winbar = {
    enabled = true,
  },
  env = {
    ZSH_KEYBIND_MODE = "e",
  },
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    end
  end,
}
