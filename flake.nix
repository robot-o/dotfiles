{
  description = "roboto's personal computing flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:robot-o/nixos-hardware/lenovo-thinkpad-t14-intel-gen5";
    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v1.0.0";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-scratchpad.url = "github:argosnothing/niri-scratchpad";
    # stylix = {
    #   url = "github:nix-community/stylix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      # stylix,
      ...
    # lanzaboote,
    }:
    {
      nixosConfigurations = {
        sinkpad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            # inputs.lanzaboote.nixosModules.lanzaboote
            # stylix.nixosModules.stylix
            ./hosts/sinkpad.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t14-intel-gen5
            home-manager.nixosModules.home-manager
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
}
