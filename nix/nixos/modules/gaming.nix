{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    protonup
    lutris
    vulkan-tools # Troubleshooting Mangohud w/ vkcube
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
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
