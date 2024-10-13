# /etc/nixos/flake.nix
{
  description = "Configuration Hub - NixOS's Master Flake";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # follows development branch of hyprland
    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland"; # to make sure that the plugin is built for the correct version of hyprland
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      catppuccin,
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
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            ./desktop
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = {
                  imports = [
                    ./desktop/home.nix
                    catppuccin.homeManagerModules.catppuccin
                  ];

                };
              };
            }
          ];
        };
      };
    };
}
