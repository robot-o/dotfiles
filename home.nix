{
  pkgs,
  config,
  ...
}:

{
  programs = {
    home-manager.enable = true;
    zathura.enable = true;
    swaylock = {
      enable = true;
      package = pkgs.swaylock-plugin;
      settings = {
        command-each = "windowtolayer -- ghostty --theme=\"Builtin Dark\" -e neo -aDF -f 60 -G 5.0 -S 16";
        daemonize = true;
      };
    };
  };

  services = {
    swayidle =
      let
        lock = "${pkgs.swaylock-plugin}/bin/swaylock-plugin -e -f -c 000000";
        display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
      in
      {
        enable = true;
        timeouts = [
          {
            timeout = 300;
            command = "${pkgs.libnotify}/bin/notify-send 'locking in 10 seconds' -t 10000";
          }
          {
            timeout = 310;
            command = lock;
          }
          {
            timeout = 420;
            command = display "off";
            resumeCommand = display "on";
          }
          {
            timeout = 900;
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
        events = {
          before-sleep = (display "off") + "; " + lock;
          after-resume = display "on";
          lock = (display "off") + "; " + lock;
          unlock = display "on";
        };
      };
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
              adaptiveSync = false;
            }
          ];
        }
        {
          profile.name = "office";
          profile.outputs = [
            {
              status = "disable";
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

  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  home = {
    username = "user";
    homeDirectory = "/home/user";
    stateVersion = "25.05";
    packages = with pkgs; [
      ## niri
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
      wayscriber
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
      sops
      age
      ## dev/lsp/editor
      tree-sitter
      nil
      nixfmt
      shellcheck
      bash-language-server
      yaml-language-server
      opencode
      ## dev
      lazygit
      delta
      jq
      yq
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
      sidequest
      ## arts and crafts
      blender
      # freecad
      # kicad
      openscad
      audacity
      inkscape
      # kdePackages.kdenlive
      orca-slicer
      godot
      godot-export-templates-bin
      gdtoolkit_4
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

    file.".shell_env".source = ./files/.shell_env;
    file.".zsh_env".source = ./files/.zsh_env;
    file.".zshenv".source = ./files/.zshenv;
    file.".zshrc".source = ./files/.zshrc;
    file.".tmux.conf".source = ./files/.tmux.conf;
    file.".config/ghostty".source = ./files/.config/ghostty;
    file.".config/bat".source = ./files/.config/bat;

    file.".aliases".source = config.lib.file.mkOutOfStoreSymlink /home/user/.dotfiles/files/.aliases;
    file.".scripts".source = config.lib.file.mkOutOfStoreSymlink /home/user/.dotfiles/files/.scripts;
    file.".config/niri/config.kdl".source =
      config.lib.file.mkOutOfStoreSymlink /home/user/.dotfiles/files/.config/niri/config.kdl;
    file.".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink /home/user/.dotfiles/files/.config/nvim;
    file.".gitconfig".source =
      config.lib.file.mkOutOfStoreSymlink /home/user/.dotfiles/files/.gitconfig;
  };

}
