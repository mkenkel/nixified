# Help is available in the configuration.nix(5) man page, on https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  inputs,
  pkgs,
  lib,
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
  hardware.graphics = {
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
    gnupg.agent = {
      enable = true;
      pinentryPackage = lib.mkForce pkgs.pinentry-qt;
      enableSSHSupport = true;
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "ovftool-4.6.2-22220919"
  ];

  environment.systemPackages = with pkgs; [
    bashSnippets
    curl
    envsubst
    git
    glibc
    lua5_1
    lua-language-server
    luajit
    nixfmt-rfc-style
    openssl
    ovftool
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
    pcscd.enable = true;
  };

  networking = {
    hostName = "${hostname}";
    wireless.enable = true;

    # interfaces = {
    #   enp5s0.ipv4.addresses = [
    #     {
    #       address = "192.168.5.9";
    #       prefixLength = 24;
    #     }
    #   ];
    # };
    # defaultGateway = {
    #   address = "192.168.10.1";
    #   interface = "enp5s0";
    # };
    extraHosts = ''
      # Kubernetes The Hard Way
      192.168.15.5 server.fatnutfarm.com server
      192.168.15.6 node-0.fatnutfarm.com node-0
      192.168.15.7 node-1.fatnutfarm.com node-1
      192.168.15.8 node-2.fatnutfarm.com node-2
    '';
  };

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
