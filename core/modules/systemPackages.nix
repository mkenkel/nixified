{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim 
    wget
    neovim
    git
    unzip
    podman
    podman-compose
    tmux
    qemu
  ];
}
