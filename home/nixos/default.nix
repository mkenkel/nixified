{ config, lib, pkgs, inputs, ... }:
let 
  cfg = ./configs;
  user = "matt";
in
{
  # Recursive dir nix file sourcing
  imports = [
    ../shared
  ];

  # We aren't moving this out - Personal OS'es are fine, however I'll have to find something for work...
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
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
    pkgs.arduino-ide
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
    userName = "mkenkel";
    userEmail = "mattsnoopy2@gmail.com";
  };

### SessionVariables.nix ###

  # Manages your env vars through Home Manager.
  home.sessionVariables = {
	  WLR_NO_HARDWARE_CURSORS = "1"; 
      XCURSOR_SIZE = "32";
    BROWSER = "firefox";
    GTK_USE_PORTAL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    WLR_RENDERER = "vulkan";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };

### Source.nix ###

  home.file = {
      ".config/fuzzel".source = "${cfg}/fuzzel";
      ".config/hypr".source = "${cfg}/hypr";
      ".config/mako".source = "${cfg}/mako";
      ".config/wallpaper".source = "${cfg}/wallpaper";
      ".config/waybar".source = "${cfg}/waybar";
  };
}
