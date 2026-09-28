{ pkgs, ... }:

{
  home.file.".bashrc".source = ./config/.bashrc;
  home.packages = [ pkgs.bash-completion ];
}
