{
  description = "dash7-rs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }: {
    devShells = flake-utils.lib.eachDefaultSystemPassThrough (
      system: let
        pkgs = import nixpkgs {
          # system = "aarch64-linux";
          # localSystem = "x86_64-linux"; # buildPlatform
          # crossSystem = "aarch64-linux"; # hostPlatform
          inherit system;
          config = {
            allowUnfree = true;
          };
        };

        pkgs' = pkgs.pkgsCross.aarch64-multiplatform;

      in {

        "${system}".default = pkgs'.mkShell {
          packages = with pkgs';
            [
              gcc
          ];
        };
      }
    );
  };
}
