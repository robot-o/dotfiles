local M = {}

M.options = {
   user = function()
       require("custom.options")
   end,
}

M.mappings = require "custom.mappings"

M.ui = {
   theme = "onedark",
}

return M
