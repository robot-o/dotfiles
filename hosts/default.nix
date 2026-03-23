{ self, inputs, ... }:
{
  flake.nixosConfigurations =
    let
      nixos = "${self}/nixos";
      inherit (import nixos) laptop desktop vm;
      specialArgs = { inherit inputs self; };
    in
    {
      luna = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = laptop ++ [
          ./luna.nix
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
      kepler = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = laptop ++ [
          ./kepler.nix
          inputs.nixos-hardware.nixosModules.lenovo-legion-16iax10h
        ];
      };
      erebus = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = laptop ++ [
          ./erebus.nix
          inputs.nixos-hardware.nixosModules.dell-xps-13-9380
        ];
      };
      eleusinia = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = desktop ++ [
          ./eleusinia.nix
        ];
      };
      vestibule = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = vm ++ [
          ./vestibule.nix
        ];
      };
    };
}
