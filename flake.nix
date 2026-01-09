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
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
    # lanzaboote,
    }:
    {
      nixosConfigurations = {
        sinkpad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # lanzaboote.nixosModules.lanzaboote
            ./hosts/sinkpad.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t14-intel-gen5
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.user = import ./home.nix;
            }
          ];
        };
      };
    };
}
