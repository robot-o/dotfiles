{
  description = "roboto's flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    in {
      nixosConfigurations = {

        # neomuna
        user = lib.nixosSystem {
          inherit system;
          modules = [ 
            nixos-hardware.nixosModules.framework-12th-gen-intel
            /etc/nixos/hardware-configuration.nix 
            ./hosts/neomuna/configuration.nix 
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.user = import ./hosts/neomuna/home.nix;
            }
          ];
        };
        };
      };
    };
}
