{ pkgs, ... }:
let
  user = "matt";
in
{
  imports = [
    ../shared
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.knownUsers = [ user ];
  users.users."${user}" = {
    name = "${user}";
    home = "/Users/${user}";
    shell = "/bin/zsh";
    uid = 501;
  };

  homebrew = {
    enable = true;
    casks = [
      "aerospace"
      "firefox"
      "font-sarasa-nerd"
      "keeper-password-manager"
      "obsidian"
      "visual-studio-code"
      "discord"
      "slack"
      "spotify"
    ];
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.chafa
    pkgs.nixfmt-rfc-style # Nixfmt
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
        # KeyRepeat = 2;
        #
        # # 120, 94, 68, 35, 25, 15
        # InitialKeyRepeat = 15;
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
