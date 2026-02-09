{
  pkgs,
  lib,
  ...
}:

{
  system.stateVersion = "25.05";

  boot = {
    loader = {
      timeout = 1;
      systemd-boot.enable = lib.mkDefault true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 3;
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };

  time.timeZone = "Europe/Berlin";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  console.keyMap = "us";

  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "podman"
      "libvirtd"
      "kvm"
      "ydotool"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJwUUDAyJB7RS9Pjb55cBrBoTJj6pb4YY3YymKnfgGr+"
    ];
  };

  programs = {
    zsh.enable = true;
    nix-ld.enable = true;
    nh = {
      enable = true;
      clean.enable = false;
      flake = "/home/user/.dotfiles";
    };
  };

  environment = {
    systemPackages = with pkgs; [
      usbutils
      git
      git-lfs
      curl
      cacert
      dnsmasq
      unzip
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
