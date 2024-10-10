{
  description = "Configuration Hub - Darwin Master Flake";

  inputs = {
    aerospace-tap.flake = false;
    aerospace-tap.url = "github:nikitabobko/homebrew-tap";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    homebrew-bundle.flake = false;
    homebrew-bundle.url = "github:homebrew/homebrew-bundle";
    homebrew-cask.flake = false;
    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-core.flake = false;
    homebrew-core.url = "github:homebrew/homebrew-core";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    sarasa-nerd-font.flake = false;
    sarasa-nerd-font.url = "github:laishulu/homebrew-cask-fonts";
  };

  outputs =
    {
      aerospace-tap,
      home-manager,
      homebrew-bundle,
      homebrew-cask,
      homebrew-core,
      nix-darwin,
      nix-homebrew,
      nixpkgs,
      sarasa-nerd-font,
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
                  "laishulu/homebrew-cask-fonts" = sarasa-nerd-font;
                  "nikitabobko/homebrew-tap" = aerospace-tap;
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
