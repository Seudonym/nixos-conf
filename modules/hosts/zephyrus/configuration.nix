{ self, inputs, ... }:
{
  flake.nixosModules.zephyrusConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.zephyrusHardware
        self.nixosModules.desktop
        self.nixosModules.userWahid
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking = {
        networkmanager.enable = true;
        hostName = "zephyrus";
        networkmanager.dns = "none";
        firewall = {
          enable = true;
          allowedTCPPorts = [ 25565 ];
          allowedUDPPorts = [ 25565 ];
          allowedTCPPortRanges = [
            {
              from = 1714;
              to = 1764;
            }
          ];
          allowedUDPPortRanges = [
            {
              from = 1714;
              to = 1764;
            }
          ];
        };
        nameservers = [
          "1.1.1.1"
          "8.8.8.8"
        ];
      };

      time.timeZone = "Asia/Kolkata";

      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };

      services = {
        xserver = {
          xkb = {
            layout = "us";
            variant = "";
          };
          videoDrivers = [
            "amdgpu"
            "nvidia"
          ];
        };

        displayManager.gdm.enable = true;
        gvfs.enable = true;
        udisks2.enable = true;
        printing.enable = true;
        power-profiles-daemon.enable = true;
        upower.enable = true;
        pulseaudio.enable = false;
        cloudflare-warp.enable = true;
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

      virtualisation.docker.enable = true;
      programs.nix-ld.enable = true;

      hardware = {
        bluetooth.enable = true;
        nvidia-container-toolkit.enable = true;
        graphics.enable = true;
        graphics.enable32Bit = true;
        nvidia = {
          open = true;
          modesetting.enable = true;
          powerManagement.enable = true;
          powerManagement.finegrained = true;
          prime = {
            offload = {
              enable = true;
              enableOffloadCmd = true;
            };
            amdgpuBusId = "PCI:6:0:0";
            nvidiaBusId = "PCI:1:0:0";
          };
        };
      };

      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.permittedInsecurePackages = [
        "openssl-1.1.1w"
      ];
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      xdg.terminal-exec = {
        enable = true;
        settings = {
          default = [
            "kitty.desktop"
          ];
        };
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
      ];

      system.stateVersion = "25.11";
    };
}
