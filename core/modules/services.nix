{ config, pkgs, ... }:
{
  services = {

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    openssh = {
      enable = true;
    };

  };
}
