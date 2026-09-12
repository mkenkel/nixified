# /etc/nixos/flake.nix
{
  description = "Configuration Hub - NixOS's Master Flake";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dank-greeter = {
      url = "github:AvengeMedia/dank-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    waybar-module-music = {
      url = "github:Andeskjerf/waybar-module-music";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      niri,
      self,
      waybar-module-music,
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
                waybar-module-music.overlays.default
                inputs.niri.overlays.niri
                (final: _prev: {
                  pnpm_10_29_2 = final.pnpm_10;
                })

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
