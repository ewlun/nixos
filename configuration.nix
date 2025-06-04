{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./default.nix
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.edwin = {
    isNormalUser = true;
    description = "Edwin";
    extraGroups = [ "networkmanager" "wheel" "sound"];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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

  system.stateVersion = "24.11"; # Don't touch

}
