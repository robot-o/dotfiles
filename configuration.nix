# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  boot = {
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
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  # bluetooth
  hardware.bluetooth.enable = true;

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
      #jack.enable = true;
    };

    # firmware updates
    fwupd.enable = true;

    # thunderbolt daemon
    hardware.bolt.enable = true;

    # CUPS
    printing.enable = true;

    avahi.enable = true;

    openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = "no";
    };

    mullvad-vpn.enable = true;

  };

  # enable flakes
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = "experimental-features = nix-command flakes";
  };

  nixpkgs.config.allowUnfree = true;

  # packages installed in system profile
  environment.systemPackages = with pkgs; [
      git
      fd
      ripgrep
      sddm-kcm
      libsForQt5.bismuth
      libsForQt5.kde-gtk-config
      neovim
      rsync
  ];

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
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "suspend";
      qemu.runAsRoot = false;
    };
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.dnsname.enable = true;
    };
  };

  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" "lp" "scanner" "libvirtd" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFlduC4EquKdtX0u4gxrjjiaBTUtLhgdwRD8HxZNbRgS user@ishtarsink-win"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMu5+cgjc/8A3FyFwqz6qNrToVJCLxGfZW2wuN13isQn user@luna"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOEfY+Vkh0LwoRNBPHRFccUyzpQmjT+xpM7FrrOadqOg user@enceladus"
    ];
  };

  system.stateVersion = "22.05";

}
