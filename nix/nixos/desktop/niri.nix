{ inputs, pkgs, ... }:
{

  home.packages = with pkgs; [
    brightnessctl
    cliphist
    fuzzel
    glib
    libnotify
    mako
    swaybg
    swaylock-effects
    waybar
    waybar-module-music
    wl-clipboard
    wlr-randr
  ];

  services = {
    swayidle = {
      enable = false;
      events.before-sleep = "${pkgs.swaylock-effects}/bin/swaylock";
      events.lock = "${pkgs.swaylock-effects}/bin/swaylock";
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.swaylock-effects}/bin/swaylock";
        }
      ];
    };
  };

  # Configure swaylock
  programs.swaylock = {
    enable = false;
    package = pkgs.swaylock-effects;
    settings = {
      daemonize = true;
      clock = true;
      timestr = "%k:%M";
      datestr = "%Y-%m-%d";
      show-failed-attempts = true;
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        spacing = 5;
        output = [
          "DP-3"
        ];
        modules-left = [
          "niri/workspaces"
          "custom/music"
          "pulseaudio"
        ];
        modules-center = [
          "niri/window"
          "clock"
        ];
        modules-right = [
          "tray"
        ];

        "niri/workspaces" = {
          format = "{icon}";
        };

        "niri/window" = {
          format = "{title}";
          max-length = 50;
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
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 5px;
        font-family: Source Code Pro;
      }
      window#waybar {
        background: transparent;
        color: #e8e8d3;
      }
      #workspaces {
        background: #151515;
        border: 1px solid #1f1f1f;
        margin: 5px;
        padding: 2px;
      }
      #workspaces button {
        padding: 0 5px;
        color: #888888;
        border-radius: 3px;
      }
      #workspaces button.active {
        background: #597bc5;
        color: #151515;
      }
      #window {
        background: #151515;
        border: 1px solid #1f1f1f;
        margin: 5px;
        padding: 0 10px;
        color: #e8e8d3;
      }
      #tray {
        background: #151515;
        border: 1px solid #1f1f1f;
        padding: 0 10px;
        margin: 5px;
        color: #e8e8d3;
      }
      #pulseaudio {
        background: #151515;
        border: 1px solid #1f1f1f;
        padding: 0 10px;
        margin: 5px;
        color: #99ad6a;
      }
      #clock {
        background: #151515;
        border: 1px solid #1f1f1f;
        padding: 0 10px;
        margin: 5px;
        color: #8fbfdc;
      }
      #custom-music {
        padding: 0 10px;
        margin: 5px;
      }
      #custom-music.playing {
        color: #6fcf97;
        background: #151515;
        border: 1px solid #1f1f1f;
      }
      #custom-music.paused {
        color: #fad07a;
        background: #151515;
        border: 1px solid #1f1f1f;
      }
      #custom-music.stopped {
        color: #888888;
        background: #151515;
        border: 1px solid #1f1f1f;
      }
    '';
  };

  wayland.windowManager.niri = {
    enable = true;
    package = pkgs.niri;
    systemd.enable = true;
    systemd.variables = [
      "DISPLAY"
      "GDK_BACKEND,wayland"
      "NIXOS_OZONE_WL,1"
      "QT_QPA_PLATFORM,wayland"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "SDL_VIDEODRIVER,wayland"
      "WAYLAND_DISPLAY"
      "XCURSOR_SIZE"
      "XCURSOR_THEME"
      "XDG_CURRENT_DESKTOP,niri"
      "XDG_SESSION_DESKTOP,niri"
      "XDG_SESSION_TYPE,wayland"
    ];

    settings = {
      input = {
        keyboard.xkb = {
          layout = "us";
        };
        touchpad = {
          tap = false;
          natural-scroll = true;
        };
        mouse = {
          accel-profile = "flat";
          accel-speed = -0.3;
        };
        focus-follows-mouse = { };
        warp-mouse-to-focus = { };
      };

      outputs."DP-3" = {
        mode = {
          width = 3840;
          height = 2160;
          refresh = 143.962997;
        };
        scale = 1.25;
      };

      layout = {
        gaps = 6;
        center-focused-column = "never";
        default-column-width = {
          proportion = 0.63;
        };
        preset-column-widths._children = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];
        focus-ring = {
          width = 2;
          active.color = "#007bc0"; # b case0.d
          inactive.color = "#fafef9"; # w tix0
        };
        border.enable = false;
      };

      prefer-no-csd = { };

      cursor = {
        xcursor-theme = "Posy_Cursor_125_175";
        xcursor-size = 48;
      };

      hotkey-overlay.skip-at-startup = true;

      spawn-at-startup = [
        {
          command = [
            "${pkgs.swaybg}/bin/swaybg"
            "-i"
            "/home/matt/wallpaper.jpg"
            "-m"
            "fill"
          ];
        }
        { command = [ "${pkgs.waybar}/bin/waybar" ]; }
      ];

      window-rules = [
        {
          matches = [ { app-id = "^org\\.pulseaudio\\.pavucontrol$"; } ];
          open-floating = true;
        }
      ];

      # Keybinds - modelled after river.nix's Alt/Super conventions
      binds = {
        "Mod+Return".spawn = "${pkgs.kitty}/bin/kitty";
        "Mod+D".spawn = "${pkgs.fuzzel}/bin/fuzzel";
        "Mod+Tab".spawn = [ "notify" ];
        "Mod+O".spawn = [
          "${pkgs.swaynotificationcenter}/bin/swaync-client"
          "-t"
        ];

        "Mod+Q".close-window = { };
        "Mod+F".fullscreen-window = { };
        "Mod+V".toggle-window-floating = { };

        "Mod+J".focus-window-down = { };
        "Mod+K".focus-window-up = { };
        "Mod+H".focus-column-left = { };
        "Mod+L".focus-column-right = { };

        "Mod+Shift+J".move-window-down = { };
        "Mod+Shift+K".move-window-up = { };
        "Mod+Shift+H".move-column-left = { };
        "Mod+Shift+L".move-column-right = { };

        "Mod+Alt+H".set-column-width = "-10%";
        "Mod+Alt+L".set-column-width = "+10%";
        "Mod+Alt+J".set-window-height = "-10%";
        "Mod+Alt+K".set-window-height = "+10%";

        "Alt+N".consume-or-expel-window-right = { };
        "Alt+P".consume-or-expel-window-left = { };
        "Alt+W".switch-preset-column-width = { };
        "Alt+M".maximize-column = { };

        "Mod+1".focus-workspace = 1;
        "Mod+2".focus-workspace = 2;
        "Mod+3".focus-workspace = 3;
        "Mod+4".focus-workspace = 4;
        "Mod+5".focus-workspace = 5;
        "Mod+6".focus-workspace = 6;
        "Mod+7".focus-workspace = 7;
        "Mod+8".focus-workspace = 8;
        "Mod+9".focus-workspace = 9;

        "Mod+Shift+1".move-column-to-workspace = 1;
        "Mod+Shift+2".move-column-to-workspace = 2;
        "Mod+Shift+3".move-column-to-workspace = 3;
        "Mod+Shift+4".move-column-to-workspace = 4;
        "Mod+Shift+5".move-column-to-workspace = 5;
        "Mod+Shift+6".move-column-to-workspace = 6;
        "Mod+Shift+7".move-column-to-workspace = 7;
        "Mod+Shift+8".move-column-to-workspace = 8;
        "Mod+Shift+9".move-column-to-workspace = 9;

        "Mod+Period".focus-monitor-next = { };
        "Mod+Comma".focus-monitor-previous = { };
        "Mod+Shift+Period".move-column-to-monitor-next = { };
        "Mod+Shift+Comma".move-column-to-monitor-previous = { };

        "Alt+Shift+S".spawn = [
          "sh"
          "-c"
          "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy"
        ];
        "Alt+Shift+H".spawn = [
          "sh"
          "-c"
          "pkill fuzzel || ${pkgs.cliphist}/bin/cliphist list | ${pkgs.fuzzel}/bin/fuzzel --no-fuzzy --dmenu | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy"
        ];
        "Alt+Escape".spawn = "${pkgs.swaylock-effects}/bin/swaylock";

        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "5%+"
          ];
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "5%-"
          ];
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ];
        };
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          spawn = [
            "${pkgs.brightnessctl}/bin/brightnessctl"
            "set"
            "5%+"
          ];
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          spawn = [
            "${pkgs.brightnessctl}/bin/brightnessctl"
            "set"
            "5%-"
          ];
        };

        "Mod+Ctrl+Shift+E".quit = { };
      };
    };
  };
}
