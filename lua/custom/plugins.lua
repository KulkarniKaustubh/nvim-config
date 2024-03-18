local plugins = {
    {
        "nvim-telescope/telescope.nvim",
        opts = function()
            local conf = require "plugins.configs.telescope"
            conf.defaults.mappings.i = {
                ["<C-n>"] = require("telescope.actions").cycle_history_next,
                ["<C-p>"] = require("telescope.actions").cycle_history_prev,
                ["<C-j>"] = require("telescope.actions").move_selection_next,
                ["<C-k>"] = require("telescope.actions").move_selection_previous,
            }

            return conf
        end,
    },
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "Gedit", "Gsplit", "Gdiffsplit" },
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "black",
                "mypy",
                "ruff",
                "pyright",
                "gopls",
                "clangd"
            }
        }
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        ft = {"python", "go", "cpp"},
        opts = function()
            return require "custom.configs.null-ls"
        end,
    },
    {
        "rmagatti/auto-session",
        lazy = false,
        opts = function()
            return require "custom.configs.auto-session"
        end,
    },
    {
        "ray-x/go.nvim",
        config = function()
            require("go").setup()
        end,
        event = {"CmdlineEnter"},
        ft = {"go", 'gomod'},
    }
}

return plugins
