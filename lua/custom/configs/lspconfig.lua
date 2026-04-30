local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities
capabilities.offsetEncoding = { "utf-16" }

vim.diagnostic.config({
    float = {
        border = "single",
    },
    underline = true,
    virtual_text = false,
})

vim.o.winborder = "single"

vim.lsp.config("*", {
    on_attach = on_attach,
    capabilities = capabilities,
})

vim.lsp.config("pyright", {
    filetypes = { "python" },
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
    },
})

vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
})

vim.lsp.config("clangd", {
    on_attach = function(client, bufnr)
        client.server_capabilities.signatureHelpProvider = false
        on_attach(client, bufnr)
    end,
})

vim.lsp.config("ts_ls", {
    on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end,
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "json" },
})

vim.lsp.config("ruff", {
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        -- Parent on_attach disables formatting on every client; ruff is the
        -- one server we want to format with, so re-enable it here.
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
    end,
    filetypes = { "python" },
})

vim.lsp.enable({ "pyright", "gopls", "clangd", "ts_ls", "ruff" })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("PythonRuffFormat", { clear = true }),
    pattern = "*.py",
    callback = function(args)
        local ruff = vim.lsp.get_clients({ bufnr = args.buf, name = "ruff" })[1]
        if not ruff then
            return
        end
        require("lsp-format-modifications").format_modifications(ruff, args.buf)
    end,
    desc = "Format modified ranges in Python buffers with ruff on save",
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end
        if client.name == "ruff" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
        end
    end,
    desc = "LSP: Disable hover capability from Ruff",
})
