{ ... }:
{
  flake.nixosModules.dev =
    { ... }:
    {
      virtualisation.docker.enable = true;
      programs.nix-ld.enable = true;
      environment.localBinInPath = true;
      programs.fish.enable = true;
      programs.starship.enable = true;
      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
      };
      programs.direnv.enable = true;
      programs.ydotool.enable = true;
    };
}
