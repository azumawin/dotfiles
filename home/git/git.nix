{
  pkgs,
  ...
}:

{

  home.file.".gitconfig".source = ./config/.gitconfig;
  home.packages = [ pkgs.git ];
}
