{ config, lib, pkgs, inputs, ... }:
let 
  cfg = ./configs;
in
{
  # Recursive dir nix file sourcing
  imports = [
    ../shared
  ];

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

  # Making sure these are NixOS-specific.
  home.packages = [
    # Desktop Configuration
    pkgs.nwg-look
    # Desktop Apps
    pkgs.obsidian
    pkgs.firefox
    pkgs.spotify
    pkgs.vesktop
    # Terminal
    pkgs.cmatrix
    pkgs.brightnessctl
    pkgs.grim
    pkgs.slurp
    pkgs.playerctl
  ];

### Programs.nix ###

  # Moreso personal account here - Dunno if this'll go any higher than NixOS.
  programs.git = {
    enable = true;
    userName = "whipplash";
    userEmail = "mattsnoopy2@gmail.com";
  };

### SessionVariables.nix ###

  # Manages your env vars through Home Manager.
  home.sessionVariables = {
    BROWSER = "firefox";
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

### Source.nix ###

  home.file = {
      ".config/hypr".source = "${cfg}/hypr";
      ".config/fuzzel".source = "${cfg}/fuzzel";
      ".config/mako".source = "${cfg}/mako";
      ".config/wallpaper".source = "${cfg}/wallpaper";
      ".config/waybar".source = "${cfg}/waybar";
  };
}
