{
  description = "roboto's personal flake for the framework laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      in {
        nixosConfigurations = {
          user = lib.nixosSystem {
            inherit system;
            modules = [ 
              nixos-hardware.nixosModules.framework-12th-gen-intel
              ./configuration.nix 
              home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.user = import ./home.nix;
              }
            ];
          };
        };
      };
}
