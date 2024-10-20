{
  config,
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

  imports = [
    ./hyprland.nix
    ../../shared-modules/tmux.nix
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  stylix.targets.fzf.enable = false;
  stylix.targets.fish.enable = false;

  home.packages = [
    pkgs.alacritty
    pkgs.alacritty-theme
    pkgs.ansible
    pkgs.ansible-builder
    pkgs.ansible-lint
    pkgs.logseq
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
    pkgs.grc
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
    #pkgs.zsh
    #pkgs.zsh-autosuggestions
    pkgs.fish
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
    # zsh = {
    #   enable = true;
    #   enableCompletion = true;
    #   syntaxHighlighting.enable = true;
    #   history = {
    #     save = 10000;
    #     path = "${config.xdg.dataHome}/zsh/history";
    #   };
    #   shellAliases = {
    #     "vi" = "nvim";
    #     "ls" = "lsd";
    #     "TERM" = "xterm-256color";
    #   };
    # };
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        theme_gruvbox
        ### Catppuccin ###
        # name: 'Catppuccin Mocha'
        # url: 'https://github.com/catppuccin/fish'
        # preferred_background: 1e1e2e
        fish_color_normal cdd6f4
        fish_color_command 89b4fa
        fish_color_param f2cdcd
        fish_color_keyword f38ba8
        fish_color_quote a6e3a1
        fish_color_redirection f5c2e7
        fish_color_end fab387
        fish_color_comment 7f849c
        fish_color_error f38ba8
        fish_color_gray 6c7086
        fish_color_selection --background=313244
        fish_color_search_match --background=313244
        fish_color_option a6e3a1
        fish_color_operator f5c2e7
        fish_color_escape eba0ac
        fish_color_autosuggestion 6c7086
        fish_color_cancel f38ba8
        fish_color_cwd f9e2af
        fish_color_user 94e2d5
        fish_color_host 89b4fa
        fish_color_host_remote a6e3a1
        fish_color_status f38ba8
        fish_pager_color_progress 6c7086
        fish_pager_color_prefix f5c2e7
        fish_pager_color_completion cdd6f4
        fish_pager_color_description 6c7086
        ###            ###
      '';
      plugins = [
        # Enable a plugin (here grc for colorized command output) from nixpkgs
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        # Manually packaging and enable a plugin
        {
          name = "z";
          src = pkgs.fetchFromGitHub {
            owner = "jethrokuan";
            repo = "z";
            rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
            sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
          };
        }
        # Colored Man pages
        {
          name = "colored-man-pages";
          src = pkgs.fishPlugins.colored-man-pages.src;
        }
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
  };

}
