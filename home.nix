{ config, pkgs, lib, ... }:

{
  programs = {
    home-manager.enable = true;
  };
  home = {
    username = "user";
    homeDirectory = "/home/user";
    stateVersion = "22.05";
    packages = with pkgs; [
      # shell / cli
      starship
      btop
      exa
      bat
      direnv
      tmux
      tmuxp
      glow
      fzf
      yt-dlp
      alacritty
      # general
      bitwarden
      unrar
      unzip
      ark
      firefox
      google-chrome
      thunderbird
      kleopatra
      logseq
      appimage-run
      gparted
      # games
      steam-run
      retroarchFull
      parsec-bin
      # dev
      jq
      gcc
      tree-sitter
      vscode
      delta
      gnumake
      kubectl
      kubernetes-helm
      kubectx
      bind
      kubecolor
      k9s
      remmina
      freerdp
      virt-manager
      azure-cli
      terraform
      ansible
      hcloud
      podman-compose
      # lang
      python3
      rustc
      cargo
      rustfmt
      go
      dotnet-sdk
      nodejs
      # daemons
      nextcloud-client
      mullvad-vpn
      # media
      spotify
      vlc
      obs-studio
      # arts and crafts
      #super-slicer-latest
      #freecad
      #kicad
      #openscad
      audacity
      gimp
      blender
      inkscape
      qFlipper
      unityhub
      # social
      slack
      # teams
      discord
      signal-desktop
      tdesktop #telegram
      element-desktop
      # work
      super-productivity
      networkmanager-fortisslvpn
      openfortivpn
    ];
    file.".scripts".source = ./files/.scripts;
    file.".zshenv".source = ./files/.zshenv;
    file.".zshrc".source = ./files/.zshrc;
    file.".aliases".source = ./files/.aliases;
    file.".tmux.conf".source = ./files/.tmux.conf;
    file.".config/starship.toml".source = ./files/.config/starship.toml;
    file.".config/tmuxp".source = ./files/.config/tmuxp;
    file.".config/alacritty".source = ./files/.config/alacritty;
    file.".config/nvim/init.lua".source= ./files/.config/nvim/init.lua;
    file.".config/nvim/lua".source= ./files/.config/nvim/lua;
    file.".config/nvim/after".source= ./files/.config/nvim/after;
  };
}
