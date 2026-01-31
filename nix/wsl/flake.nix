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
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
	};
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
	  home-manager.nixosModules.home-manager
	  ./wsl.nix
        ]
	{
	home-manager = {
	  extraSpecialArgs = {
	      inherit inputs;
	    };
	  useGlobalPkgs = true;
          useUserPackages = true;
	  users.${user} = {
	    imports = [
	      ./modules/home.nix
	      ];
	  };
	};
      };
    };
  };
}

