# Help is available in the configuration.nix(5) man page, on https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  inputs,
  pkgs,
  ...
}:
let
  user = "matt";
  hostname = "upshot";
  nos = ./../modules; # NixOS
  universal = ./../../universal-modules; # Cross-platform modules
in
{

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  imports = [
    # Universal Modules (OS-Agnostic, Nix-centric, non-home-manager modules)
    "${universal}/fonts.nix"

    # NixOS
    "${nos}/environment.nix"
    "${nos}/foot.nix"
    "${nos}/gaming.nix"
    "${nos}/login.nix"
    "${nos}/programs.nix"

    ./hardware-configuration.nix
  ];

  system.stateVersion = "24.05"; # Did you read the comment? - DONT CHANGE UNLESS GOOGLE
  security.polkit.enable = true;
  hardware.opengl = {
    enable = true;
  };

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
  };

  environment.systemPackages = with pkgs; [
    curl
    git
    glibc
    lua5_1
    lua-language-server
    luajit
    nixfmt-rfc-style
    openssl
    pa-notify
    packer
    pavucontrol
    pipecontrol
    podman
    podman-compose
    pw-volume
    pwvucontrol
    qemu
    sshpass
    terraform
    unzip
    virtiofsd
    vlc
    waybar
    wget
    wl-clipboard
  ];

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
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
    shell = pkgs.fish;
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
