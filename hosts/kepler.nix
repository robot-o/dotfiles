{ ... }:
{
  networking.hostName = "kepler";
  nixpkgs.hostPlatform = "x86_64-linux";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/3d396215-9dc9-491f-b774-82feb6e04067";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B400-90EA";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/89e28c77-dba8-4167-b829-40e4f20f3023"; }
  ];

  boot = {
    kernelModules = [ "kvm-intel" ];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      luks.devices."luks-6576d20e-bb36-48b0-b39e-d81452a6952c".device =
        "/dev/disk/by-uuid/6576d20e-bb36-48b0-b39e-d81452a6952c";
      luks.devices."luks-832887d9-e585-47cb-bb2c-7c52db7666ca".device =
        "/dev/disk/by-uuid/832887d9-e585-47cb-bb2c-7c52db7666ca";
    };
  };
}
