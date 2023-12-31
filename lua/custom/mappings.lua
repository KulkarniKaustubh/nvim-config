---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>gg"] = { "<cmd> vert Git <CR>", "Fugitive git status" },

    -- Remap all <C-w> keymaps
    ["<leader>w"] = { "<C-w>", "Control W keymaps" },
    ["<leader>wq"] = { "<cmd> qa <CR>", "Quit neovim completely" },

    --- Tabs
    ["<S-w>nt"] = { "<cmd> tabnew <CR>", "Create a new tab" },
    ["<S-w>l"] = { "<cmd> tabnext <CR>", "Go to the next tab" },
    ["<S-w>h"] = { "<cmd> tabprevious <CR>", "Go to the previous tab" },

    -- Find and replace the word under the cursor
    ["<leader>r"] = { "<cmd> %s/\\<<C-r><C-w>\\>/<C-r><C-w>/gcI<Left><Left><Left><Left> <CR>" },

    -- Show invisible characters
    ["<C-c>w"] = { "<cmd> set invlist <CR>", "Toggle the invisible listchars" },
  },

  v = {
    -- Find and replace the selected word
    ["<leader>r"] = { '"hy:%s/<C-r>h/<C-r>h/gcI<left><left><left><left>' }
  }
}

return M
