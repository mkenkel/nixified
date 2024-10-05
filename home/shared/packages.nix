{ pkgs, ... }: 
{
  ### Packages.nix ###

  # List all user-derived packages within here.
  home.packages = [
    # Editors
    pkgs.neovim
    pkgs.vim

    # Development
    pkgs.ansible
    pkgs.ansible-builder
    pkgs.ansible-lint
    pkgs.ansible-navigator
    pkgs.cargo
    pkgs.gcc
    pkgs.gnumake
    pkgs.nodejs
    pkgs.python3
    pkgs.rustc

    # Terminal
    pkgs.alacritty
    pkgs.bat
    pkgs.btop
    pkgs.fastfetch
    pkgs.fzf
    pkgs.htop
    pkgs.lazygit
    pkgs.lsd
    pkgs.ripgrep
    pkgs.starship
    pkgs.tree
    pkgs.zsh
    pkgs.zsh-autosuggestions

    # Containerization
    pkgs.podman
    pkgs.podman-compose
  ];
}
