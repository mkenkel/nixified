# /etc/nixos/flake.nix
{
  description = "flake for home desktop - upshot";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.upshot = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
          ./configuration.nix
        ];
      };
  };
}
