{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Terminal
    git
    neovim
    tmux
    unzip
    vim
    wget
  ];
}
