{
  pkgs,
  ...
}:

{
  programs = {
    home-manager.enable = true;
    zathura.enable = true;
  };

  services = {
    polkit-gnome.enable = true;
    kanshi = {
      enable = true;
      settings = [
        {
          profile.name = "mobile";
          profile.outputs = [
            {
              status = "enable";
              criteria = "eDP-1";
              mode = "2880x1800@120.000";
              position = "0,0";
              scale = 1.25;
              transform = "normal";
              adaptiveSync = false;
            }
          ];
        }
        {
          profile.name = "home";
          profile.outputs = [
            {
              status = "disable";
              criteria = "eDP-1";
              mode = "2880x1800@120.000";
              position = "0,0";
              scale = 1.25;
              transform = "normal";
              adaptiveSync = false;
            }
            {
              status = "enable";
              criteria = "LG Electronics LG ULTRAGEAR 202NTQDER692";
              mode = "3440x1440@143.923";
              position = "2304,0";
              transform = "normal";
              scale = 1.0;
              adaptiveSync = true;
            }
          ];
        }
        {
          profile.name = "office";
          profile.outputs = [
            {
              status = "enable";
              criteria = "eDP-1";
              mode = "2880x1800@120.000";
              position = "768,1600";
              scale = 1.25;
              transform = "normal";
              adaptiveSync = false;
            }
            {
              status = "enable";
              criteria = "LG Electronics LG HDR WQHD+ 208NTYT1S818";
              mode = "3840x1600@143.998";
              position = "0,0";
              scale = 1.0;
              transform = "normal";
              adaptiveSync = false;
            }
          ];
        }
      ];
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
      obsidian
      ## media
      mpv
      mixxx
      obs-studio
      ## gaymen
      osu-lazer-bin
      steam-run
      ## arts and crafts
      freecad
      kicad
      openscad
      audacity
      inkscape
      kdePackages.kdenlive
      orca-slicer
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
