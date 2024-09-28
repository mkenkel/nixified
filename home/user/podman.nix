{ pkgs, ... }:
{
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Useful other development tools
  home.packages = [
    pkgs.dive # look into docker image layers
    pkgs.podman
    pkgs.podman-tui # status of containers in the terminal
    pkgs.podman-desktop
    pkgs.podman-compose
  ];
}
