{ pkgs }:
{
  deps = with pkgs; [
    gcc

    # langauge servers
    sumneko-lua-language-server
    rnix-lsp
    nodePackages.bash-language-server
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-css-languageserver-bin
    nodePackages.typescript-language-server
    cargo
  ];
}
