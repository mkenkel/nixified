{
  config,
  pkgs,
  ...
}:
let
  cfg = ../../../dots;
  shared = ../../shared-modules;
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

  imports = [
    ./fish.nix
    ./hyprland.nix
    ./kitty.nix
    ./${shared}/tmux.nix
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  home.packages = [
    pkgs.alacritty
    pkgs.alacritty-theme
    pkgs.ansible
    pkgs.ansible-builder
    pkgs.ansible-lint
    pkgs.logseq
    pkgs.ansible-navigator
    pkgs.arduino-ide
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
    pkgs.grc
    pkgs.htop
    pkgs.kitty-themes
    pkgs.lazygit
    pkgs.lsd
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
    pkgs.fish
    pkgs.zsh-autosuggestions
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
    ".config/fastfetch".source = "${cfg}/fastfetch";
    #".config/hypr".source = "${cfg}/hypr";
    ".config/mako".source = "${cfg}/mako";
    ".config/nvim".source = "${cfg}/nvim";
    ".config/pfp".source = "${cfg}/pfp";
    ".config/waybar".source = "${cfg}/waybar";
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
          terminal = "alacritty";
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
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
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
      #enableFishIntegration = true;
      extraConfig = builtins.readFile "${cfg}/wezterm/wezterm.lua";
    };
  };

}
