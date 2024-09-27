{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim 
    wget
    neovim
    git
  ];
}
