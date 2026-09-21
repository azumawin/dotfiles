{
  pkgs,
  ...
}:

{
  # these can be changed interactively via claude, but i shouldn't do that and edit them directly instead so that my config stays completely roll-backable.
  home.file.".claude/CLAUDE.md".source = ./config/CLAUDE.md;
  home.file.".claude/settings.json".source = ./config/settings.json;

  home.packages = [ pkgs.claude-code ];
}
