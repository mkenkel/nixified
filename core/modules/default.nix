{ ... }:

{
  imports = [
    ./fonts.nix
    ./hyprland.nix
    ./programs.nix
    ./services.nix
    ./syscfg.nix
    ./systemPackages.nix
    ./user.nix
    ./virtualization.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
