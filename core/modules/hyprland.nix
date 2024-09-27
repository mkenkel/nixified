{ inputs, pkgs, ... }: {

  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    environment.systemPackages = with pkgs; [
      hyprpaper
      kitty
      libnotify
      mako
      qt5.qtwayland
      qt6.qtwayland
      swayidle
      swaylock-effects
      wlogout
      wl-clipboard
      wofi
      waybar
    ];
  };

}
