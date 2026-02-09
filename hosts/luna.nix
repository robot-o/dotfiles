{ ... }:
{
  networking.hostName = "luna";
  nixpkgs.hostPlatform = "x86_64-linux";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7dcdd692-326e-4aca-8873-81f48116aa7f";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E419-D056";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/82033f14-f768-4d68-84ee-05544e9f11fe"; }
  ];

  boot = {
    kernelModules = [ "kvm-intel" ];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
      luks.devices."luks-46f4e1d7-9bfb-4752-8c0d-36ac6c1b522d".device =
        "/dev/disk/by-uuid/46f4e1d7-9bfb-4752-8c0d-36ac6c1b522d";
      luks.devices."luks-83c103bc-c5f8-4c0a-9e64-c6fd906bf280".device =
        "/dev/disk/by-uuid/83c103bc-c5f8-4c0a-9e64-c6fd906bf280";
    };
  };
}
