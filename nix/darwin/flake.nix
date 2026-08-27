{
  description = "Configuration Hub - Darwin Master Flake";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    homebrew-bundle.flake = false;
    homebrew-bundle.url = "github:homebrew/homebrew-bundle";
    homebrew-cask.flake = false;
    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-core.flake = false;
    homebrew-core.url = "github:homebrew/homebrew-core";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      home-manager,
      homebrew-bundle,
      homebrew-cask,
      homebrew-core,
      nix-darwin,
      nix-homebrew,
      nixpkgs,
      self,
      ...
    }@inputs:
    let
      user = "matt";
      macHostname = "mktogo";
    in
    {
      #  darwin-rebuild switch --flake .#$(HOST)
      #  nix run nix-darwin -- switch --flake .#$HOST
      darwinConfigurations = {
        ${macHostname} = nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                inherit user;
                enable = true;
                enableRosetta = true; # x86 App Compatibility
                taps = {
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-core" = homebrew-core;
                };
                mutableTaps = false;
              };
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = import ./personal-mbp/home.nix;
              };
            }
            ./personal-mbp
          ];
        };
      };

      darwinPackages = self.darwinConfigurations."${macHostname}".pkgs;
    };
}
