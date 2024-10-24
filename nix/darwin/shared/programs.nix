{ ... }:
{
  programs = {
    zsh.enable = true;
    fish = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
