{ config, pkgs, lib, ... }:

{
  imports = [ 
    ./desktop-hardware.nix
    ../modules/linux/linux-base.nix
  ];



  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname
  networking.hostName = "desktop";

  # Enable networking
  networking.networkmanager.enable = true;

  # Platform
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";

  # Time zone
  time.timeZone = "Australia/Melbourne";

  # Internationalisation
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Keymap
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };



  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Passwordless sudo for rsync (needed for make desktop/copy)
  security.sudo.extraRules = [{
    users = [ "eugene" ];
    commands = [{
      command = "/run/current-system/sw/bin/rsync";
      options = [ "NOPASSWD" ];
    }];
  }];


  # Graphics drivers
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];

  # System packages
  environment.systemPackages = with pkgs; [
    neovim
  ];

  programs.dconf.enable = true;
}
