let cfg = ../config;
in
{
  home.file = {
      ".config/hypr".source = "${cfg}/hypr";
      ".config/alacritty".source = "${cfg}/alacritty";
      ".config/nvim".source = "${cfg}/nvim";
      ".config/fuzzel".source = "${cfg}/fuzzel";
      # ".config/neofetch".source = "${cfg}/neofetch";
      # ".config/swayidle".source = "${cfg}/swayidle";
      # ".config/swaylock".source = "${cfg}/swaylock";
      # ".config/wlogout".source = "${cfg}/wlogout";
      # ".config/waybar".source = "${cfg}/waybar";
      # ".config/btop".source = "${cfg}/btop";
      # ".config/wofi".source = "${cfg}/wofi";
      # ".config/mako".source = "${cfg}/mako";
  };
}
