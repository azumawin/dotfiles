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
    # make sure the function key rows are flipped and f1, f2, ... are primary keys instead of assigned mute volume, etc.
    shortcuts = {
      kwin = {
        # Release Meta+Left/Right from window quick-tiling so the desktop
        # switcher can claim them; KDE silently drops the loser otherwise.
        "Window Quick Tile Left" = [ ];
        "Window Quick Tile Right" = [ ];

        "Switch One Desktop to the Left" = "Meta+Left";
        "Switch One Desktop to the Right" = "Meta+Right";

        "Switch to Desktop 1" = [
          "Meta+F1"
          "Ctrl+F1"
        ];
        "Switch to Desktop 2" = [
          "Meta+F2"
          "Ctrl+F2"
        ];
        "Switch to Desktop 3" = [
          "Meta+F3"
          "Ctrl+F3"
        ];
        "Switch to Desktop 4" = [
          "Meta+F4"
          "Ctrl+F4"
        ];
      };
    };
  };
}
