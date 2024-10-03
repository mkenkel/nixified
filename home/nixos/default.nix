{ config, lib, pkgs, inputs, ... }:
let 
  cfg = ../config;
in
{
  home.username = "matt";
  home.homeDirectory = "/home/matt";
  home.stateVersion = "24.05"; # Pls google before changing this

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

### Desktop-env.nix ###

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };

### Packages.nix ###

  # Allows you to install Nix packages into your env.
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

    # Desktop Configuration
    pkgs.nwg-look

    # Desktop Apps
    pkgs.obsidian
    pkgs.firefox
    pkgs.spotify
    pkgs.vesktop

    # Terminal
    pkgs.cmatrix
    pkgs.lazygit
    pkgs.lsd
    pkgs.starship
    pkgs.alacritty
    pkgs.fastfetch
    pkgs.brightnessctl
    pkgs.fzf
    pkgs.zsh
    pkgs.zsh-autosuggestions
    pkgs.tree
    pkgs.ripgrep
    pkgs.htop
    pkgs.btop
    pkgs.grim
    pkgs.slurp
    pkgs.playerctl
    pkgs.bat

  ];

### Programs.nix ###

  programs.git = {
    enable = true;
    userName = "whipplash";
    userEmail = "mattsnoopy2@gmail.com";
  };

### SessionVariables.nix ###

  # Manages your env vars through Home Manager.
  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "nvim";
    TERM = "alacritty";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    GTK_USE_PORTAL = "1";
    WLR_RENDERER = "vulkan";
      XCURSOR_SIZE = "32";
	  WLR_NO_HARDWARE_CURSORS = "1"; 
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_DATA_HOME = "\${HOME}/.local/share";
  };

### Shell.nix ###

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
  };

### Source.nix ###

  home.file = {
      ".config/hypr".source = "${cfg}/hypr";
      ".config/alacritty".source = "${cfg}/alacritty";
      ".config/nvim".source = "${cfg}/nvim";
      ".config/fuzzel".source = "${cfg}/fuzzel";
      ".config/mako".source = "${cfg}/mako";
      ".config/wallpaper".source = "${cfg}/wallpaper";
      ".config/waybar".source = "${cfg}/waybar";
      # ".config/btop".source = "${cfg}/btop";
  };
}
