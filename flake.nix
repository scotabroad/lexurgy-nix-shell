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
          inherit system;
        };
        lib = nixpkgs.lib;
      in {
        packages.lexurgy = pkgs.callPackage ./lexurgy.nix {};
        
        defaultPackage = self.packages.${system}.lexurgy;
        
        devShells.default = pkgs.mkShell {
          packages = [
            self.packages.${system}.lexurgy
          ];
        };
      }
    );
}
