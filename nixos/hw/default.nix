{ pkgs, ... }:
{
  services = {
    fwupd.enable = true;
    hardware.bolt.enable = true;
    fprintd.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    keyboard.zsa.enable = true;
    enableRedistributableFirmware = true;
  };

  environment = {
    systemPackages = with pkgs; [
      libmbim
    ];
  };
}
