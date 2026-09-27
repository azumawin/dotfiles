{ inputs, ... }:
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;
    workspace.wallpaper = ../../resources/nixoswallpaper.png;
    shortcuts = {
      ActivityManager.switch-to-activity-2e2d9b01-d078-45b9-b035-3e8609b03d41 = [ ];
      "KDE Keyboard Layout Switcher" = {
        "Switch to Last-Used Keyboard Layout" = "Meta+Alt+L";
        "Switch to Next Keyboard Layout" = "Meta+Alt+K";
      };
      kaccess."Toggle Screen Reader On and Off" = "Meta+Alt+S";
      kmix = {
        decrease_microphone_volume = "Microphone Volume Down";
        decrease_volume = "Volume Down";
        decrease_volume_small = "Shift+Volume Down";
        increase_microphone_volume = "Microphone Volume Up";
        increase_volume = "Volume Up";
        increase_volume_small = "Shift+Volume Up";
        mic_mute = [
          "Microphone Mute"
          "Meta+Volume Mute"
        ];
        mute = "Volume Mute";
        push_to_talk = [ ];
      };
      ksmserver = {
        "Halt Without Confirmation" = [ ];
        "Lock Session" = [
          "Screensaver"
          "Meta+L"
        ];
        "Log Out" = "Ctrl+Alt+Del";
        "Log Out Without Confirmation" = [ ];
        LogOut = [ ];
        Reboot = [ ];
        "Reboot Without Confirmation" = [ ];
        "Shut Down" = [ ];
      };
      kwin = {
        "Activate Window Demanding Attention" = "Meta+Ctrl+A";
        "Cycle Overview" = [ ];
        "Cycle Overview Opposite" = [ ];
        "Decrease Opacity" = [ ];
        "Edit Tiles" = "Meta+T";
        Expose = [
          "Ctrl+F9"
          "Meta+F9"
        ];
        ExposeAll = [
          "Launch (C)"
          "Ctrl+F10"
          "Meta+F10"
        ];
        ExposeClass = [
          "Ctrl+F7"
          "Meta+F7"
        ];
        ExposeClassCurrentDesktop = [ ];
        "Grid View" = "Meta+G";
        "Increase Opacity" = [ ];
        "Kill Window" = "Meta+Ctrl+Esc";
        "Move Tablet to Next LogicalOutput" = [ ];
        MoveMouseToCenter = "Meta+F6";
        MoveMouseToFocus = "Meta+F5";
        MoveZoomDown = [ ];
        MoveZoomLeft = [ ];
        MoveZoomRight = [ ];
        MoveZoomUp = [ ];
        Overview = "Meta+W";
        "Setup Window Shortcut" = [ ];
        "Show Desktop" = "Meta+D";
        "Switch One Desktop Down" = "Meta+Ctrl+Down";
        "Switch One Desktop Up" = "Meta+Ctrl+Up";
        "Switch One Desktop to the Left" = "Meta+Ctrl+Left";
        "Switch One Desktop to the Right" = "Meta+Ctrl+Right";
        "Switch Window Down" = "Meta+Alt+Down";
        "Switch Window Left" = "Meta+Alt+Left";
        "Switch Window Right" = "Meta+Alt+Right";
        "Switch Window Up" = "Meta+Alt+Up";
        "Switch to Desktop 1" = [
          "Ctrl+F1"
          "Meta+F1"
        ];
        "Switch to Desktop 10" = [ ];
        "Switch to Desktop 11" = [ ];
        "Switch to Desktop 12" = [ ];
        "Switch to Desktop 13" = [ ];
        "Switch to Desktop 14" = [ ];
        "Switch to Desktop 15" = [ ];
        "Switch to Desktop 16" = [ ];
        "Switch to Desktop 17" = [ ];
        "Switch to Desktop 18" = [ ];
        "Switch to Desktop 19" = [ ];
        "Switch to Desktop 2" = [
          "Ctrl+F2"
          "Meta+F2"
        ];
        "Switch to Desktop 20" = [ ];
        "Switch to Desktop 21" = [ ];
        "Switch to Desktop 22" = [ ];
        "Switch to Desktop 23" = [ ];
        "Switch to Desktop 24" = [ ];
        "Switch to Desktop 25" = [ ];
        "Switch to Desktop 3" = [
          "Ctrl+F3"
          "Meta+F3"
        ];
        "Switch to Desktop 4" = [
          "Ctrl+F4"
          "Meta+F4"
        ];
        "Switch to Desktop 5" = [ ];
        "Switch to Desktop 6" = [ ];
        "Switch to Desktop 7" = [ ];
        "Switch to Desktop 8" = [ ];
        "Switch to Desktop 9" = [ ];
        "Switch to Next Desktop" = [ ];
        "Switch to Next Screen" = [ ];
        "Switch to Previous Desktop" = [ ];
        "Switch to Previous Screen" = [ ];
        "Switch to Screen 0" = [ ];
        "Switch to Screen 1" = [ ];
        "Switch to Screen 2" = [ ];
        "Switch to Screen 3" = [ ];
        "Switch to Screen 4" = [ ];
        "Switch to Screen 5" = [ ];
        "Switch to Screen 6" = [ ];
        "Switch to Screen 7" = [ ];
        "Switch to Screen Above" = [ ];
        "Switch to Screen Below" = [ ];
        "Switch to Screen to the Left" = [ ];
        "Switch to Screen to the Right" = [ ];
        "Toggle Night Color" = [ ];
        "Toggle Window Raise/Lower" = [ ];
        "Walk Through Windows" = [
          "Alt+Tab"
          "Meta+Tab"
        ];
        "Walk Through Windows (Reverse)" = [
          "Alt+Shift+Tab"
          "Meta+Shift+Tab"
        ];
        "Walk Through Windows Alternative" = [ ];
        "Walk Through Windows Alternative (Reverse)" = [ ];
        "Walk Through Windows of Current Application" = [
          "Alt+`"
          "Meta+`"
        ];
        "Walk Through Windows of Current Application (Reverse)" = [
          "Alt+~"
          "Meta+~"
        ];
        "Walk Through Windows of Current Application Alternative" = [ ];
        "Walk Through Windows of Current Application Alternative (Reverse)" = [ ];
        "Window Above Other Windows" = [ ];
        "Window Below Other Windows" = [ ];
        "Window Close" = "Alt+F4";
        "Window Custom Quick Tile Bottom" = [ ];
        "Window Custom Quick Tile Left" = [ ];
        "Window Custom Quick Tile Right" = [ ];
        "Window Custom Quick Tile Top" = [ ];
        "Window Fullscreen" = [ ];
        "Window Grow Horizontal" = [ ];
        "Window Grow Vertical" = [ ];
        "Window Lower" = [ ];
        "Window Maximize" = "Meta+PgUp";
        "Window Maximize Horizontal" = [ ];
        "Window Maximize Vertical" = [ ];
        "Window Minimize" = "Meta+PgDown";
        "Window Move" = [ ];
        "Window Move Center" = [ ];
        "Window No Border" = [ ];
        "Window On All Desktops" = [ ];
        "Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
        "Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
        "Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
        "Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
        "Window One Screen Down" = [ ];
        "Window One Screen Up" = [ ];
        "Window One Screen to the Left" = [ ];
        "Window One Screen to the Right" = [ ];
        "Window Operations Menu" = "Alt+F3";
        "Window Pack Down" = [ ];
        "Window Pack Left" = [ ];
        "Window Pack Right" = [ ];
        "Window Pack Up" = [ ];
        "Window Quick Tile Bottom" = "Meta+Down";
        "Window Quick Tile Bottom Left" = [ ];
        "Window Quick Tile Bottom Right" = [ ];
        "Window Quick Tile Left" = "Meta+Left";
        "Window Quick Tile Right" = "Meta+Right";
        "Window Quick Tile Top" = "Meta+Up";
        "Window Quick Tile Top Left" = [ ];
        "Window Quick Tile Top Right" = [ ];
        "Window Raise" = [ ];
        "Window Resize" = [ ];
        "Window Restore" = "Meta+Backspace";
        "Window Shrink Horizontal" = [ ];
        "Window Shrink Vertical" = [ ];
        "Window to Desktop 1" = [ ];
        "Window to Desktop 10" = [ ];
        "Window to Desktop 11" = [ ];
        "Window to Desktop 12" = [ ];
        "Window to Desktop 13" = [ ];
        "Window to Desktop 14" = [ ];
        "Window to Desktop 15" = [ ];
        "Window to Desktop 16" = [ ];
        "Window to Desktop 17" = [ ];
        "Window to Desktop 18" = [ ];
        "Window to Desktop 19" = [ ];
        "Window to Desktop 2" = [ ];
        "Window to Desktop 20" = [ ];
        "Window to Desktop 21" = [ ];
        "Window to Desktop 22" = [ ];
        "Window to Desktop 23" = [ ];
        "Window to Desktop 24" = [ ];
        "Window to Desktop 25" = [ ];
        "Window to Desktop 3" = [ ];
        "Window to Desktop 4" = [ ];
        "Window to Desktop 5" = [ ];
        "Window to Desktop 6" = [ ];
        "Window to Desktop 7" = [ ];
        "Window to Desktop 8" = [ ];
        "Window to Desktop 9" = [ ];
        "Window to Next Desktop" = [ ];
        "Window to Next Screen" = "Meta+Shift+Right";
        "Window to Previous Desktop" = [ ];
        "Window to Previous Screen" = "Meta+Shift+Left";
        "Window to Screen 0" = [ ];
        "Window to Screen 1" = [ ];
        "Window to Screen 2" = [ ];
        "Window to Screen 3" = [ ];
        "Window to Screen 4" = [ ];
        "Window to Screen 5" = [ ];
        "Window to Screen 6" = [ ];
        "Window to Screen 7" = [ ];
        disableInputCapture = "Meta+Shift+Esc";
        view_actual_size = "Meta+0";
        view_zoom_in = [
          "Meta++"
          "Meta+="
        ];
        view_zoom_out = "Meta+-";
      };
      mediacontrol = {
        mediavolumedown = [ ];
        mediavolumeup = [ ];
        nextmedia = "Media Next";
        pausemedia = "Media Pause";
        playmedia = [ ];
        playpausemedia = "Media Play";
        previousmedia = "Media Previous";
        seekbackwardmedia = "Media Rewind";
        seekbackwardmedialong = [ ];
        seekforwardmedia = "Media Fast Forward";
        seekforwardmedialong = [ ];
        stopmedia = "Media Stop";
      };
      org_kde_powerdevil = {
        "Decrease Keyboard Brightness" = "Keyboard Brightness Down";
        "Decrease Screen Brightness" = "Monitor Brightness Down";
        "Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
        Hibernate = "Hibernate";
        "Increase Keyboard Brightness" = "Keyboard Brightness Up";
        "Increase Screen Brightness" = "Monitor Brightness Up";
        "Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";
        PowerDown = "Power Down";
        PowerOff = "Power Off";
        Sleep = "Sleep";
        "Toggle Keyboard Backlight" = "Keyboard Light On/Off";
        "Turn Off Screen" = [ ];
        powerProfile = [
          "Battery"
          "Meta+B"
        ];
      };
      plasmashell = {
        "Slideshow Wallpaper Next Image" = [ ];
        "activate application launcher" = [
          "Meta"
          "Alt+F1"
        ];
        "activate task manager entry 1" = "Meta+1";
        "activate task manager entry 10" = [ ];
        "activate task manager entry 2" = "Meta+2";
        "activate task manager entry 3" = "Meta+3";
        "activate task manager entry 4" = "Meta+4";
        "activate task manager entry 5" = "Meta+5";
        "activate task manager entry 6" = "Meta+6";
        "activate task manager entry 7" = "Meta+7";
        "activate task manager entry 8" = "Meta+8";
        "activate task manager entry 9" = "Meta+9";
        "clear history" = [ ];
        clear-history = [ ];
        clipboard_action = "Meta+Ctrl+X";
        cycle-panels = "Meta+Alt+P";
        cycleNextAction = [ ];
        cyclePrevAction = [ ];
        edit_clipboard = [ ];
        "manage activities" = "Meta+Q";
        "next activity" = "Meta+A";
        "previous activity" = "Meta+Shift+A";
        repeat_action = [ ];
        "show dashboard" = "Ctrl+F12";
        show-barcode = [ ];
        show-on-mouse-pos = "Meta+V";
        "switch to next activity" = [ ];
        "switch to previous activity" = [ ];
        "toggle do not disturb" = [ ];
      };
    };
    configFile = {
      baloofilerc.General.dbVersion = 2;
      dolphinrc = {
        General.ViewPropsTimestamp = "2026,9,27,19,6,50.684";
        "KFileDialog Settings" = {
          "Places Icons Auto-resize" = false;
          "Places Icons Static Size" = 22;
        };
      };
      kactivitymanagerdrc.activities."2e2d9b01-d078-45b9-b035-3e8609b03d41" = "Default";
      kded5rc.Module-device_automounter.autoload = false;
      kdeglobals = {
        KDE = {
          contrast = 4;
          frameContrast = 0.2;
        };
        WM = {
          activeBackground = "27,27,29";
          activeBlend = "27,27,29";
          activeForeground = "237,240,242";
          inactiveBackground = "27,27,29";
          inactiveBlend = "27,27,29";
          inactiveForeground = "181,182,182";
        };
      };
      kuriikwsfilterrc.General = {
        EnableWebShortcuts = true;
        KeywordDelimiter = ":";
        PreferredWebShortcuts = "";
        UsePreferredWebShortcutsOnly = false;
      };
      kwalletrc.Wallet."First Use" = false;
      kwinrc = {
        Desktops = {
          Id_1 = "c8d88034-1cf7-4d89-b488-377f5acd534b";
          Number = 1;
          Rows = 1;
        };
        "Tiling/c8d88034-1cf7-4d89-b488-377f5acd534b/09f3a05b-84ae-4127-8711-6117d788782e" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        Xwayland.Scale = 1;
      };
      kwinrulesrc.General.rules = "";
      plasma-localerc.Formats.LANG = "en_US.UTF-8";
    };
    dataFile = {

    };
  };
}
