{
  description = "Dev environment for Horsa";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          nodejs_25
          nodePackages.npm
          prettier
        ];

        env = {
        };

        shellHook = ''
        '';
      };
    };
}

