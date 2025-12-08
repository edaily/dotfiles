{ config, pkgs, lib, currentSystem, currentSystemName, currentSystemUser, ... }:

{
  imports = [ ../common/nix-settings.nix ../common/fonts.nix ./wayland.nix ];

  # Be careful updating this.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "0";
  networking.hostName = "dev";

  time.timeZone = "Australia/Melbourne";

  networking.useDHCP = false;
  networking.nameservers = [ "8.8.8.8" ];

  security.sudo.wheelNeedsPassword = false;

  virtualisation.docker.enable = true;
  virtualisation.lxd = { enable = true; };

  users.mutableUsers = false;

  environment.systemPackages = with pkgs;
    [
      cachix
      gnumake
      killall
      xclip
      ghostty
      swaybg

      # For hypervisors that support auto-resizing, this script forces it.
      # I've noticed not everyone listens to the udev events so this is a hack.
      # (writeShellScriptBin "xrandr-auto" ''
      #   xrandr --output Virtual-1 --auto
      # '')
    ] ++ lib.optionals (currentSystemName == "vm-aarch64") [
      # This is needed for the vmware user tools clipboard to work.
      # You can test if you don't need this by deleting this and seeing
      # if the clipboard sill works.
      gtkmm3
    ];

  services.xserver = { enable = true; };

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.niri}/bin/niri-session";
        user = "${currentSystemUser}";
      };
      default_session = {
        command =
          "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${pkgs.niri}/bin/niri-session";
        user = "greeter";
      };
    };
  };

  programs.hyprland = {
    enable = false;
    # withUWSM = true;
    # xwayland.enable = true;
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.PermitRootLogin = "yes";

  networking.firewall.enable = false;
  system.stateVersion = "20.09";
}

