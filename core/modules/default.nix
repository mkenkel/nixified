{ ... }:

{
  imports = [
    ./fonts.nix
    ./hyprland.nix
    ./podman.nix
    ./programs.nix
    ./services.nix
    ./syscfg.nix
    ./systemPackages.nix
    ./user.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
