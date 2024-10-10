{
  description = "Configuration Hub - Darwin Master Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-bundle.url = "github:homebrew/homebrew-bundle";
    homebrew-bundle.flake = false;
    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-core.flake = false;
    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-cask.flake = false;
    aerospace-tap.url = "github:nikitabobko/homebrew-tap";
    aerospace-tap.flake = false;
    sarasa-nerd-font.url = "github:laishulu/homebrew-cask-fonts";
    sarasa-nerd-font.flake = false;
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-homebrew,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      nix-darwin,
      home-manager,
      aerospace-tap,
      sarasa-nerd-font,
      ...
    }@inputs:
    let
      personalUser = "matt";
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
              # Nix-Homebrew
              nix-homebrew = {
                inherit personalUser;
                enable = true;
                # x86 App Compatibility
                enableRosetta = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                  "nikitabobko/homebrew-tap" = aerospace-tap;
                  "laishulu/homebrew-cask-fonts" = sarasa-nerd-font;
                };
                mutableTaps = false;
              };
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${personalUser} = import ./home/darwin;
              };
            }
            ./hosts/mbp
          ];
        };
      };

      darwinPackages = self.darwinConfigurations."${macHostname}".pkgs;
    };
}
