{ ... }:
{
  flake.nixosModules.dns =
    { ... }:
    {
      networking = {
        networkmanager.dns = "none";
        nameservers = [
          "1.1.1.1"
          "8.8.8.8"
        ];
      };
    };
}
