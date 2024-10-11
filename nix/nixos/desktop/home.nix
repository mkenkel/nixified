{
  config,
  pkgs,
  ...
}:
let
  cfg = ../../../dots;
  user = "matt";
in
{
  # We aren't moving this out - Personal OS'es are fine, however I'll have to find something for work...
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "24.05"; # Pls google before changing this

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  ### Desktop-env.nix ###

  home.packages = [
    pkgs.alacritty
    pkgs.ansible
    pkgs.ansible-builder
    pkgs.ansible-lint
    pkgs.ansible-navigator
    pkgs.arduino-ide
    pkgs.bat
    pkgs.brightnessctl
    pkgs.btop
    pkgs.cmatrix
    pkgs.fastfetch
    pkgs.firefox
    pkgs.fzf
    pkgs.gcc
    pkgs.gh
    pkgs.gitflow
    pkgs.gnumake
    pkgs.grim
    pkgs.htop
    pkgs.lazygit
    pkgs.lsd
    pkgs.neovim
    pkgs.nodejs
    pkgs.nwg-look
    pkgs.obsidian
    pkgs.playerctl
    pkgs.podman
    pkgs.podman-compose
    pkgs.python3
    pkgs.ripgrep
    pkgs.rustup
    pkgs.slurp
    pkgs.spotify
    pkgs.starship
    pkgs.tree
    pkgs.vesktop
    pkgs.vim
    pkgs.zsh
    pkgs.zsh-autosuggestions
  ];

  # Moreso personal account here - Dunno if this'll go any higher than NixOS.

  # Manages your env vars through Home Manager.
  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "nvim";
    GTK_USE_PORTAL = "1";
    #MOZ_ENABLE_WAYLAND = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    TERM = "xterm-256color";
    #WLR_NO_HARDWARE_CURSORS = "1";
    #WLR_RENDERER = "vulkan";
    XCURSOR_SIZE = "32";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    #XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    #XDG_SESSION_DESKTOP = "Hyprland";
    #XDG_SESSION_TYPE = "wayland";
  };

  ### Source.nix ###

  home.file = {
    ".config/fuzzel".source = "${cfg}/fuzzel";
    ".config/hypr".source = "${cfg}/hypr";
    ".config/mako".source = "${cfg}/mako";
    ".config/wallpaper".source = "${cfg}/wallpaper";
    ".config/waybar".source = "${cfg}/waybar";
    ".config/alacritty".source = "${cfg}/alacritty";
    ".config/nvim".source = "${cfg}/nvim";
    ".config/fastfetch".source = "${cfg}/fastfetch";
  };

  programs = {
    git = {
      enable = true;
      userName = "mkenkel";
      userEmail = "mattsnoopy2@gmail.com";
    };
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
        tmuxPlugins.onedark-theme
        tmuxPlugins.resurrect
        tmuxPlugins.vim-tmux-navigator
      ];

      extraConfig = ''
        set -g default-terminal "xterm-256color"
        set -g prefix C-a
        unbind C-b
        bind-key C-a send-prefix

        unbind %
        bind | split-window -h

        unbind '"'
        bind - split-window -v

        unbind r
        bind r source-file ~/.tmux.conf

        bind -r j resize-pane -D 5
        bind -r k resize-pane -U 5
        bind -r l resize-pane -R 5
        bind -r h resize-pane -L 5

        bind -r m resize-pane -Z

        set -g mouse on

        set-window-option -g mode-keys vi


        # Copy mode vi
        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-selection

        unbind -T copy-mode-vi MouseDragEnd1Pane

        # Pane sync / Mult-SSH Session Sync
        bind-key b set-window-option synchronize-panes\; display-message "synchronize-panes is now #{?pane_synchronized,on,off}"

      '';
    };
  };
}
