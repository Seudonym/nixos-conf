{...}: {
  flake.nixosModules.userWahid = {
    inputs,
    pkgs,
    ...
  }: let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    imports = [
      inputs.spicetify-nix.nixosModules.default
    ];

    users.users.wahid = {
      isNormalUser = true;
      description = "Wahid Khan";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      shell = pkgs.fish;

      packages = with pkgs; [
        # desktop
        kitty
        vicinae
        brightnessctl
        gpu-screen-recorder
        kdePackages.kdeconnect-kde

        # utils
        chezmoi
        zoxide
        yazi
        eza
        dua
        duf
        fd
        ripgrep
        stow
        starship
        unzip
        sshfs
        vulkan-tools

        # media
        jamesdsp
        v4l-utils

        # dev
        gh
        git
        tree-sitter
        typescript-language-server
        lua-language-server
        stylua
        clang-tools
        biome
        nixd
        alejandra

        gcc

        codex
        gemini-cli
        opencode

        # android
        androidenv.androidPkgs.platform-tools
        scrcpy

        # daily driving
        onlyoffice-desktopeditors
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        qbittorrent
        gthumb
        nautilus
        discord
        aseprite
        lmstudio

        # theming
        morewaita-icon-theme
        nwg-look
        adw-gtk3

        # games
        ckan
        prismlauncher
        lutris

        # emacs
      ];
    };

    environment.localBinInPath = true;

    programs.fish.enable = true;
    programs.direnv.enable = true;

    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.comfy;
      enabledCustomApps = with spicePkgs.apps; [
        lyricsPlus
      ];
      enabledExtensions = with spicePkgs.extensions; [
        catJamSynced
        powerBar
        hidePodcasts
        fullAppDisplay
      ];
      colorScheme = "Comfy";
    };

    xdg.mime = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "org.gnome.Nautilus.desktop";
      };
    };
  };
}
