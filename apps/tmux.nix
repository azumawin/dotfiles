{ pkgs, ... }:
{
  xdg.configFile."tmux".source = ../stowable-configs/tmux/.config/tmux;

  home.packages = with pkgs; [ tmux ];
}
