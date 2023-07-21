{
  description = "A flake for Lexurgy Sound Change Applier";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          overlays = [(final: prev: {
            lexurgy = prev.callPackage ./lexurgy.nix {};
          })];
          inherit system;
        };
        lib = nixpkgs.lib;
      in rec{
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            lexurgy
          ];
        };
      }
    );
}
