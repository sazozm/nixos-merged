{ ... }:

{
  flake.nixosModules.input = {
    services.libinput.enable = true;
  };
}
