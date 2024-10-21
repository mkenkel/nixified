{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    protonup
    lutris
    vulkan-tools # Troubleshooting Mangohud w/ vkcube
    mesa-demos # OpenGL Troubleshooting
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
