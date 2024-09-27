{ config, lib, pkgs, ... }: 
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;

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
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
}
