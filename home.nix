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

    home.file.".config/stumpwm/config".source = ./stumpwm/config;

    programs.emacs.enable = true;
    home.file.".config/emacs/init.el".source = ./emacs/init.el;
    
    home.file.".vimrc".text = "colorscheme blue";

    home.packages = with pkgs; [
      libtool
      libvterm

      roswell
      btop
    ];
  };
}
