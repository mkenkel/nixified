{ inputs, pkgs, ... }:
{
  nix.settings = {
    # Cachix for Hyprland
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.banana-cursor;
    size = 48;
    name = "banana-cursor";
  };

  home.packages = [
    pkgs.catppuccin-cursors.mochaMauve
    pkgs.banana-cursor
    pkgs.fuzzel
    pkgs.hyprcursor
    pkgs.hypridle
    pkgs.hyprlock
    pkgs.hyprpaper
    pkgs.kitty
    pkgs.libnotify
    pkgs.mako
    pkgs.waybar
    pkgs.wl-clipboard
  ];

  home.sessionVariables = {
    HYPRCURSOR_SIZE = "48";
    HYPRCURSOR_THEME = "banana-cursor";
    XCURSOR_THEME = "banana-cursor";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    catppuccin.enable = true;
    plugins = [ inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors ];
    xwayland = {
      enable = true;
    };

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    settings = {
      "$terminal" = "alacritty";
      "$mod" = "ALT";
      "$wrkspcmod" = "ALT CONTROL";
      "$menu" = "${pkgs.fuzzel}/bin/fuzzel";

      monitor = [
        "DP-1,3840x2160@144,0x0,1"
        ",prefered,auto,1"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      general = {
        gaps_in = 6;
        gaps_out = 6;
        border_size = 2;
        layout = "dwindle";
        allow_tearing = true;
      };

      input = {
        kb_layout = "us";
        follow_mouse = true;
        touchpad = {
          natural_scroll = true;
        };
        accel_profile = "flat";
        sensitivity = 0;
        repeat_delay = 200;
        repeat_rate = 50;
      };

      decoration = {
        rounding = 15;
        active_opacity = 0.9;
        inactive_opacity = 0.8;
        fullscreen_opacity = 0.9;

        blur = {
          enabled = true;
          xray = true;
          special = false;
          new_optimizations = true;
          size = 14;
          passes = 4;
          brightness = 1;
          noise = 1.0e-2;
          contrast = 1;
          popups = true;
          popups_ignorealpha = 0.6;
          ignore_opacity = false;
        };

        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_range = 20;
        shadow_offset = "0 2";
        shadow_render_power = 4;
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "layersIn, 1, 3, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      cursor = {
        enable_hyprcursor = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_split = false;
        smart_resizing = false;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      bind = [
        # General
        "$mod, return, exec, $terminal"
        "$mod, q, killactive"
        "$mod SHIFT CONTROL, e, exit"
        "$mod SHIFT, l, exec, ${pkgs.hyprlock}/bin/hyprlock"
        "$mod, d, exec, $menu"

        # Screen focus
        "$mod, v, togglefloating"
        "$mod, u, focusurgentorlast"
        "$mod, tab, focuscurrentorlast"
        "$mod, f, fullscreen"

        # Screen resize
        "$mod CTRL, h, resizeactive, -20 0"
        "$mod CTRL, l, resizeactive, 20 0"
        "$mod CTRL, k, resizeactive, 0 -20"
        "$mod CTRL, j, resizeactive, 0 20"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move to workspaces
        "$mod SHIFT, 1, movetoworkspace,1"
        "$mod SHIFT, 2, movetoworkspace,2"
        "$mod SHIFT, 3, movetoworkspace,3"
        "$mod SHIFT, 4, movetoworkspace,4"
        "$mod SHIFT, 5, movetoworkspace,5"
        "$mod SHIFT, 6, movetoworkspace,6"
        "$mod SHIFT, 7, movetoworkspace,7"
        "$mod SHIFT, 8, movetoworkspace,8"
        "$mod SHIFT, 9, movetoworkspace,9"
        "$mod SHIFT, 0, movetoworkspace,10"

        # Navigation
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # Relative navigation
        "$wrkspcmod, l, workspace, r+1"
        "$wrkspcmod, h, workspace, r-1"

        # Clipboard
        "$mod SHIFT, v, exec, pkill fuzzel || cliphist list | fuzzel --no-fuzzy --dmenu | cliphist decode | wl-copy"

        # Screencapture
        "$mod SHIFT, S, exec, ${pkgs.grim}/bin/grim -g \"$(slurp)\" - | wl-copy"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      env = [
        "NIXOS_OZONE_WL,1"
        "_JAVA_AWT_WM_NONREPARENTING,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORM,wayland"
        "SDL_VIDEODRIVER,wayland"
        "GDK_BACKEND,wayland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XCURSOR_THEME,banana-cursor"
        "HYPRCURSOR_THEME,banana-cursor"
        "HYPRCURSOR_SIZE,48"
      ];
      exec-once = [
        "dbus-update-activation-environment --systemd --all"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "hyprctl setcursor banana-cursor 48"
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.hypridle}/bin/hypridle"
        "${pkgs.waybar}/bin/waybar"
      ];

      plugin = {
        dynamic-cursors = {
          enabled = false;
          mode = "stretch";
          threshold = 2;
          rotate = {
            length = 20;
            offset = 0.0;
          };
          tilt = {
            limit = 5000;
            function = "negative_quadratic";
          };
          stretch = {
            limit = 3000;
            function = "quadratic";
          };
          shake = {
            enabled = true;
            nearest = true;
            threshold = 6.0;
            base = 4.0;
            speed = 4.0;
            influence = 0.0;
            limit = 0.0;
            timeout = 2000;
            effects = false;
            ipc = false;
          };
        };
      };
    };
    systemd = {
      enable = true;
    };
  };
}
