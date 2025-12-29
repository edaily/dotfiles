{ config, pkgs, lib, currentSystemUser, ... }:

{
  imports = [ ../common/nix-settings.nix ../common/fonts.nix ./wayland.nix ];

  services.xserver = { enable = true; };

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.niri}/bin/niri-session";
        user = "${currentSystemUser}";
      };
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${pkgs.niri}/bin/niri-session";
        user = "greeter";
      };
    };
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.PermitRootLogin = "yes";
}
