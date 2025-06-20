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

  services.xserver.windowManager.stumpwm = {
    enable = true;
    package = pkgs.writeScriptBin "stumpwm" ''
      #!/bin/sh
      #|-*- mode:lisp -*-|#
      #|
      exec ros -Q -- $0 "$@"
      |#
      (progn 
        #+quicklisp (ql:quickload '(stumpwm) :silent t))
      
      (defpackage :ros.script.stumpwm.3749863733
        (:use :cl))
      (in-package :ros.script.stumpwm.3749863733)
      
      (defun main (&rest argv)
        (declare (ignorable argv))
        (stumpwm:stumpwm))
    '';
  };
  
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    settings = {
      blur = {
        method = "dual_kawase";
        strength = 2;
      };
    };
  };

  services.xserver.desktopManager.wallpaper.mode = "fill";
  
  services.xserver.dpi = 200; # Real value is 242. Bigger number, bigger UI
  services.xserver.enableTearFree = true;

  # Optional fine-tuning:
  services.xserver.libinput.touchpad = {
    naturalScrolling = true;
    tapping = true;
    scrollMethod = "twofinger";
    accelProfile = "adaptive";
    accelSpeed = "0.3"; # between -1 and 1
    accelStepScroll = 0.05;
  };

  environment.variables = {
    MOZ_USE_XINPUT2 = 1;
    PATH = "$HOME/.roswell/bin:$PATH";
    ROSWELL_HOME = "$HOME/.roswell";
  };

  fonts.fontDir.enable = true;

  programs.firefox.enable = true;
  
  environment.systemPackages = with pkgs; [
    xclip
    vim
    gnumake
    gcc
    autoconf
    cmake
    python3
    busybox
    terminus_font
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
