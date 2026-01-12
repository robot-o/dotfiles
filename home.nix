{
  pkgs,
  ...
}:

{
  programs = {
    home-manager.enable = true;
  };

  services = {
    polkit-gnome.enable = true;
    kanshi = {
      enable = true;
      profiles = {
        home = {
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "LG Electronics LG ULTRAGEAR 202NTQDER692";
              mode = "3440x1440@143.923";
              position = "2304,0";
              transform = "normal";
              scale = 1.0;
              adaptiveSync = true;
            }
            {
              criteria = "Dell Inc. DELL U2515H 9X2VY72I0YWL";
              mode = "2560x1440@59.951";
              position = "5744,-600";
              transform = "270";
              scale = 1.0;
              adaptiveSync = false;
            }
          ];
        };
        office = {
          outputs = [
            {
              criteria = "eDP-1";
              mode = "2880x1800@120.000";
              position = "768,1600";
              scale = 1.25;
              transform = "normal";
              adaptiveSync = false;
            }
            {
              criteria = "LG Electronics LG HDR WQHD+ 208NTYT1S818";
              mode = "3840x1600@143.998";
              position = "0,0";
              scale = 1.0;
              transform = "normal";
              adaptiveSync = false;
            }
          ];
        };
      };
    };
  };

  home = {
    username = "user";
    homeDirectory = "/home/user";
    stateVersion = "25.05";
    packages = with pkgs; [
      ## niri
      xwayland-satellite
      libnotify
      playerctl
      noctalia-shell
      ## cli
      tmux
      tmuxp
      starship
      eza
      bat
      fd
      ripgrep
      yazi
      btop
      direnv
      glow
      fzf
      ffmpeg
      yt-dlp
      ## dev
      lazygit
      delta
      jq
      yq
      tree-sitter
      nil
      nixfmt
      drawio
      bind
      remmina
      freerdp
      super-productivity
      ## media
      mpv
      mixxx
      bitwig-studio
      obs-studio
      ## arts and crafts
      orca-slicer
      freecad
      kicad
      openscad
      audacity
      gimp
      inkscape
      kdePackages.kdenlive
      ## social
      signal-desktop
      element-desktop
      discord
      slack
    ];

    pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.posy-cursors;
      name = "Posy_Cursor";
    };

    file.".scripts".source = ./files/.scripts;

    file.".shell_env".source = ./files/.shell_env;
    file.".zsh_env".source = ./files/.zsh_env;
    file.".zshenv".source = ./files/.zshenv;
    file.".zshrc".source = ./files/.zshrc;
    file.".aliases".source = ./files/.aliases;
    file.".tmux.conf".source = ./files/.tmux.conf;
    file.".gitconfig".source = ./files/.gitconfig;

    file.".config/nvim".source = ./files/.config/nvim;
    file.".config/ghostty".source = ./files/.config/ghostty;
    file.".config/bat".source = ./files/.config/bat;
  };

  xdg.configFile."niri/config.kdl".source = ./files/.config/niri/config.kdl;
  xdg.configFile."swayidle/config".source = ./files/.config/swayidle/config;
  xdg.configFile."swaylock/config".source = ./files/.config/swaylock/config;
}
