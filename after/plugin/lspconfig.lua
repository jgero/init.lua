local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    if client.server_capabilities.documentFormattingProvider then
        nmap('<leader>ld', vim.lsp.buf.format, '[l]sp do [f]ormatting')
    end

    nmap('gd', vim.lsp.buf.definition, '[g]o to [d]efinition')
end
local capabilities =
require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspc = require('lspconfig')
lspc.sumneko_lua.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            -- enable neodev stuff
            completion = { callSnippet = 'Replace' },
            -- disable unknown global 'vim' warning
            diagnostics = { globals = { 'vim' } },
        },
    },
})
lspc.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
lspc.jdtls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
