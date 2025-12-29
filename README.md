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

  ################################## Rocksmith Configurations Start
  security.rtkit.enable = true; # Enables rtkit (https://directory.fsf.org/wiki/RealtimeKit)
  #
  # domain = "@audio": This specifies that the limits apply to users in the @audio group.
  # item = "memlock": Controls the amount of memory that can be locked into RAM.
  # value (`unlimited`) allows members of the @audio group to lock as much memory as needed. This is crucial for audio processing to avoid swapping and ensure low latency.
  #
  # item = "rtprio": Controls the real-time priority that can be assigned to processes.
  # value (`99`) is the highest real-time priority level. This setting allows audio applications to run with real-time scheduling, reducing latency and ensuring smoother performance.
  #
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "99";
    }
  ];

  ################################## Rocksmith Configurations End
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

  xdg.portal.enable = true;

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
    age
    bashSnippets
    bottles
    cilium-cli
    curl
    envsubst
    fluxcd
    git
    glibc
    glibc_multi
    go
    gopls
    helm-ls
    hubble
    kompose
    kube-linter
    kubectl
    kustomize
    lua-language-server
    lua5_1
    luajit
    my-helmfile
    my-kubernetes-helm
    nfs-utils
    nixfmt-rfc-style
    openssl
    pa-notify
    packer
    paperkey
    pavucontrol # Lets you disable inputs/outputs, can help if game auto-connects to bad IOs
    pipecontrol
    podman
    podman-compose
    pw-volume
    pwvucontrol
    qemu
    qpwgraph # Lets you view pipewire graph and connect IOs
    rtaudio
    slack
    sshpass
    taplo
    terraform
    terraform-ls
    tftp-hpa
    timoni
    unzip
    unzip # Used by patch-nixos.sh
    virtiofsd
    vlc
    vscodium
    waybar
    wget
    wineWowPackages.stable
    wineWowPackages.waylandFull
    winetricks
    wl-clipboard
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "libsoup-2.74.3"
  ];

  services = {
    xinetd = {
      enable = true;
      services = [
        {
          name = "tftp";
          protocol = "udp";
          server = "${pkgs.netkittftp}/sbin/in.tftpd";
          serverArgs = "-s /tftpboot";
          extraConfig = "flags = IPv4";
        }
      ];
    };
    displayManager = {
      sessionPackages = with pkgs; [
        river
        hyprland
      ];
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
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
    search = [ "home.arpa" ];
    extraHosts = ''
      192.168.15.202 rancher.cilium.rocks
    '';
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "rtkit"
      "docker"
    ];
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
    docker = {
      enable = true;
    };
    podman = {
      enable = false;
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
