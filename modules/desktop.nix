{inputs, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: {
    # temporary build fix
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

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    environment.systemPackages = with pkgs; [
      neovim
      wget
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      gnome-keyring
      xwayland-satellite
      wl-clipboard
      libsForQt5.qt5ct
      qt6Packages.qt6ct

      wireguard-tools
      proton-vpn
      inputs.flox.packages.${pkgs.stdenv.hostPlatform.system}.default
      noctalia-shell
    ];

    services = {
      displayManager.ly.enable = true;
      gvfs.enable = true;
      udisks2.enable = true;
      printing.enable = true;
      power-profiles-daemon.enable = true;
      upower.enable = true;
      pulseaudio.enable = false;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };

    security = {
      polkit.enable = true;
      rtkit.enable = true;
    };

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
  };
}
