{ ... }:
let
  cfg = ./configs;
in
{
  home.file = {
    ".config/alacritty".source = "${cfg}/alacritty";
    ".config/nvim".source = "${cfg}/nvim";
    ".config/fastfetch".source = "${cfg}/fastfetch";
  };
}
