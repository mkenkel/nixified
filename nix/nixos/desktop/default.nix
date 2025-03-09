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

  my-kubernetes-helm =
    with pkgs;
    wrapHelm kubernetes-helm {
      plugins = with pkgs.kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
        helm-s3
        helm-git
      ];
    };

  my-helmfile = pkgs.helmfile-wrapped.override {
    inherit (my-kubernetes-helm) pluginsDir;
  };
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
  };

  nixpkgs.config.permittedInsecurePackages = [
    "ovftool-4.6.2-22220919"
  ];

  nixpkgs.overlays = [
    # Fix for Vesktop regarding the 'automatic gain' issues stemming from WebRTC.
    (pkgs.vesktop.overrideAttrs (previousAttrs: {
      patches = previousAttrs.patches ++ [
        (pkgs.fetchpatch {
          name = "micfix-b0730e139805c4eea0d610be8fac28c1ed75aced.patch";
          url = "https://gist.githubusercontent.com/jvyden/4aa114a1118a06f3be96710df95f311c/raw/b0730e139805c4eea0d610be8fac28c1ed75aced/micfix.patch";
          hash = "sha256-EIK7/CtKpruf4/N2vn8XSCNkyDCL8I6ciXOljkvgz5A=";
        })
      ];
    }))
  ];

  environment.systemPackages = with pkgs; [
    age
    bashSnippets
    cilium-cli
    curl
    envsubst
    git
    glibc
    # Helm stuff
    my-kubernetes-helm
    my-helmfile
    kompose
    # ---
    hubble
    lua5_1
    lua-language-server
    luajit
    nixfmt-rfc-style
    openssl
    ovftool
    pa-notify
    packer
    paperkey
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
    extraHosts = '''';
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
