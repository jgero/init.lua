{ pkgs, readAll }: {
  name = "navigation";
  packages = with pkgs.vimPlugins; [
    pkgs.ripgrep
    pkgs.fzf
    pkgs.fd
    oil-nvim
    plenary-nvim
    telescope-nvim
    telescope-fzf-native-nvim
  ];
  config = readAll [ ./oil.lua ./telescope.lua ];
}
