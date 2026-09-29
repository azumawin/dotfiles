{ inputs, ... }:
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # nothing theme
    # workspace = {
    #   wallpaper = ../../resources/linusnvidia.jpg;
    #   colorScheme = "Nothing";
    #   theme = "Nothing";
    #   iconTheme = "breeze-dark";
    #   widgetStyle = "Breeze";
    #   cursor.theme = "WhiteSur-cursors";
    #   windowDecorations = {
    #     library = "org.kde.kwin.aurorae";
    #     theme = "__aurorae__svg__Nothing";
    #   };
    # };

    # blackglass theme
    workspace = {
      wallpaper = ../../resources/blackglasswp.png;
      colorScheme = "Nothing";
      theme = "blackglass";
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
                "applications:brave-browser.desktop"
                "applications:kitty.desktop"
              ];
            };
          }

          {
            systemTray = {
              # Optional global icon spacing or scaling
              icons = {
                spacing = "medium";
                scaleToFit = false;
              };
              items = {
                showAll = false; # Set to true to show all by default
                # Explicitly force widgets to be shown always
                shown = [
                  "org.kde.plasma.mediacontroller"
                  "org.kde.plasma.battery"
                  "org.kde.plasma.networkmanagement"
                ];
                # Explicitly hide specific items into the popup/arrow menu
                hidden = [
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.notifications"
                ];
              };
            };
          }

          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];
  };
}
