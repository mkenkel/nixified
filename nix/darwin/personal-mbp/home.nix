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
    #    ".config/nvim".source = "${cfg}/nvim";
  };

  home.sessionVariables = {
    # Fixes Rust Compiling the LSP
    PATH = "/usr/bin/:$PATH";
    TERM = "xterm-256color";
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    alacritty
    ansible
    ansible-language-server
    ansible-lint
    bat
    bicep
    btop
    cilium-cli
    deno
    dotnet-sdk
    fastfetch
    fish
    fluxcd
    fzf
    gcc
    gh
    git-lfs
    gitflow
    gnumake
    go
    grc
    htop
    hubble
    json2yaml
    kompose
    krew
    kubectl
    kubevirt
    lazygit
    luajit
    lsd
    lua-language-server
    mark
    my-helmfile
    my-kubernetes-helm
    nil
    nodejs
    packer
    pandoc
    podman
    podman-bootc
    podman-compose
    putty
    qemu
    ripgrep
    rustup
    sshpass
    starship
    terraform
    terraform-ls
    tree
    vim
    realvnc-vnc-viewer
    yaml-language-server
    yamlfmt
    yamllint
    (python311.withPackages (
      p: with p; [
        pip
        packaging
        ansible-builder
      ]
    ))
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
