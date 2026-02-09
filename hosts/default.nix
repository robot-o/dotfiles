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
        ];
      };
      kepler = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = laptop ++ [
          ./kepler.nix
          inputs.nixos-hardware.nixosModules.lenovo-legion-16iax10h
        ];
      };
      # eleusinia = inputs.nixpkgs.lib.nixosSystem {
      #   inherit specialArgs;
      #   modules = desktop ++ [
      #     ./eleusinia.nix
      #   ];
      # };
      # vestibule = inputs.nixpkgs.lib.nixosSystem {
      #   inherit specialArgs;
      #   modules = vm ++ [
      #     ./vestibule.nix
      #   ];
      # };
    };
}
