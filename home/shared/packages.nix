{ pkgs, ... }: 
{
  ### Packages.nix ###

  # List all user-derived packages within here.
  home.packages = [
    # Development
    pkgs.python3
    pkgs.ansible
    pkgs.ansible-lint
    pkgs.ansible-builder
    pkgs.ansible-navigator
    pkgs.nodejs
    pkgs.cargo
    pkgs.rustc
    pkgs.gnumake
    pkgs.gcc

    # Terminal
    pkgs.lazygit
    pkgs.lsd
    pkgs.starship
    pkgs.alacritty
    pkgs.fastfetch
    pkgs.fzf
    pkgs.zsh
    pkgs.zsh-autosuggestions
    pkgs.tree
    pkgs.ripgrep
    pkgs.htop
    pkgs.btop
    pkgs.bat

    # Containerization
    pkgs.podman
    pkgs.podman-compose
  ];
}
