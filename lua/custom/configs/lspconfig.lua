local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities
capabilities.offsetEncoding = { "utf-16" }

local lspconfig = require("lspconfig")

vim.diagnostic.config ({
    float = {
        border = "single",
    }
})

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
            border = "single",
            title = "LSP Hover",
            focusable = true,
            wrap = true,
            max_width = 70,
            max_height = 25,
            offset_x = vim.api.nvim_get_option('columns'),
            offset_y = -vim.api.nvim_get_option('lines'),
        }
    ),
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            underline = true,
            virtual_text = false,
        }
    ),
    ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
            border = "single",
            title = "LSP Signature Help",
            focusable = true,
            wrap = true,
            max_width = 70,
            max_height = 25,
            offset_x = vim.api.nvim_get_option('columns'),
            offset_y = -vim.api.nvim_get_option('lines'),
        }
    )
}

lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"python"},
    handlers = handlers,
}

lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    dap_debug = true,
    dap_debug_gui = true,
    cmd = {"gopls"},
    filetypes = {"go", "gomod", "gowork", "gotmpl"},
    -- root_dir = util.root_pattern("go.work", "go.mod", ".git")
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            }
        },
    },
    handlers = handlers,
}

lspconfig.clangd.setup {
    on_attach = function(client, bufnr)
        client.server_capabilities.signatureHelpProvider = false
        on_attach(client, bufnr)
    end,
    handlers = handlers,
    capabilities = capabilities,
}
