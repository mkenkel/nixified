{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Terminal
    vim 
    wget
    neovim
    git
    unzip
    tmux

    # Virtualization/Containerization
    podman
    podman-compose
    qemu
    virtiofsd


  ];
}
