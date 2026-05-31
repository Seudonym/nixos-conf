{...}: {
  flake.nixosModules.desktop = {pkgs, ...}: {
    nixpkgs.overlays = [
      (final: prev: {
        openldap = prev.openldap.overrideAttrs {
          doCheck = !prev.stdenv.hostPlatform.isi686;
        };
      })
    ];

    programs.niri = {
      enable = true;
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
        nerd-fonts.iosevka-term
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
        monospace = ["Ubuntu Mono"];
      };
    };

    environment.systemPackages = with pkgs; [
      noctalia-shell
    ];
  };
}
