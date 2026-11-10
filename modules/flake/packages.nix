{ inputs, ... }:

{
  perSystem = { pkgs, ... }: {
    packages.vimyt = pkgs.buildGoModule {
      pname = "vimyt";
      version = "latest";
      src = inputs.vimyt-src;
      vendorHash = "sha256-6Zibdxho7RLXvRH5LL5r+f7z+v5aLmjo0PMSQr27OGQ=";
    };
  };
}
