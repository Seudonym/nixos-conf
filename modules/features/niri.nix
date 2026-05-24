{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, lib, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
      };
    };

  flake.wrappersModules.niri =
    {
      lib,
      pkgs,
      ...
    }:
    {
      settings =
        let
          noctaliaExe = lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia-shell;
          vicinaeExe = lib.getExe pkgs.vicinae;
        in
        {
          prefer-no-csd = _: { };

          input = {
            focus-follows-mouse = _: { };

            keyboard = {
              xkb = { };
              numlock = _: { };
            };

            touchpad = {
              tap = _: { };
              natural-scroll = _: { };
            };
          };

          outputs = {
            "eDP-2" = {
              mode = "2560x1440@165.003";
              scale = 1.5;
              position = _: {
                props = {
                  x = 960;
                  y = 1080;
                };
              };
            };
          };

          layout = {
            gaps = 2;
            center-focused-column = "never";

            preset-column-widths = [
              { proportion = 0.33333; }
              { proportion = 0.5; }
              { proportion = 0.66667; }
            ];

            default-column-width.proportion = 0.5;

            focus-ring = {
              width = 1;
              active-color = "darkblue";
              inactive-color = "#505050";
            };

            border = {
              width = 1;
              active-color = "#ffc87f";
              inactive-color = "#505050";
              urgent-color = "#9b0000";
            };
          };

          spawn-at-startup = [
            noctaliaExe
            (lib.getExe (pkgs.writeShellScriptBin "vicinae-server" "${vicinaeExe} server"))
          ];

          hotkey-overlay.skip-at-startup = _: { };

          screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

          window-rules = [
            {
              matches = [ { } ];
              background-effect = {
                blur = true;
                xray = false;
              };
            }
          ];

          layer-rules = [
            {
              matches = [ { namespace = "^noctalia-(notifications|toast)-.*$"; } ];
              block-out-from = "screencast";
            }
          ];

          binds = {
            "Mod+Shift+Slash".show-hotkey-overlay = _: { };

            "Mod+T".spawn = lib.getExe pkgs.kitty;
            "Mod+Space".spawn-sh = "${lib.getExe pkgs.vicinae} toggle";

            "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
            "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
            "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            "XF86AudioMicMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
            "XF86AudioPlay".spawn-sh = "playerctl play-pause";
            "XF86AudioStop".spawn-sh = "playerctl stop";
            "XF86AudioPrev".spawn-sh = "playerctl previous";
            "XF86AudioNext".spawn-sh = "playerctl next";

            "XF86MonBrightnessUp".spawn-sh = "brightnessctl --class=backlight set +10%";
            "XF86MonBrightnessDown".spawn-sh = "brightnessctl --class=backlight set 10%-";
            "XF86KbdBrightnessUp".spawn-sh = "brightnessctl --device=*kbd_backlight set 1+";
            "XF86KbdBrightnessDown".spawn-sh = "brightnessctl --device=*kbd_backlight set 1-";

            "Mod+O".toggle-overview = _: { };
            "Mod+Q".close-window = _: { };

            "Mod+Left".focus-column-left = _: { };
            "Mod+Down".focus-window-down = _: { };
            "Mod+Up".focus-window-up = _: { };
            "Mod+Right".focus-column-right = _: { };
            "Mod+H".focus-column-left = _: { };
            "Mod+J".focus-window-down = _: { };
            "Mod+K".focus-window-up = _: { };
            "Mod+L".focus-column-right = _: { };

            "Mod+Shift+Left".move-column-left = _: { };
            "Mod+Shift+Down".move-window-down = _: { };
            "Mod+Shift+Up".move-window-up = _: { };
            "Mod+Shift+Right".move-column-right = _: { };
            "Mod+Shift+H".move-column-left = _: { };
            "Mod+Shift+J".move-window-down = _: { };
            "Mod+Shift+K".move-window-up = _: { };
            "Mod+Shift+L".move-column-right = _: { };

            "Mod+Home".focus-column-first = _: { };
            "Mod+End".focus-column-last = _: { };
            "Mod+Ctrl+Home".move-column-to-first = _: { };
            "Mod+Ctrl+End".move-column-to-last = _: { };

            "Mod+Ctrl+Left".focus-monitor-left = _: { };
            "Mod+Ctrl+Down".focus-monitor-down = _: { };
            "Mod+Ctrl+Up".focus-monitor-up = _: { };
            "Mod+Ctrl+Right".focus-monitor-right = _: { };
            "Mod+Ctrl+H".focus-monitor-left = _: { };
            "Mod+Ctrl+J".focus-monitor-down = _: { };
            "Mod+Ctrl+K".focus-monitor-up = _: { };
            "Mod+Ctrl+L".focus-monitor-right = _: { };

            "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = _: { };
            "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = _: { };
            "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = _: { };
            "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = _: { };
            "Mod+Shift+Ctrl+H".move-column-to-monitor-left = _: { };
            "Mod+Shift+Ctrl+J".move-column-to-monitor-down = _: { };
            "Mod+Shift+Ctrl+K".move-column-to-monitor-up = _: { };
            "Mod+Shift+Ctrl+L".move-column-to-monitor-right = _: { };

            "Mod+Page_Down".focus-workspace-down = _: { };
            "Mod+Page_Up".focus-workspace-up = _: { };
            "Mod+D".focus-workspace-down = _: { };
            "Mod+U".focus-workspace-up = _: { };

            "Mod+Ctrl+Page_Down".move-column-to-workspace-down = _: { };
            "Mod+Ctrl+Page_Up".move-column-to-workspace-up = _: { };
            "Mod+Ctrl+U".move-column-to-workspace-down = _: { };
            "Mod+Ctrl+D".move-column-to-workspace-up = _: { };

            "Mod+Shift+Page_Down".move-workspace-down = _: { };
            "Mod+Shift+Page_Up".move-workspace-up = _: { };
            "Mod+Shift+U".move-workspace-down = _: { };
            "Mod+Shift+D".move-workspace-up = _: { };

            "Mod+WheelScrollDown".focus-workspace-down = _: { };
            "Mod+WheelScrollUp".focus-workspace-up = _: { };
            "Mod+Ctrl+WheelScrollDown".move-column-to-workspace-down = _: { };
            "Mod+Ctrl+WheelScrollUp".move-column-to-workspace-up = _: { };
            "Mod+WheelScrollRight".focus-column-right = _: { };
            "Mod+WheelScrollLeft".focus-column-left = _: { };
            "Mod+Ctrl+WheelScrollRight".move-column-right = _: { };
            "Mod+Ctrl+WheelScrollLeft".move-column-left = _: { };
            "Mod+Shift+WheelScrollDown".focus-column-right = _: { };
            "Mod+Shift+WheelScrollUp".focus-column-left = _: { };
            "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = _: { };
            "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = _: { };

            "Mod+1".focus-workspace = "1";
            "Mod+2".focus-workspace = "2";
            "Mod+3".focus-workspace = "3";
            "Mod+4".focus-workspace = "4";
            "Mod+5".focus-workspace = "5";
            "Mod+6".focus-workspace = "6";
            "Mod+7".focus-workspace = "7";
            "Mod+8".focus-workspace = "8";
            "Mod+9".focus-workspace = "9";

            "Mod+Shift+1".move-column-to-workspace = "1";
            "Mod+Shift+2".move-column-to-workspace = "2";
            "Mod+Shift+3".move-column-to-workspace = "3";
            "Mod+Shift+4".move-column-to-workspace = "4";
            "Mod+Shift+5".move-column-to-workspace = "5";
            "Mod+Shift+6".move-column-to-workspace = "6";
            "Mod+Shift+7".move-column-to-workspace = "7";
            "Mod+Shift+8".move-column-to-workspace = "8";
            "Mod+Shift+9".move-column-to-workspace = "9";

            "Mod+BracketLeft".consume-or-expel-window-left = _: { };
            "Mod+BracketRight".consume-or-expel-window-right = _: { };
            "Mod+Comma".consume-window-into-column = _: { };
            "Mod+Period".expel-window-from-column = _: { };

            "Mod+R".switch-preset-column-width = _: { };
            "Mod+Shift+R".switch-preset-window-height = _: { };
            "Mod+Ctrl+R".reset-window-height = _: { };
            "Mod+F".maximize-column = _: { };
            "Mod+Shift+F".fullscreen-window = _: { };
            "Mod+Ctrl+F".expand-column-to-available-width = _: { };
            "Mod+C".center-column = _: { };
            "Mod+Ctrl+C".center-visible-columns = _: { };

            "Mod+Minus".set-column-width = "-10%";
            "Mod+Shift+Minus".set-window-height = "-10%";
            "Mod+Shift+Equal".set-window-height = "+10%";

            "Mod+V".toggle-window-floating = _: { };
            "Mod+Shift+V".switch-focus-between-floating-and-tiling = _: { };
            "Mod+W".toggle-column-tabbed-display = _: { };

            "Ctrl+Shift+S".screenshot = _: { };
            "Ctrl+Print".screenshot-screen = _: { };
            "Alt+Print".screenshot-window = _: { };

            "Mod+Escape".toggle-keyboard-shortcuts-inhibit = _: { };
            "Mod+Shift+E".quit = _: { };

            "Ctrl+Alt+Delete".spawn-sh = "${noctaliaExe} ipc call lockScreen lock";
            "Mod+Shift+P".power-off-monitors = _: { };
          };

          environment = {
            QT_QPA_PLATFORM = "wayland";
            QT_QPA_PLATFORMTHEME = "qt6ct";
          };
        };
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        imports = [ self.wrappersModules.niri ];
      };
    };
}
