# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:
let
  user = "matt";
  hostname = "upshot";
in
{
  imports =
    [ 
      ../shared
      ../shared/nixos
      ./hardware-configuration.nix
    ];

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
  # Abbreviated version of the wall of text that was once above - DON'T CHANGE THIS EVER (Unless you know what you're doing).

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
    # Virtualization/Containerization
    podman
    podman-compose
    qemu
    virtiofsd
    # Nix Formatter
    nixfmt-rfc-style
  ];

### Programs.nix ###
  programs = {
    hyprland.enable = true;
    steam.enable = true;
  };

### Services.nix ###
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/hyprland";
          user = "${user}";
        };
        default_session = initial_session;
      };
    };
    openssh = {
      enable = true;
    };
  };

### Syscfg.nix ###
  networking.hostName = "${hostname}";
  networking.wireless.enable = true;

### User.nix ###
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
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
