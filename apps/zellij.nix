{ pkgs, ... }:
{
  xdg.configFile."zellij".source = ../stowable-configs/zellij/.config/zellij;

  home.packages = [ pkgs.zellij ];
}
