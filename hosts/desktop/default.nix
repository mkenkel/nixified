# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
  # Abbreviated version of the wall of text that was once above - DON'T CHANGE THIS EVER (Unless you know what you're doing).

/* 
      Pulling back together all the broken out modules... The problem with the layout
      so broken apart like it was previously is that while it catered towards flexibility
      under a single host, it also makes things incredibly difficult when planning to add
      the following as extra systems/hosts:

      - MBP (M1/Personal)
      - MBP (M1Pro/ Work)
      - OKD Cluster (4x Nodes)

*/

### Boot.nix ###

   boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        enable = true;
        device = "nodev";
        useOSProber = true;
        gfxmodeEfi = "3840x2160";
      };
    };
  };

### Default.nix ###

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

### Fonts.nix ###

  fonts.packages = with pkgs; [
    font-awesome 
    jetbrains-mono

    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

### Hyprland.nix ###

  environment.systemPackages = with pkgs; [
    fuzzel
    hyprcursor
    hypridle
    hyprlock
    hyprpaper
    kitty
    libnotify
    mako
    qt5.qtwayland
    qt6.qtwayland
    waybar
    wl-clipboard
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    # Terminal
    git
    neovim
    tmux
    unzip
    vim 
    wget
    # Virtualization/Containerization
    podman
    podman-compose
    qemu
    virtiofsd
  ];

### Programs.nix ###

  programs = {
    zsh.enable = true;
    hyprland.enable = true;
    steam.enable = true;
  };

### Services.nix ###

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    openssh = {
      enable = true;
    };
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/hyprland";
          user = "matt";
        };
        default_session = initial_session;
      };
    };
  };

### Syscfg.nix ###

  # Enabling the use of Flakes and nix-command.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enabling Automatic Upgrades (Periodically)
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  environment.variables.EDITOR = "nvim";

  time.timeZone = "America/Indianapolis";
  time.hardwareClockInLocalTime = true; # Hardware clock sync for dual boot systems.

  networking.firewall.enable = false;
  networking.hostName = "upshot";
  networking.wireless.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; 
  };

### SystemPackages.nix ###

/* MOVED ABOVE */

### User.nix ###

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matt = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

### Virtualization.nix ###

  # Enable common container config files in /etc/containers
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
