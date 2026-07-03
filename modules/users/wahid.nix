{ ... }:
{
  flake.nixosModules.userWahid =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      users.users.wahid = {
        isNormalUser = true;
        description = "Wahid Khan";
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "i2c"
          "ydotool"
        ];
        shell = pkgs.fish;

        packages = with pkgs; [
          # desktop
          kitty
          wezterm
          vicinae
          brightnessctl
          ddcutil
          gpu-screen-recorder
          kdePackages.kdeconnect-kde

          # utils
          chezmoi
          eza
          dua
          duf
          fd
          ripgrep
          unzip
          sshfs
          vulkan-tools
          tldr
          carapace

          # media
          jamesdsp
          v4l-utils

          # dev
          gh
          git
          jj
          tree-sitter
          typescript-language-server
          lua-language-server
          stylua
          tombi
          clang-tools
          biome
          nixd
          nixfmt
          gcc

          # ai
          codex
          opencode
          antigravity-cli

          # android
          androidenv.androidPkgs.platform-tools
          scrcpy

          # daily driving
          onlyoffice-desktopeditors
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
          qbittorrent
          gthumb
          mpv
          nautilus
          discord
          readest

          # theming
          morewaita-icon-theme
          nwg-look
          adw-gtk3

          # games
          prismlauncher
          lutris
          steam
        ];
      };
    };
}
