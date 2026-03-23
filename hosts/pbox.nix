# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <nixos-hardware/dell/xps/13-9380>
    ];

  system.stateVersion = "25.05"; # Did you read the comment?

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pbox"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  services.xserver.enable = false;
  services.displayManager.sddm.enable = false;
  services.desktopManager.plasma6.enable = false;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "user";
  services.greetd.enable = true;
  services.greetd.settings = rec {
    default_session = {
      command = "niri-session";
      user = "user";
    };
    initial_session = default_session;
  };

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "niri-session";
  services.xrdp.openFirewall = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "us";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  security.polkit.enable = true;
  security.soteria.enable = true;
  security.rtkit.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    packages = with pkgs; [
      ghostty
      eza
      fd
      ripgrep
      starship
      tmux
      tree-sitter
      nil
      nixfmt-rfc-style
    ];
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBC9Y7YcnhHSSgxRisqxbNVFcKgjO3AW5+BIIl/pBgaYBfJ9QBsSZAnS/g9JFuWTQEs+Wc9YeYD+qvOSVq2kjr1g= luna" # domi
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIvEknAKyVpSbYdxd3ihuuZWgw2ydmCEaIc88PpSyYaj stefan@loki" #stoefan
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.niri.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    neovim
    git
    curl
    wget
    fuzzel
    waybar
    xwayland-satellite
    mako
    wl-mirror
    alacritty
    entangle
    usbutils
    gphoto2
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };


  services.avahi.enable = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.addresses = true;
  services.openssh.enable = true;


  services.gnome.gnome-keyring.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 3389 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}
