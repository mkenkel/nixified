{ pkgs, lib, config, ... }:
{
  programs.git = {
    enable = true;
    userName = "whipplash";
    userEmail = "mattsnoopy2@gmail.com";
  };
}
