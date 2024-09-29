{ config, lib, pkgs, ... }: 
{
  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;

      grub = {
        efiSupport = true;
        enable = true;
        device = "nodev";
        useOSProber = true;
        gfxmodeEfi = "3840x2160";
        font = "${pkgs.grub2}/share/grub/unicode.pf2";
        fontSize = 32;
      };
    };
  };
}
