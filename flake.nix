# /etc/nixos/flake.nix
{
  description = "Flake for Upshot - my desktop env.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  inputs.home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = { self, nixpkgs, home-manager, ...} @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations.upshot = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # this is the important part (Hyprland)
        modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
          ./core/configuration.nix
        ];
      };

    homeConfigurations."matt" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [ ./home ];
      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      };
    };



}
