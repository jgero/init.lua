{ pkgs }:
''
local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    if client.server_capabilities.documentFormattingProvider then
        nmap('<leader>lf', vim.lsp.buf.format, '[l]sp do [f]ormatting')
    end

    nmap('gd', vim.lsp.buf.definition, '[g]o to [d]efinition')
    nmap('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
    nmap('<leader>d', vim.lsp.buf.signature_help, 'show signature help [d]ocumentation')
    nmap('<leader>df', vim.diagnostic.open_float, 'show [d]iagnostics [f]loat')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ctions')
    nmap('H', vim.lsp.buf.hover, '[H]over')
end
local capabilities =
    require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspc = require('lspconfig')
lspc.lua_ls.setup({
    cmd = { '${pkgs.sumneko-lua-language-server}/bin/lua-language-server' },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            -- disable unknown global 'vim' warning
            diagnostics = { globals = { 'vim' } },
        },
    },
})
lspc.rnix.setup({
    cmd = { '${pkgs.rnix-lsp}/bin/rnix-lsp' },
    capabilities = capabilities,
    on_attach = on_attach,
})
lspc.bashls.setup({
    cmd = { '${pkgs.nodePackages.bash-language-server}/bin/bash-language-server' },
    capabilities = capabilities,
    on_attach = on_attach,
})
lspc.html.setup({
    cmd = {
        '${pkgs.nodePackages.vscode-html-languageserver-bin}/bin/html-languageserver',
        '--stdio' },
    capabilities = capabilities,
    on_attach = on_attach,
})
lspc.cssls.setup({
    cmd = {
        '${pkgs.nodePackages.vscode-css-languageserver-bin}/bin/css-languageserver',
        '--stdio' },
    capabilities = capabilities,
    on_attach = on_attach,
})
lspc.tsserver.setup({
    cmd = {
        '${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server',
        '--stdio' },
    capabilities = capabilities,
    on_attach = on_attach,
})
''
