{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  boot = {
    plymouth.enable = true;
  };

  services = {
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

    printing.enable = lib.mkDefault false;

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
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
    pam.services = {
      login.enableGnomeKeyring = true;
      greetd.enableGnomeKeyring = true;
      swaylock = { };
      swaylock-plugin = { };
    };
  };

  xdg = {
    terminal-exec = {
      enable = true;
      settings.default = [ "com.mitchellh.ghostty.desktop" ];
    };
    mime = {
      enable = true;
      defaultApplications = {
        "text/*" = "nvim.desktop";
        # TODO: move this out
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };
  };

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  environment = {
    systemPackages = with pkgs; [
      ghostty
      neovim
      xdg-desktop-portal-gnome
      inputs.niri-scratchpad.packages.${pkgs.stdenv.hostPlatform.system}.default
      wl-mirror
      xwayland-satellite
      libnotify
      playerctl
      noctalia-shell
      nautilus
      sushi
      neo
      fastfetch
      windowtolayer
      pwvucontrol
      # TODO: move this out
      brave
      bitwarden-desktop
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  programs = {
    niri.enable = true;
    seahorse.enable = true;
    ydotool.enable = true;
    nm-applet.enable = true;
    # TODO: move this out
    chromium.enable = true;
    thunderbird.enable = true;
    firefox.enable = true;
  };
}
