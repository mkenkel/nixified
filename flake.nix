# /etc/nixos/flake.nix
{
  description = "Configuration Hub - Repository of the factotum.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin= {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... } @ inputs:
  {
    # Build nix flake using:
    # $ nixos-rebuild --flake .#upshot switch
    nixosConfigurations = {
      upshot = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; 
        modules = [
          ./hosts/desktop
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.matt = import ./home/nixos;
          }
        ];
      };
    };

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#mktogo
    darwinConfigurations = {
      mktogo = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; }; 
        modules = [
          ./hosts/mbp
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.matt = import ./home/darwin;
          }
        ];
      };
    };

    darwinPackages = self.darwinConfigurations."mktogo".pkgs;
  };
}
