# Help is available in the configuration.nix(5) man page, on https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  pkgs,
  ...
}:
let
  user = "matt";
  hostname = "upshot";
in
{
  imports = [
    ../shared
    ./hardware-configuration.nix
  ];

  system.stateVersion = "24.05"; # Did you read the comment? - DONT CHANGE UNLESS GOOGLE

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

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  environment.systemPackages = with pkgs; [
    fuzzel
    hyprcursor
    hypridle
    hyprlock
    hyprpaper
    kitty
    libnotify
    mako
    nixfmt-rfc-style
    podman
    podman-compose
    qemu
    qt5.qtwayland
    qt6.qtwayland
    virtiofsd
    waybar
    wl-clipboard
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
  ];

  programs = {
    hyprland.enable = true;
    steam.enable = true;
  };

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

  networking.hostName = "${hostname}";
  networking.wireless.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

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
