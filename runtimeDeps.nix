{ pkgs }:
{
  deps = with pkgs; [
    gcc
    sumneko-lua-language-server
  ];
}
