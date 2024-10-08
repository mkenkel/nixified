{ self, pkgs, ... }:
let
  user = "matt";
in
{
  imports = [
    ../shared
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Sets user for Home Manager.
  users.knownUsers = [ user ];
  users.users."${user}" = {
    name = "${user}";
    home = "/Users/${user}";
    shell = "/bin/zsh";
    uid = 502;
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
      # "discord"
      # "slack"
      # "spotify"
    ];
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ 
      # I know it's specified 2x... I just wanna make sure it's around :)
      pkgs.neovim
      pkgs.chafa
    ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

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
}
