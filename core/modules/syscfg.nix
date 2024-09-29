{ config, lib, pkgs, ... }: 
{
  # Enabling the use of Flakes and nix-command.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enabling Automatic Upgrades (Periodically)
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  environment.variables.EDITOR = "nvim";

  time.timeZone = "America/Indianapolis";
  time.hardwareClockInLocalTime = true; # Hardware clock sync for dual boot systems.

  networking.firewall.enable = false;
  networking.hostName = "upshot";
  networking.wireless.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "${pkgs.tamzen}/share/consolefonts/Tamzen8x16.psf";
    packages = with pkgs; [ tamzen ];
    keyMap = "us";
  };
}
