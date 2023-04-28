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

        # lab-fujitsu-p720-1
        lab-1 = lib.nixosSystem {
          inherit system;
          modules = [
            /etc/nixos/hardware-configuration.nix 
            ./hosts/lab-fujitsu-p720-1/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.user = import ./hosts/lab-fujitsu-p720-1/home.nix;
            }
          ];
        };

        # lab-fujitsu-p720-2
        lab-2 = lib.nixosSystem {
          inherit system;
          modules = [
            /etc/nixos/hardware-configuration.nix 
            ./hosts/lab-fujitsu-p720-2/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.user = import ./hosts/lab-fujitsu-p720-2/home.nix;
            }
          ];
        };

        # lab-dell-xps13-9380-1
        lab-3 = lib.nixosSystem {
          inherit system;
          modules = [
            /etc/nixos/hardware-configuration.nix 
            ./hosts/lab-dell-xps13-9380-1/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.user = import ./hosts/lab-dell-xps13-9380-1/home.nix;
            }
          ];
        };

        # lab-dell-xps15-9550-1
        lab-4 = lib.nixosSystem {
          inherit system;
          modules = [
            /etc/nixos/hardware-configuration.nix 
            ./hosts/lab-dell-xps15-9550-1/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.user = import ./hosts/lab-dell-xps15-9550-1/home.nix;
            }
          ];
        };

        # lab-msi-ge60-1
        lab-5 = lib.nixosSystem {
          inherit system;
          modules = [
            /etc/nixos/hardware-configuration.nix 
            ./hosts/lab-msi-ge60-1/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.user = import ./hosts/lab-msi-ge60-1/home.nix;
            }
          ];

        # lab-acer-aspirevnitro-1
        lab-6 = lib.nixosSystem {
          inherit system;
          modules = [
            /etc/nixos/hardware-configuration.nix 
            ./hosts/lab-acer-aspirevnitro-1/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.user = import ./hosts/lab-acer-aspirevnitro-1/home.nix;
            }
          ];
        };

        };
      };
    };
}
