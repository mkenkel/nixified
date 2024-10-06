{ self, pkgs, ... }:
let
  user = "matt";
in
{
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog

  # Equivalent to setting user via Home Manager.
  users.knownUsers = [ user ];
  users.users."${user}" = {
    name = "${user}";
    home = "/Users/${user}";
    shell = "/bin/zsh";
    uid = 501;
  };
  # Homebrew (nix-darwin)
  homebrew = {
    enable = true;
    casks = [
      # General
      "aerospace"
      "firefox"
      "font-sarasa-nerd"
      "keeper-password-manager"
      "obsidian"
      "visual-studio-code"
      # "sketchybar"

      # Personal
      "discord"
      "slack"
      "spotify"
    ];
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ 
      # I know it's specified 2x... I just wanna make sure it's around :)
      pkgs.neovim
      pkgs.chafa
    ];

  environment.interactiveShellInit = ''
    alias ls='lsd'
    alias vi='nvim'
  '';

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  system = {
    defaults = {
      NSGlobalDomain = {
        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;
        AppleInterfaceStyle = "Dark";
      };

      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        mouse-over-hilite-stack = true;
        orientation = "bottom";
        tilesize = 48;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
      universalaccess.reduceTransparency = true;
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
    stateVersion = 5;
    startup.chime = false;
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
