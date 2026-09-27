{ inputs, ... }:
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;
    workspace = {
      wallpaper = ../../resources/nixoswallpaper.png;
      colorScheme = "Nothing";
      theme = "Nothing";
      iconTheme = "breeze-dark";
      widgetStyle = "Breeze";
      cursor.theme = "WhiteSur-cursors";
      windowDecorations = {
        library = "org.kde.kwin.aurorae";
        theme = "__aurorae__svg__Nothing";
      };
    };
  };
}
