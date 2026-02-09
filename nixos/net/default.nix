{ lib, ... }:
{
  networking = {
    networkmanager.enable = true;
  };

  services = {
    avahi = {
      enable = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
        hinfo = false;
        userServices = false;
      };
    };

    openssh = {
      enable = lib.mkDefault true;
      settings.PasswordAuthentication = false;
      settings.PermitRootLogin = "no";
    };
  };
}
