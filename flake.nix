# /etc/nixos/flake.nix
{
  description = "Configuration Hub - Repository of the factotum.";

  inputs = {
############################################
    # Core Nix
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
############################################
    # NixOS-Specific
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
############################################
    # Darwin-Specific
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-bundle.url = "github:homebrew/homebrew-bundle"; homebrew-bundle.flake = false;
    homebrew-core.url = "github:homebrew/homebrew-core"; homebrew-core.flake = false;
    homebrew-cask.url = "github:homebrew/homebrew-cask"; homebrew-cask.flake = false;
    aerospace-tap.url = "github:nikitabobko/homebrew-tap"; aerospace-tap.flake = false;
    sarasa-nerd-font.url = "github:laishulu/homebrew-cask-fonts"; sarasa-nerd-font.flake = false;
    sketchy-bar.url = "github:FelixKratz/homebrew-formulae"; sketchy-bar.flake = false;
############################################
  };

  outputs = { self, 
              nixpkgs, 
              nix-homebrew, 
              homebrew-bundle, 
              homebrew-core, 
              homebrew-cask,
              nix-darwin,
              home-manager, 
              aerospace-tap,
              sarasa-nerd-font,
              sketchy-bar,
              ... } @ inputs:
  let
    user = "matt";
  in
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
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${user} = import ./home/nixos;
            };
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
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          {
            # Nix-Homebrew
            nix-homebrew = {
              inherit user;
              enable = true;
              # x86 App Compatibility
              enableRosetta = true;
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = homebrew-bundle;
              # TWM
                "nikitabobko/homebrew-tap" = aerospace-tap;
              # SC Font
                "laishulu/homebrew-cask-fonts" = sarasa-nerd-font;
              # Bar
                "FelixKratz/homebrew-formulae" = sketchy-bar;
              };
              # Optional: Enable fully-declarative tap management. With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
              mutableTaps = false;
            };
            # Home Manager
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${user} = import ./home/darwin;
            };
          }
          ./hosts/mbp
        ];
      };
    };

    darwinPackages = self.darwinConfigurations."mktogo".pkgs;
  };
}
