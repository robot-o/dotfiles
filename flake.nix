{
  description = "floboto's rake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:robot-o/nixos-hardware/lenovo-thinkpad-t14-intel-gen5";
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        disko.follows = "disko";
      };
    };

    niri-scratchpad.url = "github:argosnothing/niri-scratchpad";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        nixosConfigurations = {
          sinkpad = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
            };
            modules = [
              ./hosts/sinkpad.nix
              inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-intel-gen5
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "hmbkp";
                home-manager.users.user = import ./home.nix;
              }
            ];
          };
        };
      };
      systems = [
        "x86_64-linux"
      ];
    };
}
