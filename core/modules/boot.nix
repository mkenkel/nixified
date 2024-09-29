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
        gfxpayloadEfi = "3840x2160x32"; #TTY resolution (grub > videoinfo)
        gfxmodeEfi = "auto"; #Grub resolution (overridden by console mode)
        font = "${pkgs.tamzen}/share/fonts/misc/Tamzen10x20r.otb"; # (pf2/otb/ttf) Invalid font breaks TTY resolution
        fontSize = 20;
        extraConfig = "
          terminal_input console
          terminal_output console
        ";
      };
    };
  };
}
