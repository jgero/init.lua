{ pkgs, readAll }: {
  name = "git";
  packages = with pkgs.vimPlugins; [
    vim-fugitive
    gitsigns-nvim
  ];
  config = readAll [ ./fugitive.lua ./gitsigns.lua ];
}
