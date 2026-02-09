{  ... }:
{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services = {
    system76-scheduler.enable = true;
    system76-scheduler.settings.cfsProfiles.enable = true;
    thermald.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };

  hardware = {
    system76.power-daemon.enable = true;
  };
}
