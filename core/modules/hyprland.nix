{ pkgs, ... }: {

  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;

  };

    environment.systemPackages = with pkgs; [
      fuzzel
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
      waybar
    ];

}
