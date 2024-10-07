{ config, lib, pkgs, inputs, ... }:
let
  user = "delegate";
  # Somehow I've gotta figure out how to automate based on X nodes...
  # hostname = "upshot";
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

  environment.systemPackages = with pkgs; [];
  programs = {};
  services = {};

  ###################################### TBD; change to NetworkManager enable. ######################################
  networking.hostName = "${hostname}";

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };
}
