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

    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/hyprland";
          user = "matt";
        };
        default_session = initial_session;
      };
    };

  };
}
