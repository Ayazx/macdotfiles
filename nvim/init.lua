require("ayxz.core.options")
require("ayxz.core.keymappings")
require("ayxz.core.colorscheme")
require("ayxz.config.lazy")
vim.cmd("colorscheme tokyonight-night")
-- Make Normal background transparent
vim.cmd [[
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
  hi NormalFloat guibg=NONE ctermbg=NONE
  hi FloatBorder guibg=NONE ctermbg=NONE
  hi Pmenu guibg=NONE ctermbg=NONE
]]


