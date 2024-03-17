-- Vim options
vim.opt.colorcolumn = "80"
vim.opt.relativenumber = true
vim.opt.guifont = "monospace:h11"
vim.opt.scrolloff = 10
vim.opt.tabstop = 4                    -- insert 4 spaces for a tab
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Setting the invisible characters to show
vim.opt.listchars = {
  tab = "→\\",
  space = "·",
  nbsp = "␣",
  trail = "•",
  eol = "$",
  precedes = "«",
  extends = "»"
}

--- Python stuff
vim.g.loaded_python3_provider = nil

local venv = "~/Envs/lspenv"  -- Path to the environment to use with LSP
vim.g.python3_host_prog = vim.fn.expand(venv .. "/bin/python")
vim.env.VIRTUAL_ENV = vim.fn.expand(venv)
vim.env.PATH = vim.fn.expand(venv) .. "/bin" .. ":" .. vim.env.PATH

-- Restore nvim-tree with auto-session
local autocmd = vim.api.nvim_create_autocmd
autocmd({ "BufEnter" }, {
  pattern = "NvimTree*",
  callback = function()
    local api = require "nvim-tree.api"
    local view = require "nvim-tree.view"

    if not view.is_visible() then
      api.tree.open()
    end
  end,
})
