--@type MappingsTable
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

        -- Telescope
        ["gr"] = { "<cmd> Telescope lsp_references <CR>", "Telescope LSP references" },
        ["<leader>lL"] = { "<cmd> Telescope diagnostics bufnr=0 <CR>", "Telescope diagnostics for current buffer" },
        ["<leader>lA"] = { "<cmd> Telescope diagnostics <CR>", "Telescope diagnostics for the project" },

        -- LSP bindings
        ["<leader>lh"] = {
            function()
                vim.lsp.buf.hover()
            end,
            "LSP hover",
        },
        ["<leader>ll"] = {
            function()
                vim.diagnostic.open_float()
            end,
            "Floating diagnostic",
        },
        ["<leader>la"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            "LSP code action",
        },
        ["<leader>lr"] = {
            function()
                require("nvchad.renamer").open()
            end,
            "LSP rename",
        },
    },

    v = {
        -- Find and replace the selected word
        ["<leader>r"] = { '"hy:%s/<C-r>h/<C-r>h/gcI<left><left><left><left>' }
    }
}

return M
