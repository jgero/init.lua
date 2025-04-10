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

        myNeovim =
          let
            configuredNeovim = pkgs.neovim.override {
              configure = {
                packages.myNeovimPackage = {
                  start = [ pluginSetup.neovimPlugins ];
                };
              };
            };
          in
          pkgs.symlinkJoin {
            name = "my-neovim";
            paths = [ configuredNeovim ];
            nativeBuildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram $out/bin/nvim \
                --add-flags '-u' \
                --add-flags '${pluginSetup.init-lua}' \
                --add-flags '--cmd' \
                --add-flags "'set runtimepath^=${pluginSetup.runtimePath}'"
            '';
          };
      in
      {
        formatter = treefmtEval.config.build.wrapper;
        checks.formatter = treefmtEval.config.build.check self;
        packages.default = myNeovim;
        apps.default = {
          type = "app";
          program = "${myNeovim}/bin/nvim";
        };
      });
}
