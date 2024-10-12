{
  config,
  pkgs,
  ...
}:
let
  cfg = ../../../dots;
in
{

  home = {
    enableNixpkgsReleaseCheck = false;
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;

  home.file = {
    ".config/alacritty".source = "${cfg}/alacritty";
    ".config/nvim".source = "${cfg}/nvim";
    ".config/fastfetch".source = "${cfg}/fastfetch";
  };

  home.sessionVariables = {
    # Fixes Rust Compiling the LSP
    PATH = "/usr/bin/:$PATH";
    EDITOR = "nvim";
    TERM = "xterm-256color";
  };

  home.packages = [
    # Editors
    pkgs.neovim
    pkgs.vim

    # Development
    pkgs.ansible
    pkgs.ansible-builder
    pkgs.ansible-lint
    pkgs.ansible-navigator
    pkgs.gcc
    pkgs.gnumake
    pkgs.nodejs
    pkgs.python3
    pkgs.rustup

    # Git
    pkgs.gh
    pkgs.gitflow

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

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      history = {
        save = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      shellAliases = {
        "vi" = "nvim";
        "ls" = "lsd";
        "TERM" = "xterm-256color";
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = pkgs.lib.importTOML "${cfg}/starship/starship.toml";
    };
    fzf = {
      enable = true;
    };
    tmux = {
      enable = true;
      escapeTime = 0;
      plugins = with pkgs; [
        tmuxPlugins.continuum
        tmuxPlugins.resurrect
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.catppuccin
      ];

      # https://nix.dev/manual/nix/2.18/language/builtins.html?highlight=readFile#built-in-functions
      extraConfig = builtins.readFile ("${cfg}/tmux/tmux.conf");
    };
  };
}
