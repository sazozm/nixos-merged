{ ... }:

{
  flake.nixosModules.nvidiaCrutch = { config, ... }: {
    systemd.services.nvidia-clock-floor = {
      description = "Set NVIDIA GPU core clock floor (idle stutter workaround)";
      wantedBy = [
        "multi-user.target"
        "suspend.target"
      ];
      after = [ "suspend.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = [
          "-${config.hardware.nvidia.package.bin}/bin/nvidia-smi -pm 1"
          "${config.hardware.nvidia.package.bin}/bin/nvidia-smi -lgc 1020,2145"
        ];
      };
    };
  };
}
