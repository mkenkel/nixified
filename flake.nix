# /etc/nixos/flake.nix
{
  description = "Flake for Upshot - my desktop env.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

  outputs = { self, nixpkgs , ...} @ inputs: {
    nixosConfigurations.upshot = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # this is the important part (Hyprland)
        modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
          ./core/configuration.nix
        ];
      };
  };
}
