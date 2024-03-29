{
  description = "The sanest of neovim configs, for real";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
  };
  outputs = { self, nixpkgs, neovim, treefmt-nix, rust-overlay, ... }:
    let
      overlayFlakeInputs = prev: final: {
        neovim = neovim.packages.x86_64-linux.neovim;
      };
      overlayMyNeovim = prev: final: {
        myNeovim = import ./packages/myNeovim.nix {
          pkgs = final;
        };
      };
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [
          (import rust-overlay)
          overlayFlakeInputs
          overlayMyNeovim
        ];
      };
      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
    in
    {
      formatter.x86_64-linux = treefmtEval.config.build.wrapper;
      checks.x86_64-linux.formatter = treefmtEval.config.build.check self;
      packages.x86_64-linux.default = pkgs.myNeovim;
      apps.x86_64-linux.default = {
        type = "app";
        program = "${pkgs.myNeovim}/bin/nvim";
      };
    };
}
