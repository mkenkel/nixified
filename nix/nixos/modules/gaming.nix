{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    protonup
    lutris
    vulkan-tools # Troubleshooting Mangohud w/ vkcube
    mesa-demos # OpenGL Troubleshooting
    discord
    discordo
    discord-sh
    vesktop
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs = {
    steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
        };
      package = pkgs.steam.override {
        extraLibraries = pkgs: [ pkgs.pkgsi686Linux.pipewire.jack ]; # Adds pipewire jack (32-bit)
        extraPkgs = pkgs: [ pkgs.wineasio ]; # Adds wineasio
        };
      };
    gamemode.enable = true;
  };

  services = {
    xserver.videoDrivers = [ "amdgpu" ];
  };
}
