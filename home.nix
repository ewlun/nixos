{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
  allFilesIn = dir: builtins.listToAttrs (
    map (file: {
      name = "${baseNameOf dir}/${file}";
      value.source = dir + "/${file}";
    }) (builtins.attrNames (builtins.readDir dir))
  );
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.edwin = {
    home.stateVersion = "25.05";

    programs.bash = {
      enable = true;
      shellAliases = {
        config = "cd ~/.config/nixos/";
      };
    };

    programs.git = {
      enable = true;
      userName = "Edwin Lundmark";
      userEmail = "edwin.lundmark@icloud.com";

      ignores = [
        "*~"
        "*.swp"
      ];
      
      extraConfig = {
        init.defaultBranch = "main"; 
      };
    };

    xdg.configFile = allFilesIn ./stumpwm // {
      "emacs/init.el".source = ./emacs/init.el;
    };

    home.file = {
      ".roswell/local-projects/zbp-ttf".source = builtins.fetchTarball "http://www.xach.com/lisp/zpb-ttf.tgz";
      ".roswell/local-projects/clx-truetype".source = builtins.fetchGit "https://github.com/goose121/clx-truetype";

      ".config/stumpwm/modules".source = builtins.fetchGit "https://github.com/stumpwm/stumpwm-contrib";
    };

    programs.emacs.enable = true;
    home.file.".background-image".source = ./wallpapers/snowy;

    home.packages = with pkgs; [
      libtool
      libvterm

      roswell
      btop
      kitty
    ];
  };
}
