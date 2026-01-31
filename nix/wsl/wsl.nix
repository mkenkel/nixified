{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  user = "matt";
  hostname = "updog";
  nos = ./../modules; # NixOS
  universal = ./../../universal-modules; # Cross-platform modules
in
{
  # Define the user account
  wsl.defaultUser = "matt";
  users.users.matt = {
    isNormalUser = true;
    home = "/home/matt";
    group = "matt";
    uid = 1001; # Add this line
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # wheel gives sudo access
    shell = pkgs.fish; # or pkgs.zsh, pkgs.fish, etc.
  };

  users.groups.matt = { };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "25.05";
  wsl.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs = {
    zsh.enable = true;
    fish.enable = true;
  };

  environment.systemPackages = with pkgs; [
    age
    bashSnippets
    bottles
    cilium-cli
    curl
    envsubst
    fluxcd
    fzf
    git
    glibc
    glibc_multi
    google-chrome
    go
    gopls
    grc
    helm-ls
    hubble
    json2yaml
    kompose
    kube-linter
    kubectl
    kustomize
    lua-language-server
    lua5_1
    luajit
    lsd
    neovim
    nfs-utils
    nixfmt
    openssl
    pa-notify
    packer
    paperkey
    pavucontrol # Lets you disable inputs/outputs, can help if game auto-connects to bad IOs
    pipecontrol
    podman
    podman-compose
    pw-volume
    pwvucontrol
    qemu
    qpwgraph # Lets you view pipewire graph and connect IOs
    rtaudio
    slack
    sshpass
    taplo
    terraform
    terraform-ls
    tftp-hpa
    timoni
    unzip
    unzip # Used by patch-nixos.sh
    vim
    virtiofsd
    vlc
    vscode
    vscodium
    waybar
    wget
    wineWowPackages.stable
    wineWowPackages.waylandFull
    winetricks
    wl-clipboard
    yazi
  ];
}
