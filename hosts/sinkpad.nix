{ inputs, pkgs, ... }:

{
  system.stateVersion = "25.05";

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
      timeout = 1;
      systemd-boot.enable = false;
      limine.enable = true;
      limine.secureBoot.enable = true;
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

    fwupd.enable = true;
    hardware.bolt.enable = true;
    fprintd.enable = true;

    xserver = {
      enable = false;
      xkb = {
        layout = "de";
        variant = "us";
      };
    };

    greetd = {
      enable = true;
      settings = rec {
        default_session = {
          command = "niri-session";
          user = "user";
        };
        initial_session = default_session;
      };
    };

    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.packages = [
      pkgs.gnome-keyring
      pkgs.gcr
    ];

    printing.enable = false;

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

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
      enable = true;
      settings.PasswordAuthentication = false;
      settings.PermitRootLogin = "no";
    };

  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
    pam.services = {
      login.enableGnomeKeyring = true;
      greetd.enableGnomeKeyring = true;
      swaylock = { };
      swaylock-plugin = { };
    };
  };

  hardware = {
    bluetooth.enable = true;
    system76.power-daemon.enable = true;
    keyboard.zsa.enable = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
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

  xdg = {
    terminal-exec = {
      enable = true;
      settings.default = [ "com.mitchellh.ghostty.desktop" ];
    };
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
        "text/*" = "nvim.desktop";
      };
    };
  };
  environment = {
    systemPackages = with pkgs; [
      sbctl
      cacert
      libmbim
      modem-manager-gui
      usbutils
      ghostty
      neovim
      git
      git-lfs
      curl
      brave
      bitwarden-desktop
      xdg-desktop-portal-gnome
      inputs.niri-scratchpad.packages.${pkgs.stdenv.hostPlatform.system}.default
      distrobox
      dnsmasq
      unzip
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/user/.steam/root/compatibilitytools.d";
    };
  };

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
    seahorse.enable = true;
    nh = {
      enable = true;
      clean.enable = false;
      flake = "/home/user/.dotfiles";
    };
    virt-manager.enable = true;
    ydotool.enable = true;
    nm-applet.enable = true;
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
