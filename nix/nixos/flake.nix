# /etc/nixos/flake.nix
{
  description = "Configuration Hub - NixOS's Master Flake";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    niri = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dank-greeter = {
      url = "github:AvengeMedia/dank-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      niri,
      self,
      ...
    }@inputs:
    let
      user = "matt";
    in
    {
      # $ nixos-rebuild --flake .#upshot switch
      nixosConfigurations = {
        upshot = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            home-manager.nixosModules.home-manager
            ./desktop
            {
              nixpkgs.overlays = [
                inputs.niri.overlays.niri
              ];
              home-manager = {
                extraSpecialArgs = {
                  inherit inputs;
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                sharedModules = [
                  niri.homeModules.niri
                ];
                users.${user} = {
                  imports = [
                    ./desktop/home.nix
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
