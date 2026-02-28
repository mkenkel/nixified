{ ... }:
{
  environment = {
    variables = {
      EDITOR = "nvim";
      GDK_BACKEND = "wayland";
      NIXOS_OZONE_WL = 1;
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      SDL_VIDEODRIVER = "wayland";
      XDG_CURRENT_DESKTOP = "river";
      XDG_SESSION_DESKTOP = "river";
      XDG_SESSION_TYPE = "wayland";
    };
    interactiveShellInit = ''
      alias ls='lsd'
    '';
  };
}
