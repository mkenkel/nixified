{
  config,
  inputs,
  pkgs,
  ...
}:
let
  cfg = ../../../dots;
  user = "matt";
in
{
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "24.05"; # Pls google before changing this

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Cachix for Hyprland
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  home.packages = [
    pkgs.alacritty
    pkgs.alacritty-theme
    pkgs.ansible
    pkgs.ansible-builder
    pkgs.ansible-lint
    pkgs.ansible-navigator
    pkgs.arduino-ide
    pkgs.bat
    pkgs.brightnessctl
    pkgs.btop
    pkgs.cmatrix
    pkgs.fastfetch
    pkgs.firefox
    pkgs.fzf
    pkgs.gcc
    pkgs.gh
    pkgs.gitflow
    pkgs.gnumake
    pkgs.grim
    pkgs.htop
    pkgs.lazygit
    pkgs.lsd
    pkgs.neovim
    pkgs.nodejs
    pkgs.nwg-look
    pkgs.obsidian
    pkgs.playerctl
    pkgs.podman
    pkgs.podman-compose
    pkgs.python3
    pkgs.ripgrep
    pkgs.rustup
    pkgs.slurp
    pkgs.spotify
    pkgs.starship
    pkgs.tree
    pkgs.vesktop
    pkgs.vim
    pkgs.zsh
    pkgs.zsh-autosuggestions
    # Goddamn
    pkgs.catppuccin-cursors.mochaMauve
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

  # Manages your env vars through Home Manager.
  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "nvim";
    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    TERM = "xterm-256color";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    HYPRCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Catppuccin-Mocha-Mauve";
    XCURSOR_SIZE = "24";
    XCURSOR_THEME = "Catppuccin-Mocha-Mauve";
  };

  home.file = {
    ".config/alacritty".source = "${cfg}/alacritty";
    ".config/fastfetch".source = "${cfg}/fastfetch";
    ".config/fuzzel".source = "${cfg}/fuzzel";
    #".config/hypr".source = "${cfg}/hypr";
    ".config/mako".source = "${cfg}/mako";
    ".config/nvim".source = "${cfg}/nvim";
    ".config/pfp".source = "${cfg}/pfp";
    ".config/wallpaper".source = "${cfg}/wallpaper";
    ".config/waybar".source = "${cfg}/waybar";
  };

  programs = {
    git = {
      enable = true;
      userName = "mkenkel";
      userEmail = "mattsnoopy2@gmail.com";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      history = {
        save = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      shellAliases = {
        "vi" = "nvim";
        "ls" = "lsd";
        "TERM" = "xterm-256color";
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = pkgs.lib.importTOML "${cfg}/starship/starship.toml";
    };
    fzf = {
      enable = true;
    };
    tmux = {
      enable = true;
      escapeTime = 0;
      plugins = with pkgs; [
        tmuxPlugins.continuum
        tmuxPlugins.resurrect
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.catppuccin
      ];

      # https://nix.dev/manual/nix/2.18/language/builtins.html?highlight=readFile#built-in-functions
      extraConfig = builtins.readFile ("${cfg}/tmux/tmux.conf");
    };
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
      "$menu" = "fuzzel";

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
        "$mod SHIFT, q, killactive"
        "$mod SHIFT CONTROL, e, exit"
        "$mod SHIFT, l, exec, ${pkgs.hyprlock}/bin/hyprlock"
        "$mod d, exec, $menu"

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
      ];
      exec-once = [
        "dbus-update-activation-environment --systemd --all"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.hypridle}/bin/hypridle"
        "${pkgs.waybar}/bin/waybar"
      ];
    };
    systemd = {
      enable = true;
    };
  };
}
