{ self, inputs, ... }:
{
  flake.nixosModules.desktop =
    { inputs, pkgs, ... }:

    {
      imports = [
        inputs.niri.nixosModules.niri
      ];

      nixpkgs.overlays = [
        inputs.niri.overlays.niri
        (_: prev: {
          openldap = prev.openldap.overrideAttrs {
            doCheck = !prev.stdenv.hostPlatform.isi686;
          };
        })
      ];

      programs.niri = {
        enable = true;
      };

      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      services.xserver.videoDrivers = [
        "amdgpu"
        "nvidia"
      ];

      fonts = {
        packages = with pkgs; [
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-color-emoji
          liberation_ttf
          nerd-fonts.victor-mono
          roboto
          corefonts
          vista-fonts
        ];

        fontconfig.defaultFonts = {
          serif = [
            "Liberation Serif"
            "Vazirmatn"
          ];
          sansSerif = [
            "Ubuntu"
            "Vazirmatn"
          ];
          monospace = [ "Ubuntu Mono" ];
        };
      };

      environment.systemPackages = [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
