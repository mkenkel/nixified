{ config, ... }:
{
  # Manages your env vars through Home Manager.
  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "nvim";
    TERM = "alacritty";
    STARSHIP_CONFIG="${config.xdg.dataHome}/starship/starship.toml";
  };
}
