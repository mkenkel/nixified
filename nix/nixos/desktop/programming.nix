{ pkgs, ... }:
{
  home.packages = [
    pkgs.ansible
    pkgs.ansible-lint
    pkgs.ansible-navigator
    pkgs.ansible-language-server
    pkgs.arduino-ide
    pkgs.cue
    pkgs.gcc
    pkgs.gh
    pkgs.gitflow
    pkgs.gnumake
    pkgs.lazygit
    pkgs.lua-language-server
    pkgs.kubectl
    pkgs.nim
    pkgs.nimble
    pkgs.nil
    pkgs.nimlsp
    pkgs.nodejs
    pkgs.podman
    pkgs.podman-compose
    (pkgs.python311.withPackages (
      ps: with ps; [
        pip
        packaging
        ansible-builder
      ]
    ))
    pkgs.rustup
    pkgs.vim
    pkgs.yaml-language-server
    pkgs.zsh-autosuggestions
  ];
}
