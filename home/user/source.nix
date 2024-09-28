let cfg = ../config;
in
{
  home.file = {
      ".config/hypr".source = "${cfg}/hypr";
      ".config/alacritty".source = "${cfg}/alacritty";
      ".config/nvim".source = "${cfg}/nvim";
      ".config/fuzzel".source = "${cfg}/fuzzel";
      ".config/mako".source = "${cfg}/mako";
      ".config/wallpaper".source = "${cfg}/wallpaper";
      # ".config/waybar".source = "${cfg}/waybar";
      # ".config/btop".source = "${cfg}/btop";
  };
}
