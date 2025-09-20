{ inputs, pkgs, ... }:
{

  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;
    programs.river.extraConfig = ''
      # Set default terminal (example: foot)
      set-terminal kitty

      # Monitor Configuration
      exec wlr-randr --output HDMI-A-1 --mode 1920x1080@144.00Hz

      # Example keybindings
      bindsym Mod1+Return spawn kitty
      bindsym Mod1+Q close
      bindsym Mod1+Shift+Q exit
      bindsym Mod1+J focus next
      bindsym Mod1+K focus prev
      bindsym Mod1+H send-layout-msg main-ratio -0.05
      bindsym Mod1+L send-layout-msg main-ratio +0.05
      bindsym Mod1+Space send-layout-msg cycle-layout
    '';

  };
}
