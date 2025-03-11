{
  pkgs,
  ...
}:
let
  cfg = ../../../dots;
  u-hm = ./../../universal-modules; # universal Home Manager modules
  nd = ./../modules;

  my-kubernetes-helm =
    with pkgs;
    wrapHelm kubernetes-helm {
      plugins = with pkgs.kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
        helm-s3
        helm-git
      ];
    };

  my-helmfile = pkgs.helmfile-wrapped.override {
    inherit (my-kubernetes-helm) pluginsDir;
  };
in
{

  home = {
    enableNixpkgsReleaseCheck = false;
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;

  imports = [
    "${u-hm}/fish.nix"
    "${u-hm}/kitty.nix"
    "${u-hm}/nvim.nix"
    "${u-hm}/tmux.nix"
  ];

  home.file = {
    ".config/alacritty".source = "${cfg}/alacritty";
    ".config/fastfetch".source = "${cfg}/fastfetch";
    ".config/nvim".source = "${cfg}/nvim";
  };

  home.sessionVariables = {
    # Fixes Rust Compiling the LSP
    PATH = "/usr/bin/:$PATH";
    TERM = "xterm-256color";
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    # Editors
    vim

    # Development
    ansible
    ansible-builder
    ansible-lint
    ansible-navigator
    gcc
    gnumake
    nodejs
    python3
    rustup
    yamlfmt

    # Git
    gh
    gitflow

    # Terminal
    alacritty
    bat
    btop
    fastfetch
    fzf
    htop
    lazygit
    lsd
    ripgrep
    starship
    tree
    sshpass

    # Fish
    fish
    grc

    # Containerization
    podman
    podman-compose

    # Kubernetes
    my-kubernetes-helm
    my-helmfile
    kompose
    kubectl
    hubble
    fluxcd

  ];

  programs = {
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = pkgs.lib.importTOML "${cfg}/starship/starship.toml";
    };
    fzf = {
      enable = true;
    };
    wezterm = {
      enable = true;
      extraConfig = builtins.readFile "${cfg}/wezterm/wezterm.lua";
    };
  };
}
