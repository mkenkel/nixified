{ ... }:
{
  environment = {
    variables = {
      EDITOR = "nvim";
    };
    interactiveShellInit = ''
      alias ls='lsd'
    '';
  };
}
