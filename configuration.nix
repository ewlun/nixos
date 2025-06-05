{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./default.nix
      ./home.nix
    ];

  users.users.edwin = {
    isNormalUser = true;
    description = "Edwin";
    extraGroups = [ "networkmanager" "wheel" "sound"];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  #services.xserver.windowManager.stumpwm.enable = true;

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
    gnumake
    gcc
    autoconf
    cmake
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
