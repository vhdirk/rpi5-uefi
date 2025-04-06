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
          inherit system;
          config = {
            allowUnfree = true;
          };
        };

      in {

        "${system}".default = pkgs.mkShell {
          packages = with pkgs;
            [
              libuuid.dev
              pkgsCross.aarch64-multiplatform.clang
              dtc
              # pkgsCross.aarch64-multiplatform.gcc
              # pkgsCross.aarch64-multiplatform.buildPackages.gcc
              # pkgsCross.aarch64-multiplatform.buildPackages.binutils
              # pkgsCross.aarch64-multiplatform.buildPackages.dtc

          ];

        };
      }
    );

    # devShells = flake-utils.lib.eachDefaultSystemPassThrough (
    #   system: let
    #     pkgs = import nixpkgs {
    #       # localSystem = system; # hostPlatform
    #       # crossSystem = "aarch64-linux"; # targetPlatform
    #       system = "aarch64-linux"; # targetPlatform

    #       config = {
    #         allowUnfree = true;
    #       };
    #     };

    #   in {

    #     "${system}".default = pkgs.mkShell {
    #       packages = with pkgs;
    #         [
    #           gcc
    #           # binutils
    #           dtc
    #           clang
    #       ];
    #     };
    #   }
    # );

  };
}


