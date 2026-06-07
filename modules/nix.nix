{ ... }:
{
  flake.nixosModules.nix =
    { ... }:
    {
      nix.settings = {
        experimental-features = "nix-command flakes";
        substituters = [
          "https://cache.flox.dev"
          "https://cache.nixos-cuda.org"
        ];
        trusted-public-keys = [
          "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
          "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
        ];
        trusted-users = [
          "root"
          "wahid"
        ];
      };
    };
}
