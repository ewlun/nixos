{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./default.nix
    ];

  users.users.edwin = {
    isNormalUser = true;
    description = "Edwin";
    extraGroups = [ "networkmanager" "wheel" "sound"];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    config = {
      user.name = "Edwin Lundmark";
      user.email = "edwin.lundmark@icloud.com";
      init.defaultBranch = "main"; 
    };

  };

  environment.systemPackages = with pkgs; [
    vim 

    emacs
    libtool
    libvterm

    gnumake
    gcc
    autoconf
    cmake

  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
