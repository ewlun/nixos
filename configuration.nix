{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./default.nix
      ./home.nix
    ];

  # Garbage collect every day
  nix.gc.automatic = true;

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

  services.xserver.windowManager.stumpwm.enable = true;
  services.picom = {
    enable = true;
    vSync = true;
  };
  
  services.xserver.dpi = 144; # Real value is 242
  services.xserver.enableTearFree = true;

  # Optional fine-tuning:
  services.xserver.libinput.touchpad = {
    naturalScrolling = true;
    tapping = true;
    scrollMethod = "twofinger";
    accelProfile = "adaptive";
    accelSpeed = "0.3"; # between -1 and 1
    #accelStepScroll = 0.05;
  };
  

  programs.firefox.enable = true;
  
  environment.systemPackages = with pkgs; [
    xclip
    vim
    gnumake
    gcc
    autoconf
    cmake
    python3
    bc
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
