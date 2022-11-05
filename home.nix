{ config, pkgs, ... }:

{
  programs = {
    home-manager.enable = true;
    programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      redhat.ansible
      ms-dotnettools.csharp
      ms-azuretools.vscode-docker
      mikestead.dotenv
      golang.go
      GraphQL.vscode-graphql
      GraphQL.vscode-graphql-syntax
      GraphQL.vscode-graphql-execution
      hashicorp.terraform
      ms-vscode.hexeditor
      oderwat.indent-rainbow
      ms-toolsai.jupyter
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-slideshow
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-vscode.makefile-tools
      yzhang.markdown-all-in-one
      PKief.material-icon-theme
      bbenoist.Nix
      zhuangtongfa.material-theme
      Antyos.openscad
      christian-kohler.path-intellisense
      ms-python.vscode-pylance
      ms-python.python
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      wayou.vscode-todo-highlight
      vscodevim.vim
      tomoki1207.pdf
      ms-vscode.wordcount
      redhat.vscode-yaml
      DavidAnson.vscode-markdownlint
    ];
};
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
      retroarchFull
      # dev
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
      audacity
      gimp
      blender
      inkscape
      vlc
      # fab
      prusa-slicer
      freecad
      kicad
      openscad
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
