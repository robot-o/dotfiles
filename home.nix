{
  pkgs,
  ...
}:

{
  programs = {
    home-manager.enable = true;
    fuzzel.enable = true;
    swaylock.enable = true;
  };

  services = {
    mako.enable = true;
    swayidle.enable = true;
    polkit-gnome.enable = true;
  };

  home = {
    username = "user";
    homeDirectory = "/home/user";
    stateVersion = "25.05";
    packages = with pkgs; [
      ## niri
      swaybg
      xwayland-satellite
      brightnessctl
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
      # mixxx
      # bitwig-studio
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
