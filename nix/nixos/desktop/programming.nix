{ pkgs, ... }:
{
  home.packages = [
    # pkgs.ansible
    # pkgs.ansible-builder
    # pkgs.ansible-lint
    # pkgs.ansible-navigator
    pkgs.arduino-ide
    pkgs.gcc
    pkgs.gh
    pkgs.gitflow
    pkgs.gnumake
    pkgs.lazygit
    pkgs.lua-language-server
    pkgs.nim
    pkgs.nimble
    pkgs.nimlsp
    pkgs.nodejs
    pkgs.podman
    pkgs.podman-compose
    (pkgs.python311.withPackages (
      ps: with ps; [
        pip
        ansible-core
      ]
    ))
    pkgs.rustup
    pkgs.vim
    pkgs.zsh-autosuggestions
  ];
}
