{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }@inputs: 
  let
    user = "matt";
  in
  {
    nixosConfigurations = {
      updog = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
	};
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
	  home-manager.nixosModules.home-manager
	  ./wsl.nix
{
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = { pkgs, lib, ... }: {
              # Home Manager needs a bit of information about you and the paths it should manage
              home.username = lib.mkForce "${user}";
              home.homeDirectory = lib.mkForce "/home/${user}";
              
              # This value determines the Home Manager release that your configuration is
              # compatible with. This helps avoid breakage when a new Home Manager release
              # introduces backwards incompatible changes.
              home.stateVersion = "25.11"; # Please check the release notes before changing
              
              # Let Home Manager install and manage itself
              programs.home-manager.enable = true;
              
              # Add your home-manager configuration here
              # For example:
              # programs.git = {
              #   enable = true;
              #   userName = "Your Name";
              #   userEmail = "your.email@example.com";
              # };      }
	      };
	      }
      ];
    };
  };
};
}
