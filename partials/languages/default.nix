{ pkgs, readAll }: {
  name = "languages";
  # order =1;
  packages = with pkgs.vimPlugins; [
    # pkgs.tree-sitter
    # (nvim-treesitter.withPlugins (p: with p; [ nix lua go json ]))
    nvim-treesitter.withAllGrammars
    # nvim-treesitter
    # nvim-treesitter.builtGrammars
    # nvim-treesitter
    # cmp-treesitter
    # pkgs.gcc

    nvim-lspconfig
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-cmdline
    luasnip
    cmp_luasnip
    friendly-snippets
    lsp_lines-nvim

    llm-nvim
    pkgs.llm-ls
  ];
  config = readAll [ ./cmp.lua ./lsp-lines.lua ] + (import ./llm.lua.nix pkgs) + (import ./nvim-lspconfig.lua.nix pkgs) 
  + (import ./treesitter.lua.nix pkgs)
  ;
}
