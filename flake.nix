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
    rust-overlay.url = "github:oxalica/rust-overlay";
  };
  outputs = { nixpkgs, neovim, rust-overlay, ... }:
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
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      packages.x86_64-linux.default = pkgs.myNeovim;
      apps.x86_64-linux.default = {
        type = "app";
        program = "${pkgs.myNeovim}/bin/nvim";
      };
      checks.x86_64-linux = {
        stylua = pkgs.stdenv.mkDerivation {
          buildInputs = with pkgs; [ stylua myNeovim nixpkgs-fmt ];
          src = ./.;
          name = "stylua";
          buildPhase = ''
            mkdir -p "$out"
            nixpkgs-fmt --check .
            stylua -c .
          '';
        };
      };
    };
}
