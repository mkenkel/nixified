{pkgs, ...}: {
  programs.niri = {
    package = pkgs.niri-unstable;
    enable = true;
    settings = {
      outputs = {
        "DP-3" = {
          scale = 1.25;
          mode = {
            width = 3840;
            height = 2160;
            refresh = 143.962997;
          };
        };
      };

      # Keybinds
      # https://github.com/sodiboo/niri-flake/blob/main/docs.md#overlaysniri
      binds = {
        # Spawning apps / utilities
        "Alt+Shift+X".action.spawn = "mylock";
        "Alt+Shift+S".action.spawn-sh = ''grim -g "$(slurp)" - | wl-copy'';
        "Alt+Escape".action.spawn = "${pkgs.swaylock-effects}/bin/swaylock";
        "Super+Tab".action.spawn = "notify";
        "Super+O".action.spawn = "${pkgs.swaynotificationcenter}/bin/swaync-client";
        "Alt+D".action.spawn = "${pkgs.fuzzel}/bin/fuzzel";
        "Alt+Shift+P".action.spawn = "${pkgs.pavucontrol}/bin/pavucontrol";
        "Alt+Return".action.spawn = "${pkgs.kitty}/bin/kitty";
        "Alt+Shift+H".action.spawn-sh = "pkill fuzzel || cliphist list | fuzzel --no-fuzzy --dmenu | cliphist decode | wl-copy"; # Not working yet
        "Alt+C".action.spawn-sh = "cat ~/.config/river/init | grep -i map | sed -e 's/riverctl//g' -e 's/map//g' -e 's/normal//g' | fuzzel --cache \"($XDG_CACHE_HOME/unicode)\" -w 100 --horizontal-pad 20 -di) || exit 0"; # Not working yet

        # Window management
        "Super+F".action.fullscreen-window = {};
        "Super+Q".action.close-window = {};
        "Alt+Q".action.close-window = {};
        "Super+T".action.toggle-window-floating = {};
        "Alt+M".action.maximize-column = {};
        "Alt+W".action.switch-preset-column-width = {};

        # Focus movement (next/previous view -> focus window down/up)
        "Super+J".action.focus-window-down = {};
        "Super+K".action.focus-window-up = {};
        "Alt+N".action.move-window-down = {}; # swap next
        "Alt+P".action.move-window-up = {}; # swap previous

        # Move window / column with a modifier
        "Super+Alt+H".action.move-column-left = {};
        "Super+Alt+J".action.move-window-down = {};
        "Super+Alt+K".action.move-window-up = {};
        "Super+Alt+L".action.move-column-right = {};

        # Resize window / column
        "Super+Alt+Shift+H".action.set-column-width = "-10%";
        "Super+Alt+Shift+J".action.set-window-height = "+10%";
        "Super+Alt+Shift+K".action.set-window-height = "-10%";
        "Super+Alt+Shift+L".action.set-column-width = "+10%";
        "Control+Alt+H".action.set-column-width = "-5%";
        "Control+Alt+L".action.set-column-width = "+5%";

        # Output (monitor) focus / move (river had no true "next/previous"
        # concept here besides left/right; mapped onto niri's directional actions)
        "Super+Period".action.focus-monitor-right = {};
        "Super+Space".action.focus-monitor-right = {};
        "Super+Control+Space".action.focus-monitor-left = {};
        "Super+Control+Shift+Space".action.move-column-to-monitor-left = {};
        "Super+Shift+Comma".action.move-column-to-monitor-left = {};
        "Super+Shift+Period".action.move-column-to-monitor-right = {};
        "Super+Shift+Space".action.move-column-to-monitor-right = {};

        # Workspace bindings (river used bitmask tags F1-F9;
        # niri workspaces are indexed 1-9 instead)
        "F1".action.focus-workspace = 1;
        "F2".action.focus-workspace = 2;
        "F3".action.focus-workspace = 3;
        "F4".action.focus-workspace = 4;
        "F5".action.focus-workspace = 5;
        "F6".action.focus-workspace = 6;
        "F7".action.focus-workspace = 7;
        "F8".action.focus-workspace = 8;
        "F9".action.focus-workspace = 9;

        "Shift+F1".action.move-window-to-workspace = 1;
        "Shift+F2".action.move-window-to-workspace = 2;
        "Shift+F3".action.move-window-to-workspace = 3;
        "Shift+F4".action.move-window-to-workspace = 4;
        "Shift+F5".action.move-window-to-workspace = 5;
        "Shift+F6".action.move-window-to-workspace = 6;
        "Shift+F7".action.move-window-to-workspace = 7;
        "Shift+F8".action.move-window-to-workspace = 8;
        "Shift+F9".action.move-window-to-workspace = 9;

        # Quit / exit
        "Control+Alt+Shift+E".action.quit = {};
      };
    };
  };
}
