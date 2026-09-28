{ inputs, ... }:
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;
    workspace = {
      wallpaper = ../../resources/linusnvidia.jpg;
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
    kscreenlocker = {
      appearance = {
        wallpaper = ../../resources/nixos.png;
      };
    };
    panels = [
      {
        location = "top";
        height = 34;
        widgets = [
          # Application Launcher (Kickoff)
          "org.kde.plasma.kickoff"

          # Icons-Only Task Manager with Pinned Launchers
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:kitty.desktop"
                "applications:brave-browser.desktop"
              ];
            };
          }

          # System Tray & Clock
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];
  };
}
