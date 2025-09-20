{ inputs, pkgs, ... }:
{

  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      # Monitor Configuration
      exec wlr-randr --output DP-3 --mode 3840x2160@144.00Hz

      # Example keybindings
      bindsym Mod1+Return spawn kitty
      bindsym Mod1+D spawn fuzzel 
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
