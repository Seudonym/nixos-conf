{...}: {
  flake.nixosModules.spicetify = {
    inputs,
    pkgs,
    ...
  }: let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    imports = [
      inputs.spicetify-nix.nixosModules.default
    ];

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
  };
}
