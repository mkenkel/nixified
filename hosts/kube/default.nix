{ config, lib, pkgs, inputs, ... }:
let
  user = "delegate";
  # Somehow I've gotta figure out how to automate based on X nodes...
  # hostname = "upshot";
  KubeController= "testing";
  KubeWorkers= "testing";
in
{
  imports =
    [ 
      ../shared
      ../shared/nixos
      ./hardware-configuration.nix
    ];

  system.stateVersion = "24.05"; # Did you read the comment?
  # Abbreviated version of the wall of text that was once above - DON'T CHANGE THIS EVER (Unless you know what you're doing).

   boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        enable = true;
        device = "nodev";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
  ];
  programs = {};

  services = {
    openssh = {
      enable = true;
    };
  };

# Helpful URL: https://nixos.wiki/wiki/Networking
  networking = {
    hostName = "${hostname}";
    hosts = {
        /* /etc/hosts goes in here */
    };
    interfaces = {
      eth0 = {
        ipv4 = {
          addresses = [
          {
            address = "192.168.5.200";
            prefixLength = "23";
          }
          ];
        };
      };
    };
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };
}
