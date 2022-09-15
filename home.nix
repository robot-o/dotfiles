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
      fzf
      alacritty
      # general
      firefox
      google-chrome
      thunderbird
      logseq
      # dev
      vscode
      kubectl
      kubectx
      kubecolor
      k9s
      azure-cli
      terraform
      ansible
      # daemons
      nextcloud-client
      mullvad-vpn
      # media
      spotify
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
#    file.".config/nvim" = {
 #     source = ./files/.config/nvim;
  #    recursive = true;
   # };
    file.".zshenv".source = ./files/.zshenv;
    file.".zshrc".source = ./files/.zshrc;
    file.".aliases".source = ./files/.aliases;
    file.".tmux.conf".source = ./files/.tmux.conf;
    file.".config/starship.toml".source = ./files/.config/starship.toml;
    file.".config/tmuxp".source = ./files/.config/tmuxp;
    file.".config/alacritty".source = ./files/.config/alacritty;
  };
}
