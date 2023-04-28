# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
  ];

  boot = {
    supportedFilesystems = [ "ntfs" "exfat" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };

    initrd = {
      secrets = {
        "/crypto_keyfile.bin" = null;
      };
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = "neomuna"; # Define your hostname.
    firewall.enable = true;
  };

  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = "en_US.utf8";

    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.utf8";
      LC_IDENTIFICATION = "de_DE.utf8";
      LC_MEASUREMENT = "de_DE.utf8";
      LC_MONETARY = "de_DE.utf8";
      LC_NAME = "de_DE.utf8";
      LC_NUMERIC = "de_DE.utf8";
      LC_PAPER = "de_DE.utf8";
      LC_TELEPHONE = "de_DE.utf8";
      LC_TIME = "de_DE.utf8";
    };
  };

  # Configure console keymap
  console.keyMap = "us";

  # Enable sound with pipewire.
  sound.enable = true;

  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
    sane.enable = true;
    sane.extraBackends = [ pkgs.sane-airscan ];
  };

  security.rtkit.enable = true;

  services = {
    xserver = {
      enable = true;
      layout = "de";
      xkbVariant = "us";
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # workaround for K3 Pro Vial
    udev = {
      packages = [
        pkgs.android-udev-rules
      ];
      extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", TAG+="uaccess", TAG+="udev-acl", GROUP="realet"
      '';
      };

    # firmware updates
    fwupd.enable = true;

    # thunderbolt daemon
    hardware.bolt.enable = true;

    # CUPS
    printing.enable = true;
    printing.drivers = [ pkgs.cnijfilter2 ];

    # yarr
    usbguard = {
      enable = true;
      presentDevicePolicy = "apply-policy";
      presentControllerPolicy = "apply-policy";
      insertedDevicePolicy = "apply-policy";
      IPCAllowedUsers = [ "root" "user" ];
    };

    avahi.enable = true;
    avahi.nssmdns = true;

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    mullvad-vpn.enable = true;

    flatpak.enable = true;
  };

  # enable flakes
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = "experimental-features = nix-command flakes";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-17.4.1"
  ];


  # packages installed in system profile
  environment.systemPackages = with pkgs; [
      git
      fd
      ripgrep
      sddm-kcm
      libsForQt5.bismuth
      libsForQt5.skanlite
      libsForQt5.kde-gtk-config
      libsForQt5.xdg-desktop-portal-kde
      neovim
      rsync
      usbutils
      v4l-utils
      vial
      android-udev-rules
      android-tools
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "nvim";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-kde
    ];
  };

  fonts = {
    fonts = with pkgs; [
        ubuntu_font_family
        noto-fonts-emoji
        (nerdfonts.override { fonts = [ "UbuntuMono" ]; })
      ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Ubuntu" "Noto Color Emoji" ];
        sansSerif = [ "Ubuntu" "Noto Color Emoji" ];
        monospace = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];
      };
    };
  };

  programs = {
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    kdeconnect.enable = true;
    dconf.enable = true;
    steam.enable = true;
    adb.enable = true;
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "suspend";
      qemu.runAsRoot = true;
    };
    podman = {
      enable = true;
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [
      "networkmanager"
      "wheel"
      "lp"
      "scanner"
      "libvirtd"
      "dialout"
      "uucp"
      "adbusers"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHE/vmPzEFQvQIA60B7x1l0OKgy09YBbmZj2uSkdQ1mk user@dreadnaught"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+13PfltwrTu7JYsKh+NeGcrnKsqnrvbnKwaDMbdZnw failsafe"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIgPKgxlniZdcNjUWfvKtVhGaxnC39PjfKzrOOiuvFt0 user@io"
    ];
  };

  system.stateVersion = "22.05";

}