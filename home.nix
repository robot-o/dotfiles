{ config, pkgs, ... }:

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
      alacritty
      # general
      bitwarden
      unrar
      unzip
      ark
      yt-dlp
      firefox
      google-chrome
      thunderbird
      kleopatra
      logseq
      appimage-run
      gparted
      # games
      steam-run
      # dev
      delta
      gnumake
      vscode
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
      audacity
      gimp
      blender
      inkscape
      vlc
      # fab
      prusa-slicer
      freecad
      kicad
      # social
      slack
      teams
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
  };
}
