{
  config,
  pkgs,
  lib,
  modulesPath,
  ...
}:

{
  system.stateVersion = "25.05";

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

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
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    plymouth.enable = true;
    consoleLogLevel = 3;
    initrd = {
      verbose = false;
      systemd.enable = true;
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
      luks.devices."luks-46f4e1d7-9bfb-4752-8c0d-36ac6c1b522d".device =
        "/dev/disk/by-uuid/46f4e1d7-9bfb-4752-8c0d-36ac6c1b522d";
      luks.devices."luks-83c103bc-c5f8-4c0a-9e64-c6fd906bf280".device =
        "/dev/disk/by-uuid/83c103bc-c5f8-4c0a-9e64-c6fd906bf280";
    };
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  networking = {
    hostName = "sinkpad";
    networkmanager.enable = true;
  };

  services = {
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

    fprintd.enable = true;

    xserver = {
      enable = true;
      xkb = {
        layout = "de";
        variant = "us";
      };
    };

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    gnome = {
      core-apps.enable = true;
      games.enable = false;
      core-developer-tools.enable = false;
    };

    printing.enable = false;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  hardware = {
    keyboard.zsa.enable = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
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

  environment = {
    systemPackages = with pkgs; [
      cacert
      libmbim
      usbutils
      gnome-tweaks
      ghostty
      neovim
      git
      curl
      brave
      bitwarden-desktop
      xdg-desktop-portal-gnome
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/user/.steam/root/compatibilitytools.d";
    };

    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-user-docs
    ];
  };

  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
    ];
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs = {
    zsh.enable = true;
    nix-ld.enable = true;
    niri.enable = true;
    chromium.enable = true;
    thunderbird.enable = true;
    firefox.enable = true;
    nh = {
      enable = true;
      clean.enable = false;
      flake = "/home/user/.dotfiles";
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}

# networking.networkmanager.ensureProfiles.profiles = {
#   "39C3" = {
#     connection = {
#       id = "39C3";
#       type = "wifi";
#     };
#     wifi = {
#       mode = "infrastructure";
#       ssid = "39C3";
#     };
#     wifi-security = {
#       auth-alg = "open";
#       key-mgmt = "wpa-eap";
#     };
#     "802-1x" = {
#       anonymous-identity = "39C3";
#       eap = "ttls;";
#       identity = "39C3";
#       password = "39C3";
#       phase2-auth = "pap";
#       altsubject-matches = "DNS:radius.c3noc.net";
#       ca-cert = "${builtins.fetchurl {
#         url = "https://letsencrypt.org/certs/isrgrootx1.pem";
#         sha256 = "sha256:1la36n2f31j9s03v847ig6ny9lr875q3g7smnq33dcsmf2i5gd92";
#       }}";
#     };
#     ipv4 = {
#       method = "auto";
#     };
#     ipv6 = {
#       addr-gen-mode = "default";
#       method = "auto";
#     };
#   };
# };
