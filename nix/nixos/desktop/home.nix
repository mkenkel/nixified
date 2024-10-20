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
    ################################################################
    # fish = {
    #   enable = true;
    #   interactiveShellInit = ''
    #     set fish_greeting # Disable greeting
    #   '';
    #   plugins = [
    #     # Enable a plugin (here grc for colorized command output) from nixpkgs
    #     {
    #       name = "grc";
    #       src = pkgs.fishPlugins.grc.src;
    #     }
    #     # Manually packaging and enable a plugin
    #     {
    #       name = "z";
    #       src = pkgs.fetchFromGitHub {
    #         owner = "jethrokuan";
    #         repo = "z";
    #         rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
    #         sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
    #       };
    #     }
    #     # Colored Man pages
    #     {
    #       name = "colored-man-pages";
    #       src = pkgs.fishPlugins.colored-man-pages.src;
    #     }
    #   ];
    # };
    ###############################################################
    nushell = {
      enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      configFile.source = ./.../config.nu;
      # for editing directly to config.nu 
      extraConfig = ''
        let carapace_completer = {|spans|
        carapace $spans.0 nushell $spans | from json
        }
        $env.config = {
         show_banner: false,
         completions: {
         case_sensitive: false # case-sensitive completions
         quick: true    # set to false to prevent auto-selecting completions
         partial: true    # set to false to prevent partial filling of the prompt
         algorithm: "fuzzy"    # prefix or fuzzy
         external: {
         # set to false to prevent nushell looking into $env.PATH to find more suggestions
             enable: true 
         # set to lower can improve completion performance at the cost of omitting some options
             max_results: 100 
             completer: $carapace_completer # check 'carapace_completer' 
           }
         }
        } 
        $env.PATH = ($env.PATH | 
        split row (char esep) |
        prepend /home/myuser/.apps |
        append /usr/bin/env
        )
      '';
      shellAliases = {
        vi = "hx";
        vim = "hx";
        nano = "hx";
      };
    };
    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = pkgs.lib.importTOML "${cfg}/starship/starship.toml";
    };
    fzf = {
      enable = true;
    };
  };

}
