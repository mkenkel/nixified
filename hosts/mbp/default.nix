{ self, pkgs, ... }:
{
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ 
      # I know it's specified 2x... I just wanna make sure it's around :)
      pkgs.neovim
    ];

  environment.interactiveShellInit = ''
    alias ls='lsd'
    alias vi='nvim'
  '';

  # system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina

  fonts.packages = with pkgs; [
    font-awesome 
    jetbrains-mono

    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
