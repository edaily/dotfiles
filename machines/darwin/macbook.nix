{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # We install Nix using a separate installer so we don't want nix-darwin
  # to manage it for us. This tells nix-darwin to just use the existing
  # Nix installation.
  nix.enable = false;

  system.stateVersion = 6;
  system.primaryUser = "eugene";

  environment.shells = [ pkgs.nushell ];
  users.users.eugene.shell = pkgs.nushell;

  system.defaults = {
    dock.autohide = false;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.LoginwindowText = "nix-darwin";
    screencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
  };

  # Homebrew
  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;
  homebrew.global.brewfile = true;

  homebrew.taps = [ ];
  homebrew.brews = [ ];
  homebrew.casks =
    [ "1password" "1password-cli" "ghostty" "rectangle" "google-chrome" "discord" "balenaetcher" "whatsapp" ];
}
