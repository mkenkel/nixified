{ ... }:
{
  environment = {
    variables = {
      EDITOR = "nvim";
    };
    interactiveShellInit = ''
      alias ls='lsd'
      alias vi='nvim'
    '';
  };
}
