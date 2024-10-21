{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mangohud
    protonup
    lutris
  ];

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  programs = {
    steam.enable = true;
    steam.gamescopeSession.enable = true;
    gamemode.enable = true;
  };

  services = {
    xserver.videoDrivers = [ "amdgpu" ];
  };
}
