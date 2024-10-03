{ self, pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ 

      # Neovim
      pkgs.neovim
      pkgs.ripgrep
      pkgs.fzf
      pkgs.lazygit
      pkgs.yamllint

      # Development
      pkgs.python3
      pkgs.ansible
      pkgs.ansible-lint
      pkgs.ansible-builder
      pkgs.ansible-navigator
      pkgs.nodejs
      pkgs.cargo
      pkgs.rustc
      pkgs.gnumake
      pkgs.gcc

      # Terminal
      pkgs.lsd
      pkgs.starship
      pkgs.fastfetch
      pkgs.vim
    ];

  environment.interactiveShellInit = ''
    alias ls='lsd'
    alias vi='nvim'
  '';

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
