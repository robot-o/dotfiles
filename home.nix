{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
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
      delta
      tmux
      fzf
      alacritty
      # general
      yt-dlp
      firefox
      google-chrome
      thunderbird
      logseq
      appimage-run
      # dev
      gnumake
      vscode
      kubectl
      kubectx
      bind
      kubecolor
      k9s
      azure-cli
      terraform
      ansible
      hcloud
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
      gimp
      blender
      inkscape
      # fab
      super-slicer
      # social
      slack
      teams
      discord
      signal-desktop
      tdesktop #telegram
      element-desktop
      # work
      super-productivity
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
