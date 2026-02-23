{ inputs, pkgs, ... }:
{

  home.packages = [
    pkgs.river-classic
    pkgs.rivercarro
    pkgs.vicinae
    pkgs.waybar
  ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "DP-3"
        ];
        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "wlr/taskbar"
        ];
        modules-center = [
          "sway/window"
          "custom/hello-from-waybar"
        ];
        modules-right = [
          "mpd"
          "custom/mymodule#with-css-id"
          "temperature"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        "custom/hello-from-waybar" = {
          format = "hello {}";
          max-length = 40;
          interval = "once";
          exec = pkgs.writeShellScript "hello-from-waybar" ''
            echo "from within waybar"
          '';
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: Source Code Pro;
      }
      window#waybar {
        background: #16191C;
        color: #AAB2BF;
      }
      #workspaces button {
        padding: 0 5px;
      }
    '';
  };

  wayland.windowManager.river = {
    enable = true;
    extraConfig = ''
      riverctl spawn "wlr-randr --output DP-3 --mode 3840x2160@143.962997Hz"
    '';
    settings = {
      border-width = 2;
      declare-mode = [
        "locked"
        "normal"
        "passthrough"
      ];
      focus-follows-cursor = "normal";
      input = {
        pointer-foo-bar = {
          accel-profile = "flat";
          events = true;
          pointer-accel = -0.3;
          tap = false;
        };
      };
      map = {
        normal = {
          "Alt+Shift X" = "spawn 'mylock'";
          "None Print" = "spawn '${pkgs.sway-contrib.grimshot}/bin/grimshot copy area'";
          "Super F" = "toggle-fullscreen";
          "Super J" = "focus-view next";
          "Super K" = "focus-view previous";
          "Super O" = "spawn '${pkgs.swaynotificationcenter}/bin/swaync-client -t'";
          "Super Period" = "focus-output next";
          "Super Q" = "close";
          "Super Space" = "focus-output next";
          "Super T" = "toggle-float";
          "Super Tab" = "spawn 'notify'";
          "Super+Alt H" = "move left 100";
          "Super+Alt J" = "move down 100";
          "Super+Alt K" = "move up 100";
          "Super+Alt L" = "move right 100";
          "Super+Alt+Shift H" = "resize horizontal -100";
          "Super+Alt+Shift J" = "resize vertical 100";
          "Super+Alt+Shift K" = "resize vertical -100";
          "Super+Alt+Shift L" = "resize horizontal 100";
          "Super+Control Space" = "focus-output previous";
          "Super+Control+Shift Space" = "send-to-output previous";
          "Super+Shift 0" = "set-view-tags 2147483647";
          "Super+Shift Comma" = "send-to-output previous";
          "Super+Shift J" = "swap next";
          "Super+Shift K" = "swap previous";
          "Super+Shift Period" = "send-to-output next";
          "Super+Shift Space" = "send-to-output next";

          "Alt M" = "send-layout-cmd rivercarro 'main-location monocle'";
          "Super+Shift H" = "send-layout-cmd rivercarro 'main-count +1'";
          "Super+Shift L" = "send-layout-cmd rivercarro 'main-count -1'";

          "Control+Alt+Shift E" = "exit";
          "Alt D" = "spawn '${pkgs.fuzzel}/bin/fuzzel'";
          "Alt P" = "spawn '${pkgs.pavucontrol}/bin/pavucontrol'";
          "Alt Q" = "close";
          "Alt Return" = "spawn '${pkgs.kitty}/bin/kitty'";

          "Alt+Control H" = "snap left";
          "Alt+Control J" = "snap down";
          "Alt+Control K" = "snap up";
          "Alt+Control L" = "snap right";
        };
      };
      map-pointer = {
        # mouse bindings
        normal = {
          "Alt BTN_LEFT" = "move-view";
          "Alt BTN_RIGHT" = "resize-view";
          "ButtonMiddle" = "toggle-float";
        };
      };
      rule-add = {
        "-app-id" = {
          "'bar'" = "csd";
          "'float*'" = {
            "-title" = {
              "'foo'" = "float";
            };
          };
        };
      };
      set-cursor-warp = "on-output-change";
      set-repeat = "50 300";
      spawn = [
      ];
      xcursor-theme = "someGreatTheme 12";
    };
  };
}
