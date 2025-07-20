local M = {}
-- Open mini.files in the current directory
vim.keymap.set("n", "<leader>ee", function()
  require("mini.files").open()
end, { desc = "Toggle mini file explorer" })

-- Open mini.files at current file's location
vim.keymap.set("n", "<leader>ef",function()
  local mf = require("mini.files")
  mf.open(vim.api.nvim_buf_get_name(0), false)
  mf.reveal_cwd()
end, { desc = "Explore current file location" })

-- black python formatting
vim.keymap.set("n", "<leader>fmp", ":silent !black %<cr>")

--Dap
M.dap = {
    plugin = true,
    n = {
        ["<leader>db"] = {
          "<cmd> DapToggleBreakpoint <CR>",
          "Add breakpoint at line",
        },
        ["<leader>dr"] = {
          "<cmd> DapContinue <CR>",
          "Start or continue the debugger",
        },
    },
}
return M
