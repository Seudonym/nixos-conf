{
  flake.nixosModules.stt =
    { inputs, pkgs, ... }:
    {
      programs.ydotool.enable = true;
      systemd.user.services.whisper-type = {
        description = "Whisper STT Typer";
        wantedBy = [ "default.target" ];
        serviceConfig = {
          ExecStart = "${inputs.whisper-type.packages.${pkgs.system}.default}/bin/whisper-type";
          Restart = "on-failure";
          Environment = "YDOTOOL_SOCKET=/run/ydotoold/socket";
        };
      };
    };
}
