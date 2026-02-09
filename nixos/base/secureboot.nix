{ pkgs, lib, ... }:

{
  boot.loader = {
    systemd-boot.enable = lib.mkForce false;
    limine.enable = true;
    limine.secureBoot.enable = true;
  };

  environment.systemPackages = [ pkgs.sbctl ];
}
