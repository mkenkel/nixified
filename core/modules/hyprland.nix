{ pkgs, ... }: {

  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;

  };

    environment.systemPackages = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      fuzzel
      hyprpaper
      hypridle
      hyprlock
      hyprcursor
      kitty
      libnotify
      mako
      qt5.qtwayland
      qt6.qtwayland
      wl-clipboard
      waybar
    ];

}
