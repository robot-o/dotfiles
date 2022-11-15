{
  description = "roboto's personal flake for the framework laptop";

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
            ./configuration.nix 
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.user = import ./home.nix;
            }
          ];
        };

        # lab-fujitsu-p720-1
        lab-1 = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/lab-1/hardware-configuration.nix
            ./hosts/lab-1/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.user = import ./home.nix;
            }
          ];
        };

        # lab-msi-ge60
        lab-2 = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/lab-2/hardware-configuration.nix
            ./hosts/lab-2/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.user = import ./home.nix;
            }
          ];

        # lab-acer-aspirevnitro
        lab-3 = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/lab-3/hardware-configuration.nix
            ./hosts/lab-3/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.user = import ./home.nix;
            }
          ];
        };

        # lab-dell-xps15-9550
        lab-4 = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/lab-4/hardware-configuration.nix
            ./hosts/lab-4/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.user = import ./home.nix;
            }
          ];
        };

        # lab-dell-xps13-9380
        lab-5 = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/lab-5/hardware-configuration.nix
            ./hosts/lab-5/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.user = import ./home.nix;
            }
          ];
        };

        };
      };
    };
}
