{
  description = "The sanest of neovim configs, for real";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, flake-utils, treefmt-nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        treefmtEval = treefmt-nix.lib.evalModule pkgs ./lib/treefmt.nix;

        moduleName = "my-config";

        pluginDefs = import ./partials { inherit pkgs; };
        configurePlugins = import ./lib/configureNeovimPlugins.nix { inherit pkgs; };

        pluginSetup = configurePlugins pluginDefs moduleName;

        initLua = pkgs.writeText "init.lua" pluginSetup.requireLines;
        myNvimConfig = pkgs.stdenv.mkDerivation {
          name = "nvim-config";
          src = null;
          phases = [ "installPhase" ];
          installPhase = ''
            mkdir -p $out/config/nvim/lua/${moduleName}
            cp ${initLua} $out/config/nvim/init.lua
            cp -r ${pluginSetup.configDir}/lua/${moduleName}/* $out/config/nvim/lua/${moduleName}/
            #ls -la ${pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [ p.c p.java ])}/parser
            #exit 1
          '';
        };

        myNeovim = pkgs.neovim.override {
          configure = {
            customRC = "luafile ${myNvimConfig}/config/nvim/init.lua";
            packages.myNeovimPackage = {
              start = [ pluginSetup.neovimPlugins ];
            };
          };
        };
        myNeovimWrapper = pkgs.writeShellScriptBin "my-nvim" ''
          export XDG_CONFIG_HOME=${myNvimConfig}/config
          exec ${myNeovim}/bin/nvim --cmd "set runtimepath^=${pluginSetup.runtimePath}" "$@"
        '';
      in
      {
        formatter = treefmtEval.config.build.wrapper;
        checks.formatter = treefmtEval.config.build.check self;
        packages.default = myNeovimWrapper;
        apps.default = {
          type = "app";
          program = "${myNeovimWrapper}/bin/my-nvim";
        };
      });
}
