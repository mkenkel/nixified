{ inputs, pkgs, ... }:
{

  home.packages = [
    pkgs.river-classic
    pkgs.rivercarro
    pkgs.vicinae
    pkgs.waybar
    pkgs.waybar-module-music
  ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        output = [
          "DP-3"
        ];
        modules-left = [
          "river/tags"
        ];
        modules-center = [
          "custom/music"
        ];
        modules-right = [
          "tray"
          "pulseaudio"
          "clock"
        ];

        "river/tags" = {
          num-tags = 9;
        };

        tray = {
          spacing = 10;
          icon-size = 20;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰖁 {volume}%";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        clock = {
          format = "{:%I:%M %p}";
          format-alt = "{:%A, %B %d, %Y - %I:%M %p}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            format = {
              months = "<span color='#fad07a'><b>{}</b></span>";
              days = "<span color='#e8e8d3'>{}</span>";
              today = "<span color='#cf6a4c'><b><u>{}</u></b></span>";
            };
          };
        };

        "custom/music" = {
          format = "{}";
          return-type = "json";
          exec = "waybar-module-music";
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
        background: #151515;
        color: #e8e8d3;
      }
      #tags button {
        padding: 0 5px;
        color: #888888;
      }
      #tags button.occupied {
        background: #1f1f1f;
        color: #e8e8d3;
      }
      #tags button.focused {
        background: #597bc5;
        color: #151515;
      }
      #tray {
        padding: 0 10px;
        color: #e8e8d3;
      }
      #pulseaudio {
        padding: 0 10px;
        color: #99ad6a;
      }
      #clock {
        padding: 0 10px;
        color: #8fbfdc;
      }
      #custom-music {
        padding: 0 10px;
        margin: 0 5px;
      }

      #custom-music.playing {
        color: #99ad6a;
        background: #1f1f1f;
      }

      #custom-music.paused {
        color: #fad07a;
        background: #1f1f1f;
      }

      #custom-music.stopped {
        color: #888888;
        background: #1f1f1f;
      }
    '';
  };

  wayland.windowManager.river = {
    enable = true;
    systemd.enable = true;
    systemd.variables = [
      "DISPLAY"
      "WAYLAND_DISPLAY"
      "XDG_SESSION_TYPE"
      "XDG_CURRENT_DESKTOP"
      "XDG_SESSION_DESKTOP"
      "NIXOS_OZONE_WL"
      "XCURSOR_THEME"
      "XCURSOR_SIZE"
    ];
    systemd.extraCommands = [
      "systemctl --user stop river-session.target"
      "systemctl --user start river-session.target"
      "rivercarro -inner-gaps 3 -outer-gaps 3 -no-smart-gaps -per-tag -main-ratio 0.63"
    ];
    extraConfig = ''
      riverctl spawn "wlr-randr --output DP-3 --mode 3840x2160@143.962997Hz --scale 1.25"
    '';
    settings = {
      declare-mode = [
        "locked"
        "normal"
        "passthrough"
      ];
      attach-mode = "top";
      background-color = "0x0b0e0d"; # k tees
      border-color-unfocused = "0xfafef9"; # w tix0
      border-color-focused = "0x007bc0"; # b case0.d
      border-color-urgent = "0xf75f59"; # r shot0
      border-width = 2;
      default-layout = "rivercarro";
      input = {
        pointer-foo-bar = {
          accel-profile = "flat";
          events = true;
          pointer-accel = -0.3;
          tap = false;
        };
      };
      # Keybinds
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
          # Tag bindings (Alt+1-9 to focus tags, Alt+Shift+1-9 to move windows to tags)
          "Alt 1" = "set-focused-tags 1";
          "Alt 2" = "set-focused-tags 2";
          "Alt 3" = "set-focused-tags 4";
          "Alt 4" = "set-focused-tags 8";
          "Alt 5" = "set-focused-tags 16";
          "Alt 6" = "set-focused-tags 32";
          "Alt 7" = "set-focused-tags 64";
          "Alt 8" = "set-focused-tags 128";
          "Alt 9" = "set-focused-tags 256";
          "Alt 0" = "set-focused-tags 2147483647"; # Show all tags

          "Alt+Shift 1" = "set-view-tags 1";
          "Alt+Shift 2" = "set-view-tags 2";
          "Alt+Shift 3" = "set-view-tags 4";
          "Alt+Shift 4" = "set-view-tags 8";
          "Alt+Shift 5" = "set-view-tags 16";
          "Alt+Shift 6" = "set-view-tags 32";
          "Alt+Shift 7" = "set-view-tags 64";
          "Alt+Shift 8" = "set-view-tags 128";
          "Alt+Shift 9" = "set-view-tags 256";
          "Alt+Shift 0" = "set-view-tags 2147483647";

          "Super+Shift Comma" = "send-to-output previous";
          "Super+Shift J" = "swap next";
          "Super+Shift K" = "swap previous";
          "Super+Shift Period" = "send-to-output next";
          "Super+Shift Space" = "send-to-output next";

          # Mod+H and Mod+L to decrease/increase the main ratio of rivercarro
          "Control+Alt H" = "send-layout-cmd rivercarro 'main-ratio -0.025'";
          "Control+Alt L" = "send-layout-cmd rivercarro 'main-ratio +0.025'";

          # Mod+Shift+H and Mod+Shift+L to increment/decrement the main count of rivercarro
          # Is there a way I can see the current count displayed as I'm changing the number????
          "Alt+Shift H" = "send-layout-cmd rivercarro 'main-count +1'";
          "Alt+Shift L" = "send-layout-cmd rivercarro 'main-count -1'";

          # Mod+{Up,Right,Down,Left} to change layout orientation
          "Alt K" = "send-layout-cmd rivercarro 'main-location top'";
          "Alt L" = "send-layout-cmd rivercarro 'main-location right'";
          "Alt J" = "send-layout-cmd rivercarro 'main-location bottom'";
          "Alt H" = "send-layout-cmd rivercarro 'main-location left'";
          # And for monocle
          "Alt M" = "send-layout-cmd rivercarro 'main-location monocle'";
          # Cycle through layout
          "Alt W" = "send-layout-cmd rivercarro 'main-location-cycle left,monocle'";

          "Control+Alt+Shift E" = "exit";
          "Alt D" = "spawn '${pkgs.fuzzel}/bin/fuzzel'";
          "Alt P" = "spawn '${pkgs.pavucontrol}/bin/pavucontrol'";
          "Alt Q" = "close";
          "Alt Return" = "spawn '${pkgs.kitty}/bin/kitty'";

          # "Alt+Control H" = "snap left";
          # "Alt+Control J" = "snap down";
          # "Alt+Control K" = "snap up";
          # "Alt+Control L" = "snap right";
        };
      };
      map-pointer = {
        # mouse bindings
        normal = {
          # "Alt BTN_LEFT" = "move-view";
          # "Alt BTN_RIGHT" = "resize-view";
          # "ButtonMiddle" = "toggle-float";
        };
      };

      # Rules
      rule-add = {
        "-app-id" = {
          "'waybar'" = "ssd";
          "'org.pulseaudio.pavucontrol'" = "float";
          "'firefox'" = "ssd";
          "'steam'" = "ssd";
        };
      };
      set-cursor-warp = "on-output-change";
      focus-follows-cursor = "normal";
      set-repeat = "50 300";
      spawn = [
        "pkill waybar; waybar &"
        ##### "pkill rivercarro; rivercarro -outer-gaps 0 -per-tag &"
        "pkill swaybg; ${pkgs.swaybg}/bin/swaybg -i ~/wallpaper.jpg -m fill &"
      ];
      xcursor-theme = "BreezeX-Dark 45";
    };
  };
}
