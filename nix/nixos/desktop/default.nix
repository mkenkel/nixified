# Help is available in the configuration.nix(5) man page, on https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  inputs,
  pkgs,
  ...
}:
let
  user = "matt";
  hostname = "upshot";
in
{

  nix.settings = {
    experimental-features = [
    "nix-command"
    "flakes"
    ];
    # Cachix for Hyprland
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

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

  programs = {
    hyprland = {
      enable = true;
      # set the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    steam.enable = true;
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

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    # greetd = {
    #   enable = true;
    #   settings = rec {
    #     initial_session = {
    #       command = "${pkgs.stdenv.hostPlatform.system}.hyprland;/bin/hyprland";
    #       user = "${user}";
    #     };
    #     default_session = initial_session;
    #   };
    # };
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


  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  time.timeZone = "America/Indianapolis";
  time.hardwareClockInLocalTime = true; # Hardware clock sync for dual boot systems.
  networking.firewall.enable = false;

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
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
