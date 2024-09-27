{ config, pkgs, ... }:

{
  # Recursive dir nix file sourcing
  imports = [
    ./user
  ];

  home.username = "matt";
  home.homeDirectory = "/home/matt";
  home.stateVersion = "24.05"; # Pls google before changing this

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
  };



  home.file."~/.config/hypr/hyprland.conf".text = ''
    decoration {
      shadow_offset = 0 5
      col.shadow = rgba(00000099)
    }

    $mod = SUPER

    bindm = $mod, mouse:272, movewindow
    bindm = $mod, mouse:273, resizewindow
    bindm = $mod ALT, mouse:272, resizewindow
  '';

}
