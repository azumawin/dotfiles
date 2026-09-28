{ pkgs, ... }:
{
  xdg.configFile."zellij".source = ./config;

  home.packages = [ pkgs.zellij ];
}
