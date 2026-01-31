{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = ../../../dots;
  u-hm = ../../universal-modules; # universal Home Manager
  user = "matt";
in
{
  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = lib.mkForce "${user}";
  home.homeDirectory = lib.mkForce "/home/${user}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "25.11"; # Please check the release notes before changing

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
  imports = [
    "${u-hm}/fish.nix"
    "${u-hm}/tmux.nix"
  ];

  home.packages = [
    pkgs.ansible
    pkgs.ansible-lint
    pkgs.ansible-navigator
    pkgs.arduino-ide
    pkgs.docker-compose-language-service
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
    # pkgs.podman
    # pkgs.podman-compose
    (pkgs.python312.withPackages (
      ps: with ps; [
        beautifulsoup4
        packaging
        pandas
        selenium
        paramiko
        pip
        pylint
        regex
        requests
        setuptools
        tkinter
      ]
    ))
    pkgs.pyright
    pkgs.rustup
    pkgs.vim
    pkgs.yaml-language-server
    pkgs.zsh-autosuggestions
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
    fuzzel = {
      enable = true;
      settings = {
        main = {
          dpi-aware = "auto";
          use-bold = "yes";
          match-mode = "fzf";
          show-actions = "yes";
          terminal = "foot";
          width = 30;
        };
        border.width = 1;
        border.radius = 10;
      };
    };
    git = {
      enable = true;
      settings = {
        user.name = "mkenkel";
        user.email = "mattsnoopy2@gmail.com";
        credential.helper = "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
      };
    };
    gpg = {
      enable = true;
      # https://support.yubico.com/hc/en-us/articles/4819584884124-Resolving-GPG-s-CCID-conflicts
      scdaemonSettings = {
        disable-ccid = true;
      };

      # https://github.com/drduh/config/blob/master/gpg.conf
      settings = {
        personal-cipher-preferences = "AES256 AES192 AES";
        personal-digest-preferences = "SHA512 SHA384 SHA256";
        personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
        default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
        cert-digest-algo = "SHA512";
        s2k-digest-algo = "SHA512";
        s2k-cipher-algo = "AES256";
        charset = "utf-8";
        fixed-list-mode = true;
        no-comments = true;
        no-emit-version = true;
        keyid-format = "0xlong";
        list-options = "show-uid-validity";
        verify-options = "show-uid-validity";
        with-fingerprint = true;
        require-cross-certification = true;
        no-symkey-cache = true;
        use-agent = true;
        throw-keyids = true;
      };
    };
    mangohud = {
      enable = true;
      enableSessionWide = true;
      # settings = builtins.readFile ("${cfg}/mangohud/mangohud.conf");
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
