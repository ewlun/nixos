{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.edwin = {
    home.stateVersion = "24.11";

    home.packages = [
      emacs
      libtool
      libvterm

      roswell
    ];
  };
}
