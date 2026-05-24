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
  perSystem =
    { pkgs, ... }:
    {
      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {

          outputs = {
            "eDP-2" = {
              mode = "2560x1440@165.003";
              scale = 1.5;
              transform = "normal";
              position = _: {
                props = {
                  x = 960;
                  y = 1080;
                };
              };
            };
            "eDP-1" = {
              mode = "2560x1440@165.003";
              scale = 1.5;
              transform = "normal";
              position = _: {
                props = {
                  x = 960;
                  y = 1080;
                };
              };
            };
            "HDMI-A-1" = {
              mode = "1920x1080@60.000";
              scale = 1.0;
              transform = "normal";
              position = _: {
                props = {
                  x = 0;
                  y = 0;
                };
              };
            };
          };
        };
      };
    };
}
