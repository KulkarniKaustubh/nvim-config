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
        "nvimtools/none-ls.nvim",
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
            require("go").setup({
                lsp_codelens = false,
            })
        end,
        event = {"CmdlineEnter"},
        ft = {"go", 'gomod'},
    },
    -- {
    --     "OXY2DEV/markview.nvim",
    --     lazy = false,      -- Recommended
    --     -- ft = "markdown" -- If you decide to lazy-load anyway
    --     config = function()
    --         require("markview").setup()
    --     end,
    -- },
    {
        "unblevable/quick-scope",
        lazy = false,
    },
    {
        "augmentcode/augment.vim",
        lazy = false,
    },
    { "KulkarniKaustubh/ezstack.nvim", lazy = false },
    { "joechrisellis/lsp-format-modifications.nvim", ft = "python" },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPost",
        opts = { max_lines = 3 },
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = {},
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,
            current_line_blame_opts = { delay = 300, virt_text_pos = "eol" },
        },
    },
}

return plugins
