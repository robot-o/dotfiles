{
  pkgs,
  config,
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
      nautilus
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
      ## dev/lsp/editor
      tree-sitter
      nil
      nixfmt
      shellcheck
      bash-language-server
      yaml-language-server
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
      ## arts and crafts
      # freecad
      kicad
      openscad
      audacity
      inkscape
      kdePackages.kdenlive
      orca-slicer
      godot
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
    file.".gitconfig".source = ./files/.gitconfig;
    file.".config/ghostty".source = ./files/.config/ghostty;
    file.".config/bat".source = ./files/.config/bat;

    file.".aliases".source = config.lib.file.mkOutOfStoreSymlink /home/user/.dotfiles/files/.aliases;
    file.".scripts".source = config.lib.file.mkOutOfStoreSymlink /home/user/.dotfiles/files/.scripts;
    file.".config/niri/config.kdl".source =
      config.lib.file.mkOutOfStoreSymlink /home/user/.dotfiles/files/.config/niri/config.kdl;
    file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink /home/user/.dotfiles/files/.config/nvim;
  };

}
