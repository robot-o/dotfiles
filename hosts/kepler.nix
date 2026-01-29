{
  inputs,
  config,
  pkgs,
  ...
}:

{
  system.stateVersion = "25.05";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/3d396215-9dc9-491f-b774-82feb6e04067";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B400-90EA";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/89e28c77-dba8-4167-b829-40e4f20f3023"; }
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    plymouth.enable = true;
    consoleLogLevel = 3;
    loader = {
      timeout = 0;
      systemd-boot.enable = false;
      limine.enable = true;
      limine.secureBoot.enable = false;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      luks.devices."luks-6576d20e-bb36-48b0-b39e-d81452a6952c".device =
        "/dev/disk/by-uuid/6576d20e-bb36-48b0-b39e-d81452a6952c";
      luks.devices."luks-832887d9-e585-47cb-bb2c-7c52db7666ca".device =
        "/dev/disk/by-uuid/832887d9-e585-47cb-bb2c-7c52db7666ca";
    };
  };

  networking = {
    hostName = "kepler";
    networkmanager.enable = true;
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services = {
    xserver = {
      enable = false;
      videoDrivers = [ "nvidia" ];
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
    hardware.bolt.enable = true;
    fprintd.enable = true;
    printing.enable = false;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.PermitRootLogin = "no";
    };

    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };

  console.keyMap = "us";

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

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
    cpu.intel.updateMicrocode = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
    pam.services.user.kwallet.enable = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    fuzzel
    swaylock
    swaybg
    waybar
    xwayland-satellite
    gnome-tweaks
    neovim
    git
    curl
    brave
    btop
    mangohud
    protonup-ng
    lutris
    heroic
    bottles
    soteria
    bitwarden-desktop
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/user/.steam/root/compatibilitytools.d";
  };

  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      fzf
      ghostty
      eza
      fd
      ripgrep
      starship
      tmux
      tree-sitter
      nil
      nixfmt-rfc-style
      signal-desktop
      discord
      oversteer
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKbaskD/u1DU9S2k5xjrDzjnKUz35hCcpzrN5noXv5uu"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBC9Y7YcnhHSSgxRisqxbNVFcKgjO3AW5+BIIl/pBgaYBfJ9QBsSZAnS/g9JFuWTQEs+Wc9YeYD+qvOSVq2kjr1g="
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDE9h3DLLVPYwNYrxCQA8H2GBr1mdWazx3mXqj5wzUHT"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICXVo3FMKQz2JMrB1Uz3x9l2i3xrt5hf6AeRrOCbBGgV"
    ];
  };

  programs = {
    niri.enable = true;
    zsh.enable = true;
    firefox.enable = true;
    chromium.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
