{
  config,
  pkgs,
  ...
}:
let
  cfg = ../../../dots;
  u-hm = ./../../universal-modules; # universal Home Manager
  user = "matt";
in
{
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "24.05"; # Pls google before changing this

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 48;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services = {
    # All valuVes except 'enable' are optional.
    wlsunset = {
      enable = true;
      temperature = {
        day = 6500;
        night = 3500;
      };
      latitude = "39";
      longitude = "84.5";
    };

  };

  imports = [
    ./hyprland.nix
    ./programming.nix
    "${u-hm}/fish.nix"
    "${u-hm}/kitty.nix"
    "${u-hm}/tmux.nix"
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  home.packages = with pkgs; [
    alacritty
    alacritty-theme
    bambu-studio
    brightnessctl
    btop
    chafa
    cmatrix
    fastfetch
    ffmpeg
    firefox
    fish
    freecad
    fzf
    giph
    grc
    grim
    haskellPackages.sixel
    htop
    inkscape
    kitty-themes
    libsixel
    lsd
    nwg-look
    obsidian
    playerctl
    qalculate-qt
    ripgrep
    slurp
    spotify
    starship
    tree
    wf-recorder
  ];

  nixpkgs.overlays = [
    # Fix for Vesktop regarding the 'automatic gain' issues stemming from WebRTC.
    (pkgs.vesktop.overrideAttrs (previousAttrs: {
      patches = previousAttrs.patches ++ [
        (pkgs.fetchpatch {
          name = "micfix-b0730e139805c4eea0d610be8fac28c1ed75aced.patch";
          url = "https://gist.githubusercontent.com/jvyden/4aa114a1118a06f3be96710df95f311c/raw/b0730e139805c4eea0d610be8fac28c1ed75aced/micfix.patch";
          hash = "sha256-EIK7/CtKpruf4/N2vn8XSCNkyDCL8I6ciXOljkvgz5A=";
        })
      ];
    }))
  ];

  # Manages your env vars through Home Manager.
  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "nvim";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    TERM = "xterm-256color";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_DATA_HOME = "\${HOME}/.local/share";
  };

  home.file = {
    ".config/alacritty".source = "${cfg}/alacritty";
    ".config/mako".source = "${cfg}/mako";
    ".config/nvim".source = "${cfg}/nvim";
    ".config/pfp".source = "${cfg}/pfp";
    ".config/waybar".source = "${cfg}/waybar";
    ".config/scripts".source = "${cfg}/scripts";
  };

  programs = {
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
    };
    fuzzel = {
      enable = true;
      settings = {
        main = {
          dpi-aware = "auto";
          use-bold = "yes";
          match-mode = "fzf";
          show-actions = "yes";
          terminal = "foot";
          width = 30;
        };
        border.width = 1;
        border.radius = 10;
      };
    };
    git = {
      enable = true;
      userName = "mkenkel";
      userEmail = "mattsnoopy2@gmail.com";
    };
    mangohud = {
      enable = true;
      enableSessionWide = true;
      # settings = builtins.readFile ("${cfg}/mangohud/mangohud.conf");
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      extraLuaPackages = ps: [
        ps.magick
      ];
      extraPackages = [
        pkgs.imagemagick
      ];
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = pkgs.lib.importTOML "${cfg}/starship/starship.toml";
    };
    fzf = {
      enable = true;
    };
    wezterm = {
      enable = true;
      extraConfig = builtins.readFile "${cfg}/wezterm/wezterm.lua";
    };
  };

}
