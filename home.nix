{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs = {
    home-manager.enable = true;
  };
  home = {
    username = "user";
    homeDirectory = "/home/user";
    stateVersion = "25.05";
    packages = with pkgs; [
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
      # mixxx
      # bitwig-studio
      obs-studio
      ## arts and crafts
      orca-slicer
      # freecad
      # kicad
      # openscad
      audacity
      gimp
      # blender
      inkscape
      kdePackages.kdenlive
      # qFlipper
      # unityhub
      ## social
      signal-desktop
      element-desktop
      discord
      # slack
    ];

    file.".scripts".source = ./files/.scripts;

    file.".shell_env".source = ./files/.shell_env;
    file.".zsh_env".source = ./files/.zsh_env;
    file.".zshenv".source = ./files/.zshenv;
    file.".zshrc".source = ./files/.zshrc;
    file.".aliases".source = ./files/.aliases;
    file.".tmux.conf".source = ./files/.tmux.conf;

    file.".config/nvim".source = ./files/.config/nvim;
    file.".config/ghostty".source = ./files/.config/ghostty;
    file.".config/bat".source = ./files/.config/bat;
  };
}
