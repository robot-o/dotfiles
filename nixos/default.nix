let
  base = [
    ./base
    ./net
  ];
  pc = base ++ [
    ./base/secureboot.nix
    ./hw
    ./gooey
    ./net/vpn
    ./virt/kvm.nix
    ./virt/podman.nix
  ];
  desktop = pc ++ [ ];
  laptop = pc ++ [
    ./hw/power/laptop.nix
  ];
  vm = base ++ [
    ./virt/podman.nix
  ];
in
{
  inherit desktop laptop vm;
}
